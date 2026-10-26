using System.Collections.Generic;
using System.Diagnostics;
using AnimatorLayerManagement;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Modules;
using InventorySystem.Items.Thirdperson;
using InventorySystem.Items.Thirdperson.LayerProcessors;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Thirdperson
{
	public class FirearmThirdpersonItem : ThirdpersonItemBase, ILookatModifier, IHandPoseModifier
	{
		private enum FirearmAnim
		{
			Ads = 0,
			Hip = 1,
			Reload = 2
		}

		private readonly Dictionary<Light, Color> _defaultColors = new Dictionary<Light, Color>();

		private readonly Stopwatch _reloadElapsed = Stopwatch.StartNew();

		private const float DefaultEquipTime = 0.5f;

		private const float BlendTransitionSpeed = 4f;

		[SerializeField]
		private AnimationClip _hipAnim;

		[SerializeField]
		private AnimationClip _adsAnim;

		[SerializeField]
		private AnimationClip _reloadAnim;

		[SerializeField]
		private AnimOverrideState3pPair[] _additionalOverrideClips;

		[SerializeField]
		private bool _isAdsing;

		[SerializeField]
		private bool _isReloading;

		[SerializeField]
		private float _maxReloadTimeSeconds;

		[SerializeField]
		private LayerProcessorBase _regularLayerProcessor;

		[SerializeField]
		private LayerProcessorBase _reloadLayerProcessor;

		[Header("Inverse Kinematics")]
		[SerializeField]
		private LayerRefId _ikLayerRightHand;

		[SerializeField]
		private LayerRefId _ikLayerLeftHand;

		[SerializeField]
		private float _bodyIkMultiplier;

		[SerializeField]
		private float _bodyIkAbsolute;

		[SerializeField]
		private Vector3 _localPosition;

		[SerializeField]
		private Vector3 _localRotation;

		[SerializeField]
		private LeftHandIKHandler _leftHandIK;

		[SerializeField]
		private RightHandIKHandler _rightHandIK;

		[SerializeField]
		private bool _editorPauseIK;

		private float _prevAdsBlend;

		private bool _shotReceived;

		private bool _eventAssigned;

		private float _lastReloadBlend;

		private Firearm _template;

		public bool WorldmodelInstanceSet { get; private set; }

		public FirearmWorldmodel WorldmodelInstance { get; private set; }

		public override float GetTransitionTime(ItemIdentifier iid)
		{
			if (!InventoryItemLoader.TryGetItem<Firearm>(iid.TypeId, out var result))
			{
				return 0.5f;
			}
			if (!result.TryGetModule<IEquipperModule>(out var module))
			{
				return 0.5f;
			}
			return Mathf.Min(module.DisplayBaseEquipTime, 0.5f);
		}

		public override ThirdpersonLayerWeight GetWeightForLayer(AnimItemLayer3p layer)
		{
			ThirdpersonLayerWeight weightForLayer = _regularLayerProcessor.GetWeightForLayer(this, layer);
			ThirdpersonLayerWeight weightForLayer2 = _reloadLayerProcessor.GetWeightForLayer(this, layer);
			return ThirdpersonLayerWeight.Lerp(weightForLayer, weightForLayer2, _lastReloadBlend);
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_isReloading = false;
			_isAdsing = false;
			UnsubscribeEvents();
		}

		public LookatData ProcessLookat(LookatData data)
		{
			data.BodyWeight = Mathf.Clamp01(data.BodyWeight * _bodyIkMultiplier + _bodyIkAbsolute);
			if (_lastReloadBlend > 0f)
			{
				float a = Mathf.Clamp01(1f - _lastReloadBlend);
				a = Mathf.Lerp(a, 1f, Mathf.Abs(data.LookDir.y / 2f));
				data.GlobalWeight *= a;
			}
			return data;
		}

		public HandPoseData ProcessHandPose(HandPoseData data)
		{
			data = _leftHandIK.ProcessHandPose(data);
			data = _rightHandIK.ProcessHandPose(data);
			return data;
		}

		protected override void Update()
		{
			base.Update();
			if (!base.Pooled)
			{
				UpdateAnims();
			}
		}

		internal override void OnFadeChanged(float newFade)
		{
			base.OnFadeChanged(newFade);
			foreach (KeyValuePair<Light, Color> defaultColor in _defaultColors)
			{
				defaultColor.Key.color = Color.Lerp(Color.black, defaultColor.Value, newFade);
			}
		}

		internal override void Initialize(InventorySubcontroller srctr, ItemIdentifier id)
		{
			if (!WorldmodelInstanceSet && InventoryItemLoader.TryGetItem<Firearm>(id.TypeId, out _template))
			{
				WorldmodelInstance = Object.Instantiate(_template.WorldModel, base.transform);
				WorldmodelInstance.transform.SetLocalPositionAndRotation(_localPosition, Quaternion.Euler(_localRotation));
				WorldmodelInstanceSet = true;
			}
			if (!_eventAssigned)
			{
				AttachmentCodeSync.OnReceived += OnAttachmentsUpdated;
				_eventAssigned = true;
			}
			base.Initialize(srctr, id);
			WorldmodelInstance.Setup(base.ItemId, srctr.Model.HasOwner ? FirearmWorldmodelType.Thirdperson : FirearmWorldmodelType.Presentation);
			SetAnim(AnimState3p.Override1, _hipAnim);
			SetAnim(AnimState3p.Override0, _adsAnim);
			SetAnim(AnimState3p.Override2, _reloadAnim);
			_additionalOverrideClips.ForEach(base.SetAnim);
			_rightHandIK.Initialize(WorldmodelInstance, base.TargetModel);
			_leftHandIK.Initialize(WorldmodelInstance, base.TargetModel);
			base.OverrideBlend = 1f;
		}

		internal override void OnAnimIK(int layerIndex, float ikScale)
		{
			base.OnAnimIK(layerIndex, ikScale);
			ikScale = Mathf.Clamp01(ikScale - _lastReloadBlend);
			AnimatorLayerManager layerManager = base.TargetModel.LayerManager;
			if (layerIndex == layerManager.GetLayerIndex(_ikLayerRightHand))
			{
				_rightHandIK.IKUpdateRightHandRotation(ikScale, _prevAdsBlend);
			}
			if (layerIndex == layerManager.GetLayerIndex(_ikLayerLeftHand))
			{
				_leftHandIK.IKUpdateLeftHandAnchor(ikScale);
			}
		}

		private void OnAttachmentsUpdated(ushort serial, uint code)
		{
			if (WorldmodelInstanceSet && serial == base.ItemId.SerialNumber)
			{
				WorldmodelInstance.Setup(base.ItemId, FirearmWorldmodelType.Thirdperson, code);
			}
		}

		private void Awake()
		{
			Light[] componentsInChildren = GetComponentsInChildren<Light>(includeInactive: true);
			foreach (Light light in componentsInChildren)
			{
				_defaultColors[light] = light.color;
			}
		}

		private void OnDestroy()
		{
			UnsubscribeEvents();
		}

		private void UnsubscribeEvents()
		{
			if (_eventAssigned)
			{
				AttachmentCodeSync.OnReceived -= OnAttachmentsUpdated;
				_eventAssigned = false;
			}
		}

		private void UpdateAnims()
		{
			FirearmAnim firearmAnim = ((_isReloading && _reloadElapsed.Elapsed.TotalSeconds < (double)_maxReloadTimeSeconds) ? FirearmAnim.Reload : ((!_isAdsing) ? FirearmAnim.Hip : FirearmAnim.Ads));
			base.OverrideBlend = Mathf.MoveTowards(base.OverrideBlend, (float)firearmAnim, Time.deltaTime * 4f);
			_prevAdsBlend = Mathf.Clamp01(1f - base.OverrideBlend);
			_lastReloadBlend = base.OverrideBlend - 2f + 1f;
			if (_shotReceived)
			{
				_shotReceived = false;
			}
			if (_template.TryGetModule<IAdsModule>(out var module))
			{
				module.GetDisplayAdsValues(base.ItemId.SerialNumber, out _isAdsing, out var _);
			}
			if (_template.TryGetModule<IReloaderModule>(out var module2))
			{
				bool isReloading = _isReloading;
				_isReloading = module2.GetDisplayReloadingOrUnloading(base.ItemId.SerialNumber);
				if (_isReloading && !isReloading)
				{
					_reloadElapsed.Restart();
					ReplayOverrideBlend(soft: true);
				}
			}
		}
	}
}

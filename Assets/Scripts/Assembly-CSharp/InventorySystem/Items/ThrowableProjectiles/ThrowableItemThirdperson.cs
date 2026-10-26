using InventorySystem.Items.Thirdperson;
using InventorySystem.Items.Thirdperson.LayerProcessors;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using UnityEngine;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public class ThrowableItemThirdperson : ThirdpersonItemBase, IHandPoseModifier, ILookatModifier
	{
		[SerializeField]
		private AnimationClip _idleClip;

		[SerializeField]
		private AnimationClip _beginClip;

		[SerializeField]
		private AnimationClip _throwClip;

		[SerializeField]
		private HandPoseData _rightHandPose;

		[SerializeField]
		private GameObject _gfxToDisable;

		[SerializeField]
		private HybridLayerProcessor _layerProcessor;

		private float _targetWeight;

		private float _remainingActiveTime;

		private bool _isThrowing;

		private float _lastWeight;

		private const float WeightIncreaseSpeed = 8.5f;

		private const float WeightDecreaseSpeed = 3.5f;

		private const float ThrowingTime = 0.22f;

		public override ThirdpersonLayerWeight GetWeightForLayer(AnimItemLayer3p layer)
		{
			return _layerProcessor.GetWeightForLayer(this, layer);
		}

		public virtual HandPoseData ProcessHandPose(HandPoseData data)
		{
			return _rightHandPose;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_targetWeight = 0f;
			_lastWeight = 0f;
			_isThrowing = false;
			_gfxToDisable.SetActive(value: true);
		}

		internal override void Initialize(InventorySubcontroller subcontroller, ItemIdentifier id)
		{
			base.Initialize(subcontroller, id);
			SetAnim(AnimState3p.Override0, _idleClip);
		}

		protected override void Update()
		{
			base.Update();
			if (!base.Pooled)
			{
				if (_lastWeight != _targetWeight)
				{
					float num = ((_targetWeight > _lastWeight) ? 8.5f : 3.5f);
					float num2 = Mathf.MoveTowards(_lastWeight, _targetWeight, Time.deltaTime * num);
					_layerProcessor.SetDualHandBlend(num2);
					_lastWeight = num2;
					base.OverrideBlend = num2;
				}
				if (_isThrowing)
				{
					_remainingActiveTime -= Time.deltaTime;
					_gfxToDisable.SetActive(_remainingActiveTime > 0f);
				}
			}
		}

		private void Awake()
		{
			ThrowableNetworkHandler.OnAudioMessageReceived += ProcessRequest;
		}

		private void OnDestroy()
		{
			ThrowableNetworkHandler.OnAudioMessageReceived -= ProcessRequest;
		}

		private void ProcessRequest(ThrowableNetworkHandler.ThrowableItemAudioMessage msg)
		{
			if (!base.Pooled && base.ItemId.SerialNumber == msg.Serial)
			{
				switch (msg.Request)
				{
				case ThrowableNetworkHandler.RequestType.BeginThrow:
					PlayAnim(_beginClip);
					break;
				case ThrowableNetworkHandler.RequestType.CancelThrow:
					_isThrowing = false;
					_targetWeight = 0f;
					break;
				case ThrowableNetworkHandler.RequestType.ConfirmThrowWeak:
				case ThrowableNetworkHandler.RequestType.ConfirmThrowFullForce:
					PlayAnim(_throwClip);
					_remainingActiveTime = 0.22f;
					_isThrowing = true;
					break;
				}
			}
		}

		private void PlayAnim(AnimationClip clip)
		{
			_targetWeight = 1f;
			SetAnim(AnimState3p.Override1, clip);
			ReplayOverrideBlend(soft: false);
		}

		public LookatData ProcessLookat(LookatData data)
		{
			data.BodyWeight = Mathf.Clamp01(data.BodyWeight + _lastWeight);
			return data;
		}
	}
}

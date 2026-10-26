using System.Collections.Generic;
using CustomRendering;
using InventorySystem.Items.Firearms.Modules;
using Mirror;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class DisruptorScopeTrackerExtension : MonoBehaviour, IViewmodelExtension
	{
		private struct TargetIndicator
		{
			public GameObject GameObject;

			public RectTransform Transform;

			public Image Image;

			public uint NetId;

			public double CreationTime;

			public readonly float ActiveElapsed => (float)(NetworkTime.time - CreationTime);

			public TargetIndicator(RectTransform newInstance, uint netId)
			{
				Transform = newInstance;
				GameObject = Transform.gameObject;
				Image = Transform.GetComponent<Image>();
				NetId = netId;
				CreationTime = NetworkTime.time;
			}

			public TargetIndicator(TargetIndicator other, uint newNetId)
			{
				GameObject = other.GameObject;
				Transform = other.Transform;
				Image = other.Image;
				NetId = newNetId;
				CreationTime = NetworkTime.time;
			}
		}

		private static readonly CachedLayerMask HitboxMask = new CachedLayerMask("Hitbox");

		[SerializeField]
		private Camera _mainCamera;

		[SerializeField]
		private AnimationCurve _opacityOverFog;

		[SerializeField]
		private AnimationCurve _sizeOverDistance;

		[SerializeField]
		private AnimationCurve _opacityOverDistance;

		[SerializeField]
		private float _friendlyOpacity;

		[SerializeField]
		private float _enemyOpacity;

		[SerializeField]
		private RectTransform _targetIndicatorTemplate;

		[SerializeField]
		private Vector2 _canvasScale;

		[SerializeField]
		private float _extraFogRange;

		private ReferenceHub _owner;

		private IAdsModule _adsModule;

		private readonly List<TargetIndicator> _activeIndicators = new List<TargetIndicator>();

		private readonly Queue<TargetIndicator> _indicatorPool = new Queue<TargetIndicator>();

		private readonly HashSet<uint> _detectedNetIds = new HashSet<uint>();

		public void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			_owner = viewmodel.ParentFirearm.Owner;
			viewmodel.ParentFirearm.TryGetModule<IAdsModule>(out _adsModule);
		}

		private void LateUpdate()
		{
			if (!_mainCamera.gameObject.activeInHierarchy)
			{
				foreach (TargetIndicator activeIndicator in _activeIndicators)
				{
					activeIndicator.GameObject.SetActive(value: false);
					_indicatorPool.Enqueue(activeIndicator);
				}
				_activeIndicators.Clear();
				return;
			}
			_mainCamera.transform.GetPositionAndRotation(out var position, out var rotation);
			Vector3 lhs = rotation * Vector3.forward;
			float num = FogController.FogFarPlaneDistance + _extraFogRange;
			float num2 = num * num;
			_detectedNetIds.Clear();
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (!(allHub.roleManager.CurrentRole is IFpcRole fpcRole) || allHub == _owner)
				{
					continue;
				}
				Vector3 rhs = fpcRole.FpcModule.Position - position;
				if (!(rhs.sqrMagnitude > num2) && !(Vector3.Dot(lhs, rhs) < 0f) && TryGetBestPos(position, allHub.netId, fpcRole.FpcModule, out var pos))
				{
					Vector3 viewportPos = _mainCamera.WorldToViewportPoint(pos);
					if (!(viewportPos.x < 0f) && !(viewportPos.x > 1f) && !(viewportPos.y < 0f) && !(viewportPos.y > 1f))
					{
						_detectedNetIds.Add(allHub.netId);
						UpdateIndicator(viewportPos, allHub);
					}
				}
			}
			RePoolUnusedIndicators();
		}

		private void UpdateIndicator(Vector3 viewportPos, ReferenceHub target)
		{
			float num = (HitboxIdentity.IsEnemy(_owner, target) ? _enemyOpacity : _friendlyOpacity);
			num *= _opacityOverFog.Evaluate(viewportPos.z / Mathf.Max(_extraFogRange, FogController.FogFarPlaneDistance + _extraFogRange));
			num *= _opacityOverDistance.Evaluate(viewportPos.z);
			num *= _adsModule.AdsAmount;
			Color roleColor = target.roleManager.CurrentRole.RoleColor;
			TargetIndicator indicatorForPlayer = GetIndicatorForPlayer(target.netId);
			indicatorForPlayer.Image.color = new Color(roleColor.r, roleColor.g, roleColor.b, num);
			indicatorForPlayer.Transform.anchoredPosition = Vector2.Scale(viewportPos, _canvasScale);
			indicatorForPlayer.Transform.localScale = Vector3.one * _sizeOverDistance.Evaluate(viewportPos.z);
		}

		private TargetIndicator GetIndicatorForPlayer(uint netId)
		{
			foreach (TargetIndicator activeIndicator in _activeIndicators)
			{
				if (activeIndicator.NetId == netId)
				{
					return activeIndicator;
				}
			}
			TargetIndicator targetIndicator;
			if (_indicatorPool.TryDequeue(out var result))
			{
				targetIndicator = new TargetIndicator(result, netId);
			}
			else
			{
				RectTransform newInstance = Object.Instantiate(_targetIndicatorTemplate, _targetIndicatorTemplate.parent);
				targetIndicator = new TargetIndicator(newInstance, netId);
			}
			_activeIndicators.Add(targetIndicator);
			targetIndicator.GameObject.SetActive(value: true);
			return targetIndicator;
		}

		private void RePoolUnusedIndicators()
		{
			for (int num = _activeIndicators.Count - 1; num >= 0; num--)
			{
				TargetIndicator item = _activeIndicators[num];
				if (!_detectedNetIds.Contains(item.NetId))
				{
					item.GameObject.SetActive(value: false);
					_indicatorPool.Enqueue(item);
					_activeIndicators.RemoveAt(num);
				}
			}
		}

		private bool TryGetBestPos(Vector3 mainCamPos, uint netId, FirstPersonMovementModule fpc, out Vector3 pos)
		{
			pos = fpc.Position;
			if (fpc.CharacterModelInstance == null)
			{
				return false;
			}
			Vector3? vector = null;
			float num = float.MaxValue;
			HitboxIdentity[] hitboxes = fpc.CharacterModelInstance.Hitboxes;
			for (int i = 0; i < hitboxes.Length; i++)
			{
				Vector3 centerOfMass = hitboxes[i].CenterOfMass;
				float sqrMagnitude = (centerOfMass - pos).sqrMagnitude;
				if (!(sqrMagnitude > num) && CheckLineOfSight(mainCamPos, centerOfMass, netId))
				{
					vector = centerOfMass;
					num = sqrMagnitude;
				}
			}
			if (!vector.HasValue)
			{
				return CheckLineOfSight(mainCamPos, pos, netId);
			}
			pos = vector.Value;
			return true;
		}

		private bool CheckLineOfSight(Vector3 origin, Vector3 pos, uint netId)
		{
			if (Physics.Linecast(origin, pos, PlayerRolesUtils.LineOfSightMask))
			{
				return false;
			}
			if (!Physics.Linecast(origin, pos, out var hitInfo, HitboxMask))
			{
				return false;
			}
			if (!hitInfo.collider.TryGetComponent<HitboxIdentity>(out var component))
			{
				return false;
			}
			if (component.NetworkId != netId)
			{
				return false;
			}
			return true;
		}
	}
}

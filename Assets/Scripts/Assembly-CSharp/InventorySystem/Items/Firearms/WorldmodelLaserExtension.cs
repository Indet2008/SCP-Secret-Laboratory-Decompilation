using System.Collections.Generic;
using System.Linq;
using InventorySystem.Items.Firearms.Extensions;
using InventorySystem.Items.Firearms.Thirdperson;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;

namespace InventorySystem.Items.Firearms
{
	[PresetPrefabExtension("Laser Worldmodel", true)]
	public class WorldmodelLaserExtension : MonoBehaviour, IWorldmodelExtension
	{
		private static readonly CachedLayerMask Mask = new CachedLayerMask("Default", "Hitbox", "Ragdoll", "CCTV", "Grenade", "Door", "InteractableNoPlayerCollision");

		private const float LaserPickupRange = 8f;

		private const float LaserThirdpersonRange = 30f;

		private const float FadeDistance = 5f;

		private const float ThirdpersonCamBiasMin = 1.3f;

		private const float ThirdpersonCamBiasMax = 3.2f;

		private const float CameraFwdOffset = 0.8f;

		private const float PotentialCollisionDistance = 1.5f;

		private const int FadePower = 3;

		private FirearmThirdpersonItem _thirdperson;

		private HashSet<int> _selfColliderInstanceIds;

		private List<Collider> _collidersToDisable;

		private Transform _originTransform;

		private Transform _decalTransform;

		private bool _pickupMode;

		private RaycastHit _lastHit;

		private float _range;

		private bool _hasBarrelTip;

		private BarrelTipExtension _barrelTipExtension;

		[SerializeField]
		private DecalProjector _decal;

		private void LateUpdate()
		{
			bool flag = (_pickupMode ? UpdatePickup() : UpdateThirdperson());
			_decal.enabled = flag;
			if (flag)
			{
				_decalTransform.position = _lastHit.point;
				float num = (_range - _lastHit.distance) * 0.2f;
				for (int i = 0; i < 3; i++)
				{
					num *= num;
				}
				_decal.fadeFactor = num;
			}
		}

		private void GetOrigin(out Vector3 pos, out Vector3 fwd)
		{
			if (_hasBarrelTip)
			{
				pos = _barrelTipExtension.WorldspacePosition;
				fwd = _barrelTipExtension.WorldspaceDirection;
			}
			else
			{
				fwd = _originTransform.position;
				pos = _originTransform.forward;
			}
		}

		private bool UpdatePickup()
		{
			GetOrigin(out var pos, out var fwd);
			return TryRaycast(pos, fwd, out _lastHit);
		}

		private bool UpdateThirdperson()
		{
			GetOrigin(out var pos, out var fwd);
			if (!TryRaycast(pos, fwd, out var hit))
			{
				return false;
			}
			if (hit.distance < 1.3f)
			{
				_lastHit = hit;
				return true;
			}
			Transform playerCameraReference = _thirdperson.TargetModel.OwnerHub.PlayerCameraReference;
			Vector3 forward = playerCameraReference.forward;
			Vector3 vector = playerCameraReference.position + forward * 0.8f;
			if (!TryRaycast(vector, forward, out var hit2))
			{
				return false;
			}
			float t = Mathf.InverseLerp(1.3f, 3.2f, hit2.distance);
			Vector3 pos2 = Vector3.Lerp(pos, vector, t);
			return TryRaycast(pos2, forward, out _lastHit);
		}

		private bool TryRaycast(Vector3 pos, Vector3 fwd, out RaycastHit hit)
		{
			SetColliders(targetEnabled: false);
			bool flag;
			while (true)
			{
				flag = Physics.Raycast(pos, fwd, out hit, _range, Mask);
				if (!flag || hit.distance > 1.5f || !_selfColliderInstanceIds.Contains(hit.colliderInstanceID))
				{
					break;
				}
				Collider collider = hit.collider;
				collider.enabled = false;
				_collidersToDisable.Add(collider);
			}
			SetColliders(targetEnabled: true);
			return flag;
			void SetColliders(bool targetEnabled)
			{
				int count = _collidersToDisable.Count;
				for (int i = 0; i < count; i++)
				{
					_collidersToDisable[i].enabled = targetEnabled;
				}
			}
		}

		public void SetupWorldmodel(FirearmWorldmodel worldmodel)
		{
			_originTransform = base.transform;
			_decalTransform = _decal.transform;
			_pickupMode = !_originTransform.TryGetComponentInParent<FirearmThirdpersonItem>(out _thirdperson);
			_range = (_pickupMode ? 8f : 30f);
			_hasBarrelTip = worldmodel.TryGetExtension<BarrelTipExtension>(out _barrelTipExtension);
			if (_selfColliderInstanceIds == null)
			{
				_collidersToDisable = new List<Collider>(worldmodel.Colliders.Length);
				_selfColliderInstanceIds = new HashSet<int>(worldmodel.Colliders.Select((Collider x) => x.GetInstanceID()));
			}
		}
	}
}

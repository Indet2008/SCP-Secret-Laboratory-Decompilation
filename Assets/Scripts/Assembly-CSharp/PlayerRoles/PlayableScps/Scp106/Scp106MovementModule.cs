using System;
using Interactables.Interobjects.DoorUtils;
using MapGeneration.Distributors;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp106
{
	public class Scp106MovementModule : FirstPersonMovementModule, IFpcCollisionModifier
	{
		[SerializeField]
		private float _stalkSpeed;

		private const float SubmergingLerp = 1.5f;

		private const int GlassLayer = 14;

		private const int DoorLayer = 27;

		private const float SlowdownTransitionSpeed = 5.5f;

		private const float SpeedBoostDuration = 5f;

		private const float SpeedBoostMultiplier = 1.175f;

		private float _slowndownTarget;

		private float _slowndownSpeed;

		private float _normalSpeed;

		private float _remainingSpeedBoostDuration;

		private Scp106SinkholeController _sinkhole;

		public static readonly int PassableDetectionMask = 134234112;

		private float MovementSpeed
		{
			get
			{
				return WalkSpeed;
			}
			set
			{
				SneakSpeed = value;
				WalkSpeed = value;
				SprintSpeed = value;
			}
		}

		public float CurSlowdown { get; private set; }

		public LayerMask DetectionMask => PassableDetectionMask;

		public static float GetSlowdownFromCollider(Collider col, out bool isPassable)
		{
			isPassable = false;
			if (col.transform.TryGetComponentInParent<DoorVariant>(out var comp))
			{
				if (!(comp is IScp106PassableDoor scp106PassableDoor))
				{
					return 0f;
				}
				if (!scp106PassableDoor.IsScp106Passable)
				{
					return 0f;
				}
				isPassable = true;
				float exactState = comp.GetExactState();
				if (exactState <= 0f)
				{
					SpawnablesDistributorBase.ServerSpawnForAllDoor(comp);
				}
				return Mathf.Clamp01(1f - exactState);
			}
			if (col.gameObject.layer == 14 && col is BoxCollider)
			{
				isPassable = true;
				return 1f;
			}
			return 0f;
		}

		private void Awake()
		{
			_slowndownSpeed = SneakSpeed;
			_normalSpeed = WalkSpeed;
			MovementSpeed = _normalSpeed;
		}

		private void Update()
		{
			float deltaTime = Time.deltaTime;
			CurSlowdown = Mathf.MoveTowards(CurSlowdown, _slowndownTarget, deltaTime * 5.5f);
			float num;
			if (_sinkhole.IsDuringAnimation)
			{
				num = Mathf.Lerp(MovementSpeed, 0f, 1.5f * deltaTime);
			}
			else
			{
				float num2 = Mathf.Lerp(_normalSpeed, _slowndownSpeed, CurSlowdown);
				num = (_sinkhole.TargetSubmerged ? _stalkSpeed : num2);
			}
			if (_remainingSpeedBoostDuration > 0f)
			{
				_remainingSpeedBoostDuration -= deltaTime;
				num *= 1.175f;
			}
			MovementSpeed = num;
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			Scp106Role scp106Role = base.Role as Scp106Role;
			FpcCollisionProcessor.AddModifier(this, scp106Role);
			_sinkhole = scp106Role.Sinkhole;
			Scp106SinkholeController.OnSubmergeStateChange += GrantSpeedBoost;
		}

		public void ProcessColliders(ArraySegment<Collider> detections)
		{
			_slowndownTarget = (_sinkhole.TargetSubmerged ? 1 : 0);
			foreach (Collider item in detections)
			{
				float slowdownFromCollider = GetSlowdownFromCollider(item, out var _);
				item.enabled = slowdownFromCollider == 0f;
				_slowndownTarget = Mathf.Max(_slowndownTarget, slowdownFromCollider);
			}
		}

		private void GrantSpeedBoost(Scp106Role scp106role, bool isSubmerged)
		{
			if (!isSubmerged && !(base.Role != scp106role))
			{
				_remainingSpeedBoostDuration = scp106role.Sinkhole.TargetTransitionDuration + 5f;
			}
		}
	}
}

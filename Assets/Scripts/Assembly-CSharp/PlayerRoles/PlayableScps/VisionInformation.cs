using System.Linq;
using CustomPlayerEffects;
using InventorySystem.Items;
using InventorySystem.Items.Usables.Scp244;
using MapGeneration;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace PlayerRoles.PlayableScps
{
	public readonly struct VisionInformation
	{
		public enum FailReason
		{
			NotOnSameFloor = 0,
			NotInDistance = 1,
			NotInView = 2,
			NotInLineOfSight = 3,
			InDarkRoom = 4,
			IsLooking = 5,
			UnkownReason = 6
		}

		public const float MaximumVisionDistance = 30f;

		public const float SurfaceMaximumVisionDistance = 60f;

		public static readonly int VisionLayerMask = LayerMask.GetMask("Door", "Default");

		public static readonly RaycastHit[] RaycastResult = new RaycastHit[1];

		private static readonly int SameFloorDistanceThreshold = 50;

		public float LookingAmount { get; }

		public ReferenceHub SourceHub { get; }

		public Vector3 TargetPosition { get; }

		public float Distance { get; }

		public bool IsOnSameFloor { get; }

		public bool IsLooking { get; }

		public bool IsInDistance { get; }

		public bool IsInDarkness { get; }

		public bool IsInLineOfSight { get; }

		public VisionInformation(ReferenceHub sourceHub, Vector3 targetHub, bool isLooking, bool isOnSameFloor, float lookingAmount, float distance, bool isInLineOfSight, bool isInDarkness, bool isInDistance)
		{
			SourceHub = sourceHub;
			TargetPosition = targetHub;
			IsLooking = isLooking;
			LookingAmount = lookingAmount;
			Distance = distance;
			IsInLineOfSight = isInLineOfSight;
			IsInDarkness = isInDarkness;
			IsInDistance = isInDistance;
			IsOnSameFloor = isOnSameFloor;
		}

		public static VisionInformation GetVisionInformation(ReferenceHub source, Transform sourceCam, Vector3 target, float targetRadius = 0f, float visionTriggerDistance = 0f, bool checkFog = true, bool checkLineOfSight = true, int maskLayer = 0, bool checkInDarkness = true)
		{
			bool isOnSameFloor = false;
			bool flag = false;
			if (TargetOnTheSameFloor(sourceCam.position, target))
			{
				isOnSameFloor = true;
				flag = true;
			}
			bool flag2 = visionTriggerDistance == 0f;
			Vector3 directionToTarget = target - sourceCam.position;
			float magnitude = directionToTarget.magnitude;
			if (flag && visionTriggerDistance > 0f)
			{
				bool flag3 = target.GetZone() == FacilityZone.Surface;
				float num = ((!checkFog) ? visionTriggerDistance : (flag3 ? visionTriggerDistance : (visionTriggerDistance / 2f)));
				if (magnitude <= num)
				{
					flag2 = true;
				}
				flag = flag2;
			}
			float lookingAmount = 1f;
			if (flag)
			{
				flag = false;
				if (magnitude < targetRadius)
				{
					if (Vector3.Dot(source.transform.forward, (target - source.transform.position).normalized) > 0f)
					{
						flag = true;
						lookingAmount = 1f;
					}
				}
				else
				{
					flag = TargetInViewDirection(source, target, targetRadius, out lookingAmount);
				}
			}
			bool flag4 = !checkLineOfSight;
			if (flag & checkLineOfSight)
			{
				flag4 = TargetVisibilityUnobstructed(sourceCam, directionToTarget);
				flag = flag4;
			}
			bool flag5 = false;
			if (checkInDarkness)
			{
				flag5 = CheckIsInDarkness(source, target);
				flag &= !flag5;
			}
			return new VisionInformation(source, target, flag, isOnSameFloor, lookingAmount, magnitude, flag4, flag5, flag2);
		}

		public static bool TargetVisibilityUnobstructed(Transform sourceCam, Vector3 directionToTarget, int maskLayer = 0)
		{
			if (maskLayer == 0)
			{
				maskLayer = VisionLayerMask;
			}
			return Physics.RaycastNonAlloc(new Ray(sourceCam.position, directionToTarget.normalized), RaycastResult, directionToTarget.magnitude, maskLayer) == 0;
		}

		public static bool TargetInViewDirection(ReferenceHub source, Vector3 targetPosition, float targetRadius, out float lookingAmount)
		{
			return TargetInCustomViewDirection(source.PlayerCameraReference, targetPosition, targetRadius, out lookingAmount, source.aspectRatioSync.XScreenEdge, AspectRatioSync.YScreenEdge);
		}

		public static bool TargetInCustomViewDirection(Transform sourceCam, Vector3 targetPosition, float targetRadius, out float lookingAmount, float xAxisAcceptedEdge, float yAxisAcceptedEdge)
		{
			lookingAmount = 1f;
			if (!Scp244Utils.CheckVisibility(sourceCam.position, targetPosition))
			{
				return false;
			}
			Vector3 vector = sourceCam.InverseTransformPoint(targetPosition);
			if (targetRadius != 0f)
			{
				vector.x = Mathf.MoveTowards(vector.x, 0f, targetRadius);
				vector.y = Mathf.MoveTowards(vector.y, 0f, targetRadius);
			}
			float num = Vector2.Angle(Vector2.up, new Vector2(vector.x, vector.z));
			if (num < xAxisAcceptedEdge)
			{
				float num2 = Vector2.Angle(Vector2.up, new Vector2(vector.y, vector.z));
				if (num2 < yAxisAcceptedEdge)
				{
					lookingAmount = (num + num2) / (xAxisAcceptedEdge + yAxisAcceptedEdge);
					return true;
				}
			}
			return false;
		}

		public static bool TargetOnTheSameFloor(Vector3 firstPosition, Vector3 secondPosition)
		{
			return Mathf.Abs(firstPosition.y - secondPosition.y) < (float)SameFloorDistanceThreshold;
		}

		private static bool CheckAttachments(ReferenceHub source)
		{
			ItemBase curInstance = source.inventory.CurInstance;
			if (curInstance != null && curInstance is ILightEmittingItem lightEmittingItem)
			{
				return lightEmittingItem.IsEmittingLight;
			}
			return false;
		}

		public FailReason GetFailReason()
		{
			if (!IsOnSameFloor)
			{
				return FailReason.NotOnSameFloor;
			}
			if (!IsInDistance)
			{
				return FailReason.NotInDistance;
			}
			if (LookingAmount >= 1f)
			{
				return FailReason.NotInView;
			}
			if (!IsInLineOfSight)
			{
				return FailReason.NotInLineOfSight;
			}
			if (IsInDarkness)
			{
				return FailReason.InDarkRoom;
			}
			if (!IsLooking)
			{
				return FailReason.UnkownReason;
			}
			return FailReason.IsLooking;
		}

		public static bool IsInView(ReferenceHub originHub, ReferenceHub targetHub)
		{
			if (!(targetHub.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return false;
			}
			return IsInView(originHub, fpcRole);
		}

		public static bool IsInView(ReferenceHub originHub, IFpcRole fpcRole)
		{
			Vector3 position = fpcRole.FpcModule.Position;
			float radius = fpcRole.FpcModule.CharacterControllerSettings.Radius;
			float visionTriggerDistance = ((position.GetZone() == FacilityZone.Surface) ? 60f : 30f);
			return GetVisionInformation(originHub, originHub.PlayerCameraReference, position, radius, visionTriggerDistance, checkFog: false).IsLooking;
		}

		public static bool CheckIsInDarkness(ReferenceHub hub, Vector3 target)
		{
			bool num = CheckAttachments(hub);
			bool flag = RoomLightController.IsInDarkenedRoom(target);
			bool flag2 = hub.playerEffectsController.AllEffects.Any((StatusEffectBase n) => n is IAmbientBoostingEffect && n.IsEnabled);
			if (!num & flag)
			{
				return !flag2;
			}
			return false;
		}
	}
}

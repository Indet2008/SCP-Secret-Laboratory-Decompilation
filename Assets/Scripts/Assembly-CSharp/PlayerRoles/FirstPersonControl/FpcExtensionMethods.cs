using System.Collections.Generic;
using Mirror;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl
{
	public static class FpcExtensionMethods
	{
		public static Vector3 GetVelocity(this ReferenceHub hub)
		{
			if (!(hub.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return Vector3.zero;
			}
			return fpcRole.FpcModule.Motor.Velocity;
		}

		public static Vector3 GetPosition(this ReferenceHub hub)
		{
			if (!(hub.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return hub.transform.position;
			}
			return fpcRole.FpcModule.Position;
		}

		public static bool IsGrounded(this ReferenceHub hub)
		{
			if (hub.roleManager.CurrentRole is IFpcRole fpcRole)
			{
				return fpcRole.FpcModule.IsGrounded;
			}
			return true;
		}

		public static Bounds GenerateTracerBounds(this ReferenceHub hub, float time, bool ignoreTeleports)
		{
			if (!(hub.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return new Bounds(hub.transform.position, Vector3.zero);
			}
			return fpcRole.FpcModule.Tracer.GenerateBounds(time, ignoreTeleports);
		}

		public static bool TryOverridePosition(this ReferenceHub hub, Vector3 position)
		{
			if (!NetworkServer.active)
			{
				return false;
			}
			if (!(hub.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return false;
			}
			fpcRole.FpcModule.ServerOverridePosition(position);
			return true;
		}

		public static bool TryOverrideRotation(this ReferenceHub hub, Vector2 delta)
		{
			if (!NetworkServer.active)
			{
				return false;
			}
			if (!(hub.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return false;
			}
			fpcRole.FpcModule.ServerOverrideRotation(delta);
			return true;
		}

		public static float GetDot(this IFpcRole target, Transform camera, float radiusMultiplier = 0.5f)
		{
			FirstPersonMovementModule fpcModule = target.FpcModule;
			float maxDelta = fpcModule.CharacterControllerSettings.Radius * radiusMultiplier;
			float maxDelta2 = 0.5f * fpcModule.CharacterControllerSettings.Height;
			Vector3 vector = camera.InverseTransformPoint(fpcModule.Position);
			vector.x = Mathf.MoveTowards(vector.x, 0f, maxDelta);
			vector.y = Mathf.MoveTowards(vector.y, 0f, maxDelta2);
			return vector.normalized.z;
		}

		public static float GetDot(this IFpcRole target, float radiusMultiplier = 0.5f)
		{
			return target.GetDot(MainCameraController.CurrentCamera, radiusMultiplier);
		}

		public static float SqrDistanceTo(this IFpcRole target, Vector3 point)
		{
			return (target.FpcModule.Position - point).sqrMagnitude;
		}

		public static float SqrDistanceTo(this IFpcRole target, ReferenceHub other)
		{
			return target.SqrDistanceTo((other.roleManager.CurrentRole is IFpcRole fpcRole) ? fpcRole.FpcModule.Position : other.transform.position);
		}

		public static ReferenceHub GetClosest(this IEnumerable<ReferenceHub> players, Vector3 point)
		{
			ReferenceHub result = null;
			float num = float.MaxValue;
			foreach (ReferenceHub player in players)
			{
				if (player.roleManager.CurrentRole is IFpcRole target)
				{
					float num2 = target.SqrDistanceTo(point);
					if (!(num2 > num))
					{
						result = player;
						num = num2;
					}
				}
			}
			return result;
		}

		public static ReferenceHub GetPrimaryTarget(this IEnumerable<ReferenceHub> players, Transform camera)
		{
			Vector3 position = camera.position;
			ReferenceHub result = null;
			float num = -1f;
			float num2 = float.MaxValue;
			foreach (ReferenceHub player in players)
			{
				if (!(player.roleManager.CurrentRole is IFpcRole target))
				{
					continue;
				}
				float dot = target.GetDot(camera);
				if (!(num > dot))
				{
					float num3 = target.SqrDistanceTo(position);
					if (num != dot || !(num3 > num2))
					{
						num = dot;
						num2 = num3;
						result = player;
					}
				}
			}
			return result;
		}

		public static void LookAtPoint(this IFpcRole fpc, Vector3 position, float lerp = 1f)
		{
			Vector3 vector = ((fpc is ICameraController cameraController) ? cameraController.CameraPosition : fpc.FpcModule.Position);
			fpc.FpcModule.MouseLook.LookAtDirection((position - vector).normalized, lerp);
		}

		public static void LookAtDirection(this IFpcRole fpc, Vector3 dir, float lerp = 1f)
		{
			fpc.FpcModule.MouseLook.LookAtDirection(dir, lerp);
		}

		public static void LookAtDirection(this FpcMouseLook mouseLook, Vector3 dir, float lerp = 1f)
		{
			Vector2 vector = Quaternion.LookRotation(dir, Vector3.up).eulerAngles;
			mouseLook.CurrentVertical = Mathf.LerpAngle(mouseLook.CurrentVertical, 0f - vector.x, lerp);
			mouseLook.CurrentHorizontal = Mathf.LerpAngle(mouseLook.CurrentHorizontal, vector.y, lerp);
		}
	}
}

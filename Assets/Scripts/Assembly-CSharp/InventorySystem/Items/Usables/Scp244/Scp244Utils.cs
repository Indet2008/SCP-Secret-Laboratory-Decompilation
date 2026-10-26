using UnityEngine;

namespace InventorySystem.Items.Usables.Scp244
{
	public static class Scp244Utils
	{
		public static bool CheckVisibility(Vector3 observer, Vector3 target)
		{
			if ((observer - target).sqrMagnitude <= 73.96f)
			{
				return true;
			}
			foreach (Scp244DeployablePickup instance in Scp244DeployablePickup.Instances)
			{
				if (instance.IntersectRay(observer, target))
				{
					return false;
				}
			}
			return true;
		}

		public static bool IntersectRay(this Scp244DeployablePickup scp244, Vector3 observer, Vector3 target)
		{
			if (scp244.State == Scp244State.Idle || scp244.CurrentSizePercent < 0.55f)
			{
				return false;
			}
			Vector3 vector = target - observer;
			float magnitude = vector.magnitude;
			Vector3 vector2 = vector / magnitude;
			Ray ray = new Ray(observer, vector2);
			if (!scp244.CurrentBounds.IntersectRay(ray, out var distance) || distance > magnitude)
			{
				return false;
			}
			Vector3 position = scp244.transform.position;
			float num = scp244.CurrentDiameter / 2f;
			float value = Vector3.Dot(position - observer, vector2);
			Vector3 vector3 = observer + vector2 * Mathf.Clamp(value, 0f, magnitude);
			return (position - vector3).sqrMagnitude < num * num;
		}
	}
}

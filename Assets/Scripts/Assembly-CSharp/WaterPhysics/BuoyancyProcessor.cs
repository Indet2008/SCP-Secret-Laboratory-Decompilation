using UnityEngine;

namespace WaterPhysics
{
	public static class BuoyancyProcessor
	{
		private const float FullCullTime = 100f;

		private const float StartCullTime = 80f;

		public static void ProcessNew(Rigidbody rb, BuoyancyMode mode)
		{
			switch (mode)
			{
			case BuoyancyMode.SuperLight:
				rb.linearDamping = 0.5f;
				break;
			case BuoyancyMode.SuperHeavy:
			case BuoyancyMode.Floater:
				rb.linearDamping = 1.7f;
				break;
			case BuoyancyMode.NonBuoyant:
			case BuoyancyMode.ShortTimeFloaters:
			case BuoyancyMode.LongTimeFloaters:
				rb.linearDamping = 2f;
				break;
			}
		}

		public static void ProcessExit(Rigidbody rb)
		{
			rb.linearDamping = 0f;
		}

		public static void ProcessFixedUpdate(Rigidbody rb, BuoyancyMode mode, float stayTime, float submergeRatio, Vector3 flow)
		{
			if (!(stayTime > 100f))
			{
				float num = 1f - Mathf.InverseLerp(80f, 100f, stayTime);
				if (rb.mass < 0.2f)
				{
					flow *= rb.mass / 0.2f;
				}
				rb.AddForce(flow * num, ForceMode.Force);
				float num2;
				switch (mode)
				{
				default:
					return;
				case BuoyancyMode.SuperHeavy:
					return;
				case BuoyancyMode.NonBuoyant:
					num2 = 0.9f;
					break;
				case BuoyancyMode.ShortTimeFloaters:
					num2 = Mathf.Lerp(1.5f, 0.95f, stayTime / 10f);
					break;
				case BuoyancyMode.LongTimeFloaters:
					num2 = Mathf.Lerp(1.2f, 0.98f, stayTime / 45f);
					break;
				case BuoyancyMode.Floater:
					num2 = 2f;
					break;
				case BuoyancyMode.SuperLight:
					num2 = 10f;
					break;
				}
				Vector3 vector = num2 * submergeRatio * Time.fixedDeltaTime * -Physics.gravity;
				rb.AddForce(vector * num, ForceMode.VelocityChange);
			}
		}
	}
}

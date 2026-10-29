using CustomRendering;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp244
{
	public static class Scp244FogController
	{
		private const float MaxLerpTime = 2f;

		private const float MaxFogDistance = 50f;

		private const float InstantUpdateSqrt = 60f;

		private static Vector3 _prevPos;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			StaticUnityMethods.OnUpdate += OnUpdate;
		}

		private static void OnUpdate()
		{
			if (MainCameraController.CurrentCamera == null || FogController.Singleton == null)
			{
				return;
			}
			float num = 2f;
			float num2 = 50f;
			bool flag = false;
			foreach (Scp244DeployablePickup instance in Scp244DeployablePickup.Instances)
			{
				if (!(instance == null))
				{
					Vector3 position = MainCameraController.CurrentCamera.position;
					float num3 = instance.FogPercentForPoint(position);
					num = Mathf.Min(num, instance.FogLerpCurve.Evaluate(1f - num3));
					num2 = Mathf.Min(num2, instance.FogDistanceCurve.Evaluate(1f - num3));
					if ((position - _prevPos).sqrMagnitude > 60f)
					{
						num = 0f;
					}
					_prevPos = position;
					flag |= num3 > 0f;
				}
			}
			FogController.Singleton.GetFogSetting(FogType.Scp244).EndDistance = num2;
			if (flag)
			{
				FogController.EnableFogType(FogType.Scp244, num);
			}
			else
			{
				FogController.DisableFogType(FogType.Scp244, num);
			}
		}
	}
}

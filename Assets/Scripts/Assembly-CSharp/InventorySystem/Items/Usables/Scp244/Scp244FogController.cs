namespace InventorySystem.Items.Usables.Scp244
{
	public static class Scp244FogController
	{
		private const float MaxLerpTime = 2f;

		private const float MaxFogDistance = 50f;

		private const float InstantUpdateSqrt = 60f;

		private static global::UnityEngine.Vector3 _prevPos;

		[global::UnityEngine.RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
		}

		private static void OnUpdate()
		{
		}
	}
}

using UnityEngine;

public static class DamageIndicator
{
	private const float PulseIntensity = 1.5f;

	private const float ScrapeIntensity = 0.02f;

	private const float EffectsIntensity = 0.025f;

	public static void ReceiveDamageFromPosition(Vector3 srcPos, float damage)
	{
		Transform currentCamera = MainCameraController.CurrentCamera;
		if (!(currentCamera == null))
		{
			ReceiveDamageFromDirection(currentCamera.InverseTransformDirection(srcPos - currentCamera.position), damage);
		}
	}

	public static void ReceiveDamageFromDirection(Vector3 dir, float damage)
	{
		float num = (float)System.Math.Sqrt(dir.x * dir.x + dir.z * dir.z);
		if (!(num <= 0f))
		{
			Vector3 hitDir = new Vector3(dir.x / num, dir.y / num, dir.z / num);
			BloodEffectsSystem localPlayerSingleton = BloodEffectsSystem.LocalPlayerSingleton;
			localPlayerSingleton.AddPulseBlood(hitDir, damage * 1.5f / 100f);
			localPlayerSingleton.AddScrapeBlood(hitDir, damage * 0.02f / 100f);
			localPlayerSingleton.AddScrapes(damage * 0.025f / 100f);
		}
	}
}

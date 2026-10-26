using PlayerRoles.Spectating;
using UnityEngine;

public class ExplosionCameraShake : MonoBehaviour
{
	public float force;

	public float deductSpeed = 2f;

	public static ExplosionCameraShake singleton;

	private void Update()
	{
		force -= Time.deltaTime / deductSpeed;
		force = Mathf.Clamp01(force);
	}

	private void Awake()
	{
		singleton = this;
		SpectatorTargetTracker.OnTargetChanged += StopShake;
	}

	private void OnDestroy()
	{
		SpectatorTargetTracker.OnTargetChanged -= StopShake;
	}

	private void StopShake()
	{
		force = 0f;
	}

	public void Shake(float explosionForce)
	{
		if (!UserSettings.UserSetting<bool>.Get(UserSettings.VideoSettings.MiscVideoSetting.ExplosionShake))
		{
			return;
		}
		if (explosionForce > force)
		{
			force = explosionForce;
		}
	}
}

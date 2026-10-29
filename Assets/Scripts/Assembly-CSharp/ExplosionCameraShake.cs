using CustomRendering;
using PlayerRoles.Spectating;
using UnityEngine;
using UnityEngine.Rendering;

public class ExplosionCameraShake : MonoBehaviour
{
	public float force;

	public float deductSpeed = 2f;

	private CameraShake _cameraShake;

	public static ExplosionCameraShake singleton;

	private void Update()
	{
		force -= Time.deltaTime / deductSpeed;
		force = Mathf.Clamp01(force);
		if (_cameraShake != null)
		{
			_cameraShake.ScanLineJitter.value = force;
			_cameraShake.HorizontalShake.value = force;
			_cameraShake.ColorDrift.value = force;
		}
	}

	private void Awake()
	{
		singleton = this;
		SpectatorTargetTracker.OnTargetChanged += StopShake;
		Volume component = GetComponent<Volume>();
		if (component != null)
		{
			component.profile.TryGet<CameraShake>(out _cameraShake);
		}
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

using CustomRendering;
using Mirror;
using PlayerRoles;
using PlayerRoles.Spectating;
using PlayerStatsSystem;
using UnityEngine;
using UnityEngine.Rendering;

public class BloodEffectsSystem : MonoBehaviour
{
	public static BloodEffectsSystem LocalPlayerSingleton;

	public float HealthLerpSpeed;

	public float PulseBloodDeductSpeed;

	public float ScrapeBloodDeductSpeed;

	public AnimationCurve grayscaleAnimationCurve;

	public AnimationCurve vignetteAnimationCurve;

	private BloodHit _bloodHit;

	private Grayscale _bloodGrayScale;

	private float _dyingRatio;

	private bool _instantUpdate;

	private int _fullScapeRoundRobin;

	public bool DisableHurtEffect { get; set; }

	private void Awake()
	{
		LocalPlayerSingleton = this;
		VolumeProfile profile = GetComponent<Volume>().profile;
		profile.TryGet<Grayscale>(out _bloodGrayScale);
		profile.TryGet<BloodHit>(out _bloodHit);
		_fullScapeRoundRobin = Random.Range(0, 3);
		SpectatorTargetTracker.OnTargetChanged += delegate
		{
			_instantUpdate = true;
		};
	}

	[Client]
	public void AddPulseBlood(Vector3 hitDir, float opacityMultiplier = 1f)
	{
		if (!NetworkClient.active)
		{
			Debug.LogWarning("[Client] function 'System.Void BloodEffectsSystem::AddPulseBlood(UnityEngine.Vector3,System.Single)' called when client was not active");
			return;
		}
		float num = opacityMultiplier * hitDir.x;
		float num2 = opacityMultiplier * hitDir.z;
		if (num > 0f)
		{
			_bloodHit.Hit_Right.value += num;
		}
		if (num < 0f)
		{
			_bloodHit.Hit_Left.value += 0f - num;
		}
		if (num2 > 0f)
		{
			_bloodHit.Hit_Up.value += num2;
		}
		if (num2 < 0f)
		{
			_bloodHit.Hit_Down.value += 0f - num2;
		}
	}

	[Client]
	public void AddScrapeBlood(Vector3 hitDir, float opacityMultiplier = 1f)
	{
		if (!NetworkClient.active)
		{
			Debug.LogWarning("[Client] function 'System.Void BloodEffectsSystem::AddScrapeBlood(UnityEngine.Vector3,System.Single)' called when client was not active");
			return;
		}
		float num = opacityMultiplier * hitDir.x;
		float num2 = opacityMultiplier * hitDir.z;
		if (num > 0f)
		{
			_bloodHit.Blood_Hit_Right.value += num;
		}
		if (num < 0f)
		{
			_bloodHit.Blood_Hit_Left.value += 0f - num;
		}
		if (num2 > 0f)
		{
			_bloodHit.Blood_Hit_Up.value += num2;
		}
		if (num2 < 0f)
		{
			_bloodHit.Blood_Hit_Down.value += 0f - num2;
		}
	}

	[Client]
	public void AddScrapes(float opacity)
	{
		if (!NetworkClient.active)
		{
			Debug.LogWarning("[Client] function 'System.Void BloodEffectsSystem::AddScrapes(System.Single)' called when client was not active");
			return;
		}
		switch (_fullScapeRoundRobin)
		{
		case 0:
			_bloodHit.Blood_Hit_Full_1.value += opacity;
			break;
		case 1:
			_bloodHit.Blood_Hit_Full_2.value += opacity;
			break;
		case 2:
			_bloodHit.Blood_Hit_Full_3.value += opacity;
			break;
		}
		if (_fullScapeRoundRobin++ == 2)
		{
			_fullScapeRoundRobin = 0;
		}
	}

	[Client]
	public void ResetScrapes()
	{
		if (!NetworkClient.active)
		{
			Debug.LogWarning("[Client] function 'System.Void BloodEffectsSystem::ResetScrapes()' called when client was not active");
			return;
		}
		_bloodHit.Blood_Hit_Right.value = 0f;
		_bloodHit.Blood_Hit_Left.value = 0f;
		_bloodHit.Blood_Hit_Up.value = 0f;
		_bloodHit.Blood_Hit_Down.value = 0f;
		_bloodHit.Blood_Hit_Full_1.value = 0f;
		_bloodHit.Blood_Hit_Full_2.value = 0f;
		_bloodHit.Blood_Hit_Full_3.value = 0f;
	}

	private void FadePulseBlood(float speed)
	{
		_bloodHit.Hit_Right.value = Mathf.Lerp(_bloodHit.Hit_Right.value, 0f, speed);
		_bloodHit.Hit_Left.value = Mathf.Lerp(_bloodHit.Hit_Left.value, 0f, speed);
		_bloodHit.Hit_Up.value = Mathf.Lerp(_bloodHit.Hit_Up.value, 0f, speed);
		_bloodHit.Hit_Down.value = Mathf.Lerp(_bloodHit.Hit_Down.value, 0f, speed);
	}

	private void FadeScrapeBlood(float speed)
	{
		_bloodHit.Blood_Hit_Right.value = Mathf.Lerp(_bloodHit.Blood_Hit_Right.value, 0f, speed);
		_bloodHit.Blood_Hit_Left.value = Mathf.Lerp(_bloodHit.Blood_Hit_Left.value, 0f, speed);
		_bloodHit.Blood_Hit_Up.value = Mathf.Lerp(_bloodHit.Blood_Hit_Up.value, 0f, speed);
		_bloodHit.Blood_Hit_Down.value = Mathf.Lerp(_bloodHit.Blood_Hit_Down.value, 0f, speed);
		_bloodHit.Blood_Hit_Full_1.value = Mathf.Lerp(_bloodHit.Blood_Hit_Full_1.value, 0f, speed);
		_bloodHit.Blood_Hit_Full_2.value = Mathf.Lerp(_bloodHit.Blood_Hit_Full_2.value, 0f, speed);
		_bloodHit.Blood_Hit_Full_3.value = Mathf.Lerp(_bloodHit.Blood_Hit_Full_3.value, 0f, speed);
	}

	private void Update()
	{
		if (ReferenceHub.TryGetLocalHub(out var hub))
		{
			float num = Mathf.Max(0f, GetDeadAmount(hub) - 0.5f) * 2f;
			if (_instantUpdate)
			{
				ResetScrapes();
				_instantUpdate = false;
			}
			else
			{
				num = Mathf.Lerp(_dyingRatio, num, HealthLerpSpeed);
			}
			_dyingRatio = num;
			_bloodGrayScale.Intensity.value = grayscaleAnimationCurve.Evaluate(_dyingRatio);
			_bloodHit.Hit_Full.value = vignetteAnimationCurve.Evaluate(_dyingRatio);
			FadePulseBlood(PulseBloodDeductSpeed);
			FadeScrapeBlood(ScrapeBloodDeductSpeed);
		}
	}

	private float GetDeadAmount(ReferenceHub hub)
	{
		if (DisableHurtEffect || !(hub.roleManager.CurrentRole is IHealthbarRole healthbarRole) || healthbarRole.TargetStats == null)
		{
			return 0f;
		}
		float num = 0f;
		float num2 = 0f;
		StatBase[] statModules = healthbarRole.TargetStats.StatModules;
		foreach (StatBase statBase in statModules)
		{
			if (statBase is HealthStat)
			{
				num += statBase.CurValue;
				num2 = statBase.MaxValue;
			}
			else if (statBase is HumeShieldStat || statBase is AhpStat)
			{
				num += statBase.CurValue;
			}
		}
		if (num2 == 0f)
		{
			return 0f;
		}
		return 1f - Mathf.Clamp01(num / num2);
	}
}

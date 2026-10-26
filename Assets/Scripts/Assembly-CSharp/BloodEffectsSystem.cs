public class BloodEffectsSystem : global::UnityEngine.MonoBehaviour
{
	public static BloodEffectsSystem LocalPlayerSingleton;

	public float HealthLerpSpeed;

	public float PulseBloodDeductSpeed;

	public float ScrapeBloodDeductSpeed;

	public global::UnityEngine.AnimationCurve grayscaleAnimationCurve;

	public global::UnityEngine.AnimationCurve vignetteAnimationCurve;

	private global::CustomRendering.BloodHit _bloodHit;

	private global::CustomRendering.Grayscale _bloodGrayScale;

	private float _dyingRatio;

	private bool _instantUpdate;

	private int _fullScapeRoundRobin;

	public bool DisableHurtEffect
	{
		[global::System.Runtime.CompilerServices.CompilerGenerated]
		get
		{
			return default;
		}
		[global::System.Runtime.CompilerServices.CompilerGenerated]
		set
		{
		}
	}

	private void Awake()
	{
	}

	[global::Mirror.Client]
	public void AddPulseBlood(global::UnityEngine.Vector3 hitDir, float opacityMultiplier = 1f)
	{
	}

	[global::Mirror.Client]
	public void AddScrapeBlood(global::UnityEngine.Vector3 hitDir, float opacityMultiplier = 1f)
	{
	}

	[global::Mirror.Client]
	public void AddScrapes(float opacity)
	{
	}

	[global::Mirror.Client]
	public void ResetScrapes()
	{
	}

	private void FadePulseBlood(float speed)
	{
	}

	private void FadeScrapeBlood(float speed)
	{
	}

	private void Update()
	{
	}

	private float GetDeadAmount(ReferenceHub hub)
	{
		return default;
	}

	public BloodEffectsSystem()
	{
	}
}

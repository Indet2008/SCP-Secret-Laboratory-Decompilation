using CustomPlayerEffects;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

[RequireComponent(typeof(AudioSource))]
[RequireComponent(typeof(AudioReverbFilter))]
[RequireComponent(typeof(AudioLowPassFilter))]
public class AudioProximityEffects : MonoBehaviour
{
	[SerializeField]
	private AnimationCurve _reverbSizeOverDistance;

	[SerializeField]
	private AnimationCurve _reverbDryOverDistance;

	[SerializeField]
	private AnimationCurve _lowpassOverDistance;

	private AudioSource _audioSource;

	private AudioReverbFilter _reverbFilter;

	private AudioLowPassFilter _lowPassFilter;

	private AudioEchoFilter _audioEchoFilter;

	private float ProximityLevel
	{
		get
		{
			if (!ReferenceHub.TryGetLocalHub(out var hub))
			{
				return 0f;
			}
			if (!(hub.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return 0f;
			}
			return Vector3.Distance(base.transform.position, fpcRole.FpcModule.Position) / _audioSource.maxDistance * _audioSource.spatialBlend;
		}
	}

	private void Awake()
	{
		_audioSource = GetComponent<AudioSource>();
		_reverbFilter = GetComponent<AudioReverbFilter>();
		_lowPassFilter = GetComponent<AudioLowPassFilter>();
		_audioEchoFilter = GetComponent<AudioEchoFilter>();
	}

	private void Update()
	{
		float proximityLevel = ProximityLevel;
		_reverbFilter.dryLevel = _reverbDryOverDistance.Evaluate(proximityLevel);
		_reverbFilter.room = _reverbSizeOverDistance.Evaluate(proximityLevel);
		_lowPassFilter.cutoffFrequency = _lowpassOverDistance.Evaluate(proximityLevel);
		if (ReferenceHub.TryGetLocalHub(out var hub))
		{
			_audioEchoFilter.enabled = hub.playerEffectsController.GetEffect<Ghostly>().IsEnabled;
		}
	}
}

using UnityEngine;

public class RandomAmbienceTrigger : MonoBehaviour
{
	[SerializeField]
	private AudioClip[] _ambientClips;

	[SerializeField]
	private AudioSource _ambientSource;

	private float _timeUntilAmbience;

	[SerializeField]
	private float _minAmbienceTime;

	[SerializeField]
	private float _maxAmbienceTime;

	private void Start()
	{
		Rerandomize();
	}

	private void Update()
	{
		_timeUntilAmbience -= Time.deltaTime;
		if (!(_timeUntilAmbience > 0f))
		{
			_ambientSource.clip = _ambientClips.RandomItem();
			_ambientSource.Play();
			Rerandomize();
		}
	}

	private void Rerandomize()
	{
		_timeUntilAmbience = Random.Range(_minAmbienceTime, _maxAmbienceTime);
	}
}

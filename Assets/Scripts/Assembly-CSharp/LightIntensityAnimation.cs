using UnityEngine;

public class LightIntensityAnimation : MonoBehaviour
{
	private RoomLight _roomLight;

	[SerializeField]
	private AnimationCurve _animation;

	[SerializeField]
	private float _intensityMultiplier;

	[SerializeField]
	private float _timeOffset;

	private void Awake()
	{
		_roomLight = GetComponent<RoomLight>();
		_animation.postWrapMode = WrapMode.Loop;
	}

	private void Reset()
	{
		_intensityMultiplier = GetComponent<Light>().intensity;
		_animation = AnimationCurve.Constant(0f, 1f, 1f);
	}

	private void Update()
	{
		if (!_roomLight.IsCulled)
		{
			float time = Time.timeSinceLevelLoad + _timeOffset;
			float intensity = _intensityMultiplier * _animation.Evaluate(time);
			_roomLight.LightSource.intensity = intensity;
		}
	}
}

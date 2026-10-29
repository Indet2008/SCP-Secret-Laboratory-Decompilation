using UnityEngine;

// Restored from the client build (IL2CPP): randomly dips the intensity of a light (or a group of lights)
// and lets it recover, giving a flickering lamp.
public class LightBlink : MonoBehaviour
{
	public float noshadowIntensMultiplier;

	public float minFlickerTimeRange;

	public float maxFlickerTimeRange;

	public float turnOnSpeed;

	public float maxIntensityDecreaseMultiplier;

	[global::UnityEngine.Header("Used to flicker multiple lights at the same time.")]
	[global::UnityEngine.Header("Leave empty to just use the attached light.")]
	public global::UnityEngine.Rendering.HighDefinition.HDAdditionalLightData[] lightGroup;

	private float[] _startLightIntensity;

	private Light[] _lights;

	private Light _defaultLight;

	private float _frequency;

	private RoomLightController _controller;

	private bool _hasParentController;

	private void Awake()
	{
		_controller = GetComponentInParent<RoomLightController>();
		if (_controller == null)
		{
			_controller = GetComponentInChildren<RoomLightController>();
		}
		_hasParentController = _controller != null;
		if (lightGroup == null || lightGroup.Length == 0)
		{
			global::UnityEngine.Rendering.HighDefinition.HDAdditionalLightData own = GetComponent<global::UnityEngine.Rendering.HighDefinition.HDAdditionalLightData>();
			lightGroup = own != null ? new global::UnityEngine.Rendering.HighDefinition.HDAdditionalLightData[1] { own } : new global::UnityEngine.Rendering.HighDefinition.HDAdditionalLightData[0];
		}
		_lights = new Light[lightGroup.Length];
		_startLightIntensity = new float[lightGroup.Length];
		for (int i = 0; i < lightGroup.Length; i++)
		{
			_lights[i] = lightGroup[i] != null ? lightGroup[i].GetComponent<Light>() : null;
			_startLightIntensity[i] = _lights[i] != null ? _lights[i].intensity : 0f;
		}
		_defaultLight = _lights.Length != 0 ? _lights[0] : null;
		base.enabled = _defaultLight != null;
	}

	private void Start()
	{
		if (QualitySettings.shadows != ShadowQuality.Disable)
		{
			noshadowIntensMultiplier = 1f;
		}
	}

	private void Update()
	{
		if (_defaultLight == null)
		{
			Object.Destroy(this);
			return;
		}
		if (!_defaultLight.enabled || (_hasParentController && !_controller.LightsEnabled))
		{
			return;
		}
		_frequency -= Time.deltaTime;
		bool flicker = _frequency <= 0f;
		if (flicker)
		{
			_frequency = Random.Range(minFlickerTimeRange, maxFlickerTimeRange);
		}
		for (int i = 0; i < _lights.Length; i++)
		{
			Light light = _lights[i];
			if (light == null)
			{
				continue;
			}
			float target = _startLightIntensity[i] * noshadowIntensMultiplier;
			light.intensity = flicker ? (target * (1f - Random.Range(0f, maxIntensityDecreaseMultiplier))) : Mathf.Lerp(light.intensity, target, Time.deltaTime * turnOnSpeed);
		}
	}
}

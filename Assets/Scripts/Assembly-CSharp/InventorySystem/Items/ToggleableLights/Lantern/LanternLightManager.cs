using GameObjectPools;
using UnityEngine;

namespace InventorySystem.Items.ToggleableLights.Lantern
{
	public class LanternLightManager : MonoBehaviour, IPoolResettable
	{
		private const float MinSquaredDistanceMovedToProduceSound = 900f;

		private static readonly int EmissionId = Shader.PropertyToID("_EmissionColor");

		private MaterialPropertyBlock _mpb;

		public Light[] Lights;

		public Renderer MainRenderer;

		public Color EmissionColor;

		public ParticleSystem ParticleSystem;

		public float LightSpeed = 4f;

		public AudioClip ForwardSound;

		public AudioClip BackwardSound;

		public Rigidbody SoundTriggerRb;

		public float Forward;

		public float Backward;

		public float ForwardVolume = 0.8f;

		public float BackwardVolume = 0.8f;

		public float VolumeModifier = 0.2f;

		private float _previousRot;

		[SerializeField]
		private AudioSource _forwardSound;

		[SerializeField]
		private AudioSource _backwardSound;

		private LightBlink _blinker;

		private float[] _lightRanges;

		private float _enableRatio;

		private bool _initialized;

		private Vector3 _oldPosition;

		public bool IsEnabled { get; private set; } = true;

		private float AngularMag => SoundTriggerRb.angularVelocity.magnitude * VolumeModifier;

		private void AudioUpdate()
		{
			float x = SoundTriggerRb.transform.localRotation.x;
			bool flag = x > _previousRot;
			if (flag && !_forwardSound.isPlaying && x >= Forward && _previousRot <= Forward)
			{
				_forwardSound.volume = AngularMag * ForwardVolume;
				_forwardSound.Play();
			}
			else if (!flag && !_backwardSound.isPlaying && x <= Backward && _previousRot >= Backward)
			{
				_backwardSound.volume = AngularMag * BackwardVolume;
				_backwardSound.Play();
			}
			_previousRot = x;
		}

		private void Awake()
		{
			if (!_initialized)
			{
				_blinker = GetComponent<LightBlink>();
				_mpb = new MaterialPropertyBlock();
				MainRenderer.GetPropertyBlock(_mpb, 1);
				_lightRanges = new float[Lights.Length];
				for (int i = 0; i < Lights.Length; i++)
				{
					_lightRanges[i] = Lights[i].range;
				}
				_initialized = true;
				ResetObject();
			}
		}

		public void SetLight(bool isEnabled)
		{
			if (!_initialized)
			{
				Awake();
			}
			if (IsEnabled != isEnabled && base.enabled)
			{
				IsEnabled = isEnabled;
				_blinker.enabled = isEnabled;
				if (isEnabled)
				{
					ParticleSystem.Play();
				}
				else
				{
					ParticleSystem.Stop();
				}
			}
		}

		private void Update()
		{
			Vector3 position = base.transform.position;
			Vector3 force = _oldPosition - position;
			if (force.sqrMagnitude < 900f)
			{
				SoundTriggerRb.AddForce(force, ForceMode.VelocityChange);
			}
			_oldPosition = position;
			AudioUpdate();
			if ((IsEnabled && !(_enableRatio >= 1f)) || (!IsEnabled && !(_enableRatio <= 0f)))
			{
				_enableRatio += (IsEnabled ? Time.deltaTime : (0f - Time.deltaTime)) * LightSpeed;
				for (int i = 0; i < Lights.Length; i++)
				{
					Lights[i].range = Mathf.Lerp(0f, _lightRanges[i], _enableRatio);
				}
				_mpb.SetColor(EmissionId, Color.Lerp(Color.black, EmissionColor, _enableRatio));
				MainRenderer.SetPropertyBlock(_mpb, 1);
			}
		}

		private void OnEnable()
		{
			if (IsEnabled)
			{
				ParticleSystem.Play();
			}
		}

		private void OnDisable()
		{
			if (IsEnabled)
			{
				ParticleSystem.Stop();
			}
		}

		public void ResetObject()
		{
			if (IsEnabled)
			{
				_blinker.enabled = false;
				_enableRatio = 0f;
				IsEnabled = false;
				Light[] lights = Lights;
				for (int i = 0; i < lights.Length; i++)
				{
					lights[i].range = 0f;
				}
				_mpb.SetColor(EmissionId, Color.black);
				MainRenderer.SetPropertyBlock(_mpb, 1);
				ParticleSystem.Stop();
			}
		}
	}
}

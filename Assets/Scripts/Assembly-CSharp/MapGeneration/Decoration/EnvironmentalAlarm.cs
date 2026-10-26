using System.Collections.Generic;
using UnityEngine;
using UnityStandardAssets.Utility;

namespace MapGeneration.Decoration
{
	public class EnvironmentalAlarm : MonoBehaviour
	{
		private static readonly int EmissiveColorPropertyID = Shader.PropertyToID("_EmissiveColor");

		private static readonly float AnimationSpeed = 1.15f;

		private static readonly AnimationCurve EaseInOutCurve = new AnimationCurve(new Keyframe(0f, 0f, 0f, 0f, 0f, 0f), new Keyframe(1f, 1f, 0f, 0f, 0f, 0f));

		private static readonly AnimationCurve EaseInCurve = new AnimationCurve(new Keyframe(0f, 0f, 0f, 0f, 0f, 0f), new Keyframe(1f, 1f, 2f, 2f, 0f, 0f));

		[SerializeField]
		private Light[] _lights;

		[SerializeField]
		private AudioSource[] _audioSources;

		[SerializeField]
		private MeshRenderer[] _emissiveMatMeshRenderers;

		[SerializeField]
		private AutoMoveAndRotate _lightRotator;

		[SerializeField]
		[HideInInspector]
		private List<Color> _enabledEmissionColors = new List<Color>();

		private float[] _defaultLightIntensities;

		private Material[] _materialCopies;

		private float _animationProgress;

		[field: SerializeField]
		public bool IsEnabled { get; set; }

		private bool IsAnimationComplete
		{
			get
			{
				if (IsEnabled && _animationProgress >= 1f)
				{
					return true;
				}
				if (!IsEnabled && _animationProgress <= 0f)
				{
					return true;
				}
				return false;
			}
		}

		private void Start()
		{
			_defaultLightIntensities = new float[_lights.Length];
			_materialCopies = new Material[_emissiveMatMeshRenderers.Length];
			for (int i = 0; i < _lights.Length; i++)
			{
				_defaultLightIntensities[i] = _lights[i].intensity;
			}
			for (int j = 0; j < _emissiveMatMeshRenderers.Length; j++)
			{
				Material material = new Material(_emissiveMatMeshRenderers[j].sharedMaterial);
				_materialCopies[j] = material;
				_emissiveMatMeshRenderers[j].sharedMaterial = material;
			}
			Animate();
		}

		private void Update()
		{
			if (!IsAnimationComplete)
			{
				Animate();
			}
		}

		private void Animate()
		{
			float num = Time.deltaTime * AnimationSpeed;
			float num2 = (IsEnabled ? num : (0f - num));
			_animationProgress = Mathf.Clamp01(_animationProgress + num2);
			float num3 = EaseInOutCurve.Evaluate(_animationProgress);
			float num4 = EaseInCurve.Evaluate(_animationProgress);
			for (int i = 0; i < _defaultLightIntensities.Length; i++)
			{
				_lights[i].intensity = _defaultLightIntensities[i] * num3;
			}
			for (int j = 0; j < _materialCopies.Length; j++)
			{
				Color value = Color.Lerp(Color.black, _enabledEmissionColors[j], num3);
				_emissiveMatMeshRenderers[j].material.SetColor(EmissiveColorPropertyID, value);
			}
			AudioSource[] audioSources = _audioSources;
			foreach (AudioSource audioSource in audioSources)
			{
				audioSource.volume = (IsEnabled ? 1f : num4);
				if (audioSource.volume == 0f && audioSource.isPlaying)
				{
					audioSource.Stop();
				}
				if (audioSource.volume > 0f && !audioSource.isPlaying)
				{
					audioSource.Play();
				}
			}
			_lightRotator.Multiplier = num4;
		}

		private void OnValidate()
		{
			_enabledEmissionColors.Clear();
			MeshRenderer[] emissiveMatMeshRenderers = _emissiveMatMeshRenderers;
			foreach (MeshRenderer meshRenderer in emissiveMatMeshRenderers)
			{
				if (!(meshRenderer.sharedMaterial == null))
				{
					Color color = meshRenderer.sharedMaterial.GetColor(EmissiveColorPropertyID);
					_enabledEmissionColors.Add(color);
				}
			}
		}

		private void OnDestroy()
		{
			if (_materialCopies != null)
			{
				Material[] materialCopies = _materialCopies;
				for (int i = 0; i < materialCopies.Length; i++)
				{
					Object.Destroy(materialCopies[i]);
				}
			}
		}
	}
}

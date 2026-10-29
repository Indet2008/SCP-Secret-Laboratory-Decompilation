using UnityEngine;
using UnityEngine.UI;

namespace OperationalGuide
{
	public class LerpGrayscale : MonoBehaviour
	{
		private readonly int _modifierId = Shader.PropertyToID("_GrayscaleIntensity");

		private Material _grayScaleMat;

		private float _colorModifier;

		public float ColorModifier;

		private void Awake()
		{
			Image component = GetComponent<Image>();
			component.material = new Material(component.material);
			_grayScaleMat = component.material;
		}

		private void Update()
		{
			if (ColorModifier != _colorModifier)
			{
				_grayScaleMat.SetFloat(_modifierId, (ColorModifier > 0.95f) ? 1f : ColorModifier);
				_colorModifier = ColorModifier;
			}
		}

		private void OnDisable()
		{
			_colorModifier = 1f;
			ColorModifier = 1f;
			_grayScaleMat.SetFloat(_modifierId, 1f);
		}
	}
}

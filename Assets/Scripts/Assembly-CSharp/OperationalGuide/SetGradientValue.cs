using UnityEngine;
using UnityEngine.UI;

namespace OperationalGuide
{
	public class SetGradientValue : MonoBehaviour
	{
		private readonly int _leftColor = Shader.PropertyToID("_LeftColor");

		private readonly int _rightColor = Shader.PropertyToID("_RightColor");

		private readonly int _rotation = Shader.PropertyToID("_Rotation");

		private readonly int _leftColorModifier = Shader.PropertyToID("_LeftColorModifier");

		private readonly int _rightColorModifier = Shader.PropertyToID("_RightColorModifier");

		private readonly int _leftAlphaModifier = Shader.PropertyToID("_LeftAlphaModifier");

		private readonly int _rightAlphaModifier = Shader.PropertyToID("_RightAlphaModifier");

		public Color LeftColor;

		public Color RightColor;

		public float Rotation;

		public float LeftColorModifier;

		public float RightColorModifier;

		public float LeftAlphaModifier;

		public float RightAlphaModifier;

		private void Start()
		{
			Image component = GetComponent<Image>();
			component.material = new Material(component.material);
			Material material = component.material;
			material.SetColor(_leftColor, LeftColor);
			material.SetColor(_rightColor, RightColor);
			material.SetFloat(_rotation, Rotation);
			material.SetFloat(_leftColorModifier, LeftColorModifier);
			material.SetFloat(_rightColorModifier, RightColorModifier);
			material.SetFloat(_leftAlphaModifier, LeftAlphaModifier);
			material.SetFloat(_rightAlphaModifier, RightAlphaModifier);
		}
	}
}

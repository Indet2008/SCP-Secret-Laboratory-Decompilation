using UnityEngine;
using UnityEngine.UI;

namespace OperationalGuide
{
	public class VarientAlphaLerp : MonoBehaviour
	{
		public const float MinAlpha = 0.65f;

		public const float DistanceDivider = 350f;

		public RawImage[] Varients;

		public int Index = -1;

		private float[] _lerpValues;

		// The selected variant is fully opaque; others brighten as the cursor gets closer.
		private void Update()
		{
			for (int i = 0; i < Varients.Length; i++)
			{
				RawImage rawImage = Varients[i];
				_lerpValues[i] = 1f - Mathf.Abs(Vector3.Distance(Input.mousePosition, rawImage.transform.position)) / 350f;
				Color color = rawImage.color;
				rawImage.color = ((Index == i) ? new Color(color.r, color.g, color.b, 1f) : LerpAlpha(color, _lerpValues[i]));
			}
		}

		public Color LerpAlpha(Color startingColor, float lerpAmount)
		{
			startingColor.a = Mathf.Max(0.65f, Mathf.Clamp01(lerpAmount));
			return startingColor;
		}

		public void SetVarientStatus(int index)
		{
			Index = index;
		}

		private void Awake()
		{
			_lerpValues = new float[Varients.Length];
		}
	}
}

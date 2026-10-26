using UnityEngine;

public class BackgroundScaleToFill : MonoBehaviour
{
	private Vector2Int? _prevResolution;

	[SerializeField]
	private Vector2 _originalResolution;

	[SerializeField]
	private Vector2 _scale;

	private void Update()
	{
		Vector2Int vector2Int = new Vector2Int(Screen.width, Screen.height);
		Vector2Int value = vector2Int;
		Vector2Int? prevResolution = _prevResolution;
		if (!(value == prevResolution))
		{
			_prevResolution = vector2Int;
			Rescale((float)vector2Int.x / (float)vector2Int.y);
		}
	}

	private void Rescale(float screenAspect)
	{
		float num = _originalResolution.x / _originalResolution.y;
		if (screenAspect > num)
		{
			float num2 = screenAspect / num;
			base.transform.localScale = new Vector3(_scale.x, _scale.y * num2, 1f);
		}
		else
		{
			float num3 = num / screenAspect;
			base.transform.localScale = new Vector3(_scale.x * num3, _scale.y, 1f);
		}
	}

	private void Reset()
	{
		_originalResolution = new Vector2(16f, 9f);
		_scale = Vector2.one;
	}
}

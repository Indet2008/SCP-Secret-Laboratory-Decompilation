using TMPro;
using UnityEngine;

namespace Tooltips
{
	// Client-only in v14 (shell in the server build): a text box that sizes itself to its text and
	// sits next to the cursor without leaving the canvas.
	public class Tooltip : MonoBehaviour
	{
		private const float CursorSize = 28f;

		[SerializeField]
		private RectTransform _rectTransform;

		[SerializeField]
		private RectTransform _background;

		[SerializeField]
		private TMP_Text _textComponent;

		[SerializeField]
		private Canvas _canvas;

		[SerializeField]
		private float _padding;

		public void SetText(string text)
		{
			if (_textComponent == null || _textComponent.text == text)
			{
				return;
			}
			_textComponent.text = text;
			_textComponent.ForceMeshUpdate();
			if (_background != null)
			{
				Vector2 preferredValues = _textComponent.GetPreferredValues(text, _textComponent.rectTransform.rect.width, 0f);
				Vector2 renderedValues = _textComponent.GetRenderedValues(onlyVisibleCharacters: false);
				float x = Mathf.Min(preferredValues.x, _textComponent.rectTransform.rect.width);
				if (renderedValues.x > 0f)
				{
					x = Mathf.Min(x, renderedValues.x);
				}
				_background.sizeDelta = new Vector2(x + _padding * 2f, Mathf.Max(preferredValues.y, renderedValues.y) + _padding * 2f);
			}
		}

		public void SetPosition(Vector3 position)
		{
			if (_rectTransform == null)
			{
				return;
			}
			float num = ((_canvas != null) ? _canvas.scaleFactor : 1f);
			Vector2 vector = ((_background != null) ? _background.sizeDelta : _rectTransform.sizeDelta) * num;
			Vector3 vector2 = position + new Vector3(CursorSize * num * 0.5f, (0f - CursorSize) * num * 0.5f, 0f);
			if (vector2.x + vector.x > (float)Screen.width)
			{
				vector2.x = position.x - vector.x - CursorSize * num * 0.25f;
			}
			if (vector2.y - vector.y < 0f)
			{
				vector2.y = position.y + vector.y;
			}
			_rectTransform.pivot = new Vector2(0f, 1f);
			if (_canvas != null && _canvas.renderMode != RenderMode.ScreenSpaceOverlay && _canvas.worldCamera != null)
			{
				RectTransformUtility.ScreenPointToWorldPointInRectangle(_canvas.transform as RectTransform, vector2, _canvas.worldCamera, out var worldPoint);
				_rectTransform.position = worldPoint;
			}
			else
			{
				_rectTransform.position = vector2;
			}
		}
	}
}

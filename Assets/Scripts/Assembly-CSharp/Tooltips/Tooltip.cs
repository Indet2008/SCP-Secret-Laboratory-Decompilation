namespace Tooltips
{
	public class Tooltip : global::UnityEngine.MonoBehaviour
	{
		private const float CursorSize = 28f;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.RectTransform _rectTransform;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.RectTransform _background;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TMP_Text _textComponent;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Canvas _canvas;

		[global::UnityEngine.SerializeField]
		private float _padding;

		public void SetText(string text)
		{
		}

		public void SetPosition(global::UnityEngine.Vector3 position)
		{
		}

		public Tooltip()
		{
		}
	}
}

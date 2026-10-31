public class MouseAreaDetector : global::UnityEngine.MonoBehaviour
{
	public global::UnityEngine.UI.CanvasScaler SourceCanvas;

	public global::UnityEngine.RectTransform TopLeftBorder;

	public global::UnityEngine.RectTransform TopRightBorder;

	public global::UnityEngine.RectTransform BottomLeftBorder;

	public global::UnityEngine.RectTransform BottomRightBorder;

	private void Start()
	{
		if (SourceCanvas.uiScaleMode != global::UnityEngine.UI.CanvasScaler.ScaleMode.ScaleWithScreenSize)
		{
			global::UnityEngine.Debug.LogError("Canvas must be set to ScaleWithScreenSize, so MouseAreaDetector can work");
			base.enabled = false;
		}
	}

	public bool IsInBorders()
	{
		global::UnityEngine.Vector3 mousePosition = global::UnityEngine.Input.mousePosition;
		if (mousePosition.x > TopRightBorder.transform.position.x || mousePosition.y > TopLeftBorder.transform.position.y || BottomLeftBorder.transform.position.x > mousePosition.x || BottomRightBorder.transform.position.y > mousePosition.y)
		{
			return false;
		}
		return true;
	}
}

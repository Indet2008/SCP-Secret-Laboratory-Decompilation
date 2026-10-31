public class ServerCustomScrollRect : global::UnityEngine.MonoBehaviour
{
	public ServerFilter BrowserReference;

	public MouseAreaDetector ScrollArea;

	public global::UnityEngine.UI.Scrollbar TargetScrollbar;

	private void Update()
	{
		int count = BrowserReference.FilteredListItems.Count;
		TargetScrollbar.size = global::UnityEngine.Mathf.Clamp(1f / (float)count, 0.03f, 1f);
		TargetScrollbar.gameObject.SetActive(TargetScrollbar.size < 1f);
		if (BrowserReference.ScrollStartPoint >= count)
		{
			BrowserReference.ScrollStartPoint = count - 1;
			BrowserReference.DisplayServers();
		}
		int scrollStartPoint = BrowserReference.ScrollStartPoint;
		int num = (int)global::UnityEngine.Mathf.Clamp(global::UnityEngine.Input.GetAxis("Mouse ScrollWheel") * 100f, -1f, 1f);
		int num2 = global::UnityEngine.Mathf.Clamp(scrollStartPoint - num, 0, count - 1);
		TargetScrollbar.value = (float)num2 / (float)(count - 1);
		if (num2 != scrollStartPoint && ScrollArea.IsInBorders())
		{
			BrowserReference.ScrollStartPoint = num2;
			BrowserReference.DisplayServers();
		}
	}

	public void ScrollbarValueChanged()
	{
		float num = TargetScrollbar.value;
		if (TargetScrollbar.numberOfSteps > 1)
		{
			num = global::UnityEngine.Mathf.Round(num * (float)(TargetScrollbar.numberOfSteps - 1)) / (float)(TargetScrollbar.numberOfSteps - 1);
		}
		BrowserReference.ScrollStartPoint = global::UnityEngine.Mathf.RoundToInt((float)(BrowserReference.FilteredListItems.Count - 1) * num);
		BrowserReference.DisplayServers();
	}
}

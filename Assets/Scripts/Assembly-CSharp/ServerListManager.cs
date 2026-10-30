using UnityEngine;

public class ServerListManager : MonoBehaviour
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	public global::UnityEngine.RectTransform contentParent;

	public global::UnityEngine.RectTransform element;

	public global::UnityEngine.UI.Text loadingText;


	private static string _filter;

	private void Awake()
	{
		_filter = string.Empty;
	}
}

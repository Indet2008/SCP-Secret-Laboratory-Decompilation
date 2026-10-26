// Client-only (bodies stripped from the server build); ported from the SL 12 CE client.
public class NewsElement : global::UnityEngine.MonoBehaviour
{
	public global::TMPro.TextMeshProUGUI Title;

	public global::TMPro.TextMeshProUGUI Date;

	public global::TMPro.TextMeshProUGUI Content;

	public global::UnityEngine.UI.Image Background;

	public int Id;

	private NewsLoader _loader;

	private void Start()
	{
		_loader = GetComponentInParent<NewsLoader>();
	}

	public void OnClick()
	{
		if (_loader == null)
		{
			_loader = GetComponentInParent<NewsLoader>();
		}
		_loader?.ShowAnnouncement(Id);
	}
}

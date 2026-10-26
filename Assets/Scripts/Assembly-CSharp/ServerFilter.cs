public class ServerFilter : global::UnityEngine.MonoBehaviour
{
	public global::UnityEngine.UI.InputField NameFilterField;

	public global::UnityEngine.Sprite[] SelectBoxes;

	public global::UnityEngine.UI.Image[] FilterImages;

	public ServerTab CurrentTab;

	public global::System.Collections.Generic.List<ServerListItem> FilteredListItems;

	private static FilterSettings _curFilters;

	private NewServerBrowser _browser;

	public int ScrollStartPoint;

	public ServerElementButton[] PremadeElements;

	private void Awake()
	{
	}

	public void ChangeTab(int tab)
	{
	}

	public void ReapplyFilters(bool forceCleanup = false)
	{
	}

	public void DisplayServers()
	{
	}

	private void ChangeTab(ServerTab tab)
	{
	}

	public void ApplyNameFilter()
	{
	}

	private void ApplyNameFilter(string nameFilter)
	{
	}

	public void Filters(int id)
	{
	}

	private static bool CheckCheckboxes(ServerListItem server)
	{
		return default;
	}

	private static void SetNameFilterPoints(int id)
	{
	}

	public ServerFilter()
	{
	}
}

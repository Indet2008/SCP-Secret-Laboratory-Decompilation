public class NewServerBrowser : global::UnityEngine.MonoBehaviour
{
	public global::UnityEngine.RectTransform ServerInfo;

	public global::UnityEngine.UI.Text LoadingText;

	public global::UnityEngine.GameObject ServerTabs;

	private static bool _errorDirty;

	private static bool _refresh;

	private static bool _redownload;

	private static bool _threadStarted;

	private static string _errorMessage;

	private static readonly global::System.Threading.Thread _refreshThread;

	public static ServerListItem[] Servers;

	private ServerFilter _serverFilter;

	public static bool IsBusy
	{
		get
		{
			return default;
		}
	}

	private static string LoadingErrorMessage
	{
		set
		{
		}
	}

	private void Start()
	{
	}

	private void OnEnable()
	{
	}

	private void OnDisable()
	{
	}

	private void OnDestroy()
	{
	}

	private void Update()
	{
	}

	public void Refresh()
	{
	}

	public void AuthCompleted()
	{
	}

	internal static void StopThread()
	{
	}

	private static void DownloadList()
	{
	}

	public NewServerBrowser()
	{
	}
}

public class SteamServerManager : global::UnityEngine.MonoBehaviour
{
	public static SteamServerManager Instance;

	private bool _gsInitialized;

	private void Start()
	{
		Instance = this;
	}

	public SteamServerManager()
	{
	}
}

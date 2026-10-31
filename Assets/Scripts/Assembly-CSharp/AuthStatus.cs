public class AuthStatus : global::UnityEngine.MonoBehaviour
{
	public global::UnityEngine.GameObject LoadingCircle;

	public global::TMPro.TextMeshProUGUI Description;

	public NewServerBrowser ServerBrowser;

	private AuthStatusType _lastStatus;

	private void Awake()
	{
		Description.SetText(global::TranslationReader.Get("NewMainMenu", 68, "Connecting to central servers..."));
	}

	private void Update()
	{
		if (_lastStatus == global::CentralAuth.CentralAuthManager.AuthStatusType)
		{
			return;
		}
		_lastStatus = global::CentralAuth.CentralAuthManager.AuthStatusType;
		switch (_lastStatus)
		{
		case AuthStatusType.Connecting:
			LoadingCircle.SetActive(value: true);
			Description.SetText(global::TranslationReader.Get("NewMainMenu", 68, "Connecting to central servers..."));
			break;
		case AuthStatusType.Success:
			LoadingCircle.SetActive(value: false);
			Description.SetText(global::TranslationReader.Get("NewMainMenu", 69, "<color=green>Connection established</color>"));
			ServerBrowser.AuthCompleted();
			break;
		case AuthStatusType.Failure:
			LoadingCircle.SetActive(value: true);
			Description.SetText(global::TranslationReader.Get("NewMainMenu", 70, "<color=red>Connection failure (Check console for details)</color>"));
			break;
		case AuthStatusType.PlatformAuthFailure:
			switch (global::CentralAuth.CentralAuthManager.Platform)
			{
			case global::GameCore.DistributionPlatform.Steam:
				LoadingCircle.SetActive(value: false);
				Description.SetText(global::TranslationReader.Get("NewMainMenu", 71, "<color=red>Steam authentication failure (Check console for details)</color>"));
				break;
			case global::GameCore.DistributionPlatform.Discord:
				LoadingCircle.SetActive(value: false);
				Description.SetText(global::TranslationReader.Get("NewMainMenu", 72, "<color=red>Discord authentication failure (Check console for details)</color>"));
				break;
			}
			break;
		}
	}

	public AuthStatus()
	{
	}
}

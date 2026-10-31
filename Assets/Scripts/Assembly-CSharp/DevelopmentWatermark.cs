public class DevelopmentWatermark : global::UnityEngine.MonoBehaviour
{
	private const int WatermarkLineLenght = 100;

	private const byte WatermarkLineCount = 40;

	[global::UnityEngine.SerializeField]
	private global::TMPro.TextMeshProUGUI _watermarkDisplay;

	private bool _isAuthenticated;

	private void Start()
	{
		global::UnityEngine.GameObject root = base.transform.parent.gameObject;
		if (global::GameCore.Version.StreamingAllowed)
		{
			global::UnityEngine.Object.Destroy(root);
			return;
		}
		global::UnityEngine.Object.DontDestroyOnLoad(root);
		string id;
		switch (global::CentralAuth.CentralAuthManager.Platform)
		{
		case global::GameCore.DistributionPlatform.Steam:
			id = (SteamManager.IsSteamReady() ? global::Steamworks.SteamClient.SteamId.Value.ToString() : "Not initialized");
			break;
		case global::GameCore.DistributionPlatform.Discord:
			id = ((global::CentralAuth.CentralAuthManager.Discord != null) ? global::CentralAuth.CentralAuthManager.Discord.GetUserManager().GetCurrentUser().Id.ToString() : "Not initialized");
			break;
		default:
			id = global::System.Environment.UserName + "/";
			break;
		}
		FillRectWithRepeatingText(id);
	}

	private void Update()
	{
		if (_isAuthenticated || !global::CentralAuth.CentralAuthManager.Authenticated)
		{
			return;
		}
		_isAuthenticated = true;
		if (global::CentralAuth.CentralAuthManager.NoWatermarking)
		{
			global::UnityEngine.Object.Destroy(base.transform.parent.gameObject);
			return;
		}
		string userId = global::CentralAuth.CentralAuthManager.PreauthToken.UserId ?? string.Empty;
		int num = userId.IndexOf('@');
		FillRectWithRepeatingText((num == -1) ? userId : userId.Substring(0, num));
	}

	private void FillRectWithRepeatingText(string id)
	{
		global::System.Text.StringBuilder stringBuilder = global::NorthwoodLib.Pools.StringBuilderPool.Shared.Rent();
		string text = "release-halloween-963b276a-" + global::System.DateTime.UtcNow.ToString(global::System.Globalization.CultureInfo.InvariantCulture);
		_watermarkDisplay.text = string.Empty;
		for (byte b = 0; b < 40; b++)
		{
			bool flag = (b & 1) == 0;
			int num = 0;
			if (flag && (b & 3) != 0)
			{
				string text2 = id.Substring(id.Length / 2);
				num = AppendAndCount(stringBuilder, text2) + 1;
				stringBuilder.Append(' ');
			}
			while (num < 100)
			{
				num += AppendAndCount(stringBuilder, flag ? id : text) + 1;
				stringBuilder.Append(' ');
			}
			stringBuilder.Append('\n');
		}
		_watermarkDisplay.text = stringBuilder.ToString();
		global::NorthwoodLib.Pools.StringBuilderPool.Shared.Return(stringBuilder);
	}

	private static int AppendAndCount(global::System.Text.StringBuilder sb, string text)
	{
		sb.Append(text);
		return text.Length;
	}
}

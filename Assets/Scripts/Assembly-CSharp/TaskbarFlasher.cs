public static class TaskbarFlasher
{
	private struct FlashWindowInfo
	{
		public uint Size;

		public global::System.IntPtr Handle;

		public uint Flags;

		public uint Count;

		public uint Timeout;
	}

	private const string User32 = "User32";

	private static global::System.IntPtr _windowHandle;

	private static global::System.IntPtr WindowHandle
	{
		get
		{
			if (_windowHandle == global::System.IntPtr.Zero)
			{
				_windowHandle = GetWindow();
				if (_windowHandle == global::System.IntPtr.Zero)
				{
					_windowHandle = FindWindow(null, "SCPSL");
				}
			}
			return _windowHandle;
		}
	}

	[global::UnityEngine.RuntimeInitializeOnLoadMethod]
	private static void RegisterEvent()
	{
		_ = WindowHandle;
		global::PlayerRoles.PlayerRoleManager.OnRoleChanged += OnRoleChanged;
		global::UnityEngine.SceneManagement.SceneManager.sceneLoaded += delegate
		{
			SetFlash(enabled: false);
		};
	}

	private static void OnRoleChanged(ReferenceHub hub, global::PlayerRoles.PlayerRoleBase oldRole, global::PlayerRoles.PlayerRoleBase newRole)
	{
		if (hub.isLocalPlayer && global::UserSettings.UserSetting<bool>.Get(global::UserSettings.UserInterfaceSettings.UISetting.FlashTaskbar, defaultValue: true))
		{
			SetFlash(oldRole.Team != newRole.Team);
		}
	}

	private static void SetFlash(bool enabled)
	{
		try
		{
			FlashWindowInfo info = new FlashWindowInfo
			{
				Size = 32u,
				Handle = WindowHandle,
				Flags = (enabled ? 14u : 0u),
				Count = uint.MaxValue,
				Timeout = 0u
			};
			FlashWindow(ref info);
		}
		catch (global::System.Exception exception)
		{
			global::UnityEngine.Debug.LogException(exception);
		}
	}

	[global::System.Runtime.InteropServices.DllImport("User32", EntryPoint = "GetActiveWindow")]
	private static extern global::System.IntPtr GetWindow();

	[global::System.Runtime.InteropServices.DllImport("User32", CharSet = global::System.Runtime.InteropServices.CharSet.Unicode, EntryPoint = "FindWindowW")]
	private static extern global::System.IntPtr FindWindow(string windowClass, string windowName);

	[global::System.Runtime.InteropServices.DllImport("User32", EntryPoint = "FlashWindowEx")]
	private static extern bool FlashWindow(ref FlashWindowInfo info);
}

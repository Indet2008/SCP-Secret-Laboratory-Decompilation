namespace UserSettings.VideoSettings
{
	internal static class FullscreenWindowManager
	{
		private const string LibName = "user32.dll";

		private const int MinimizeCode = 2;

		private const global::UnityEngine.FullScreenMode AutoMinimizeScreenMode = global::UnityEngine.FullScreenMode.MaximizedWindow;

		[global::System.Runtime.InteropServices.DllImport("user32.dll")]
		private static extern global::System.IntPtr GetActiveWindow();

		[global::System.Runtime.InteropServices.DllImport("user32.dll")]
		private static extern bool ShowWindow(global::System.IntPtr hWnd, int nCmdShow);

		[global::UnityEngine.RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			global::UnityEngine.Application.focusChanged += OnFocusChanged;
		}

		private static void OnFocusChanged(bool focusState)
		{
			if (!focusState)
			{
				OnLoseFocus();
			}
		}

		private static void OnLoseFocus()
		{
			if (UserSetting<int>.Get(DisplayVideoSetting.FullscreenMode) == (int)AutoMinimizeScreenMode)
			{
				ShowWindow(GetActiveWindow(), 2);
			}
		}
	}
}

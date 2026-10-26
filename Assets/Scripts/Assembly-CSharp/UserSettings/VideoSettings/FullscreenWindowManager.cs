namespace UserSettings.VideoSettings
{
	internal static class FullscreenWindowManager
	{
		private const string LibName = "user32.dll";

		private const int MinimizeCode = 2;

		private const global::UnityEngine.FullScreenMode AutoMinimizeScreenMode = global::UnityEngine.FullScreenMode.MaximizedWindow;

		[global::System.Runtime.InteropServices.PreserveSig]
		private static extern global::System.IntPtr GetActiveWindow();

		[global::System.Runtime.InteropServices.PreserveSig]
		private static extern bool ShowWindow(global::System.IntPtr hWnd, int nCmdShow);

		[global::UnityEngine.RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
		}

		private static void OnFocusChanged(bool focusState)
		{
		}

		private static void OnLoseFocus()
		{
		}
	}
}

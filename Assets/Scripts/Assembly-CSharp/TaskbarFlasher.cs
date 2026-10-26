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
			return default;
		}
	}

	[global::UnityEngine.RuntimeInitializeOnLoadMethod]
	private static void RegisterEvent()
	{
	}

	private static void OnRoleChanged(ReferenceHub hub, global::PlayerRoles.PlayerRoleBase oldRole, global::PlayerRoles.PlayerRoleBase newRole)
	{
	}

	private static void SetFlash(bool enabled)
	{
	}

	[global::System.Runtime.InteropServices.PreserveSig]
	private static extern global::System.IntPtr GetWindow();

	[global::System.Runtime.InteropServices.PreserveSig]
	private static extern global::System.IntPtr FindWindow(string windowClass, string windowName);

	[global::System.Runtime.InteropServices.PreserveSig]
	private static extern bool FlashWindow(ref TaskbarFlasher.FlashWindowInfo info);
}

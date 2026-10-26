internal static class LauncherCommunicator
{
	internal struct VerificationProgress
	{
		public ulong Progress;

		public ulong Total;
	}

	public struct SdrRequestDataNative
	{
		public global::System.IntPtr url;

		public global::System.UIntPtr data_length;

		public global::System.IntPtr data;

		public global::System.IntPtr type;
	}

	public struct LpStringNative
	{
		public global::System.UIntPtr length;

		public global::System.IntPtr data;
	}

	public struct HttpResultNative
	{
		public int code;

		public global::System.IntPtr output;
	}

	internal unsafe static readonly LauncherCommunicator.VerificationProgress* AssetVerificationProgress;

	internal unsafe static readonly uint* VerificationFinished;

	private static readonly global::System.IntPtr SendMethod;

	private static readonly global::System.IntPtr PostAuth;

	private static readonly global::System.IntPtr SetSDRActiveInteral;

	private static readonly global::System.IntPtr SetSDRInactiveInternal;

	private static readonly global::System.IntPtr ShutdownPtr;

	static LauncherCommunicator()
	{
	}

	private static bool BeforeQuit()
	{
		return default;
	}

	[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
	internal static global::System.ReadOnlySpan<byte> Send(string data)
	{
		return default;
	}

	[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
	internal static void Heartbeat()
	{
	}

	[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
	internal static void SetSDRActive()
	{
	}

	[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
	internal static void SetSDRInactive()
	{
	}

	[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
	internal static void Shutdown()
	{
	}

	[global::UnityEngine.Scripting.Preserve]
	public static global::System.IntPtr Receive(int command, global::System.IntPtr ptr)
	{
		return default;
	}

	[global::System.Runtime.InteropServices.PreserveSig]
	private static extern global::System.IntPtr GetProcAddress(global::System.IntPtr handle, string name);

	private static void WriteRequestResponse(string result, int status, global::System.IntPtr resultPtr)
	{
	}
}

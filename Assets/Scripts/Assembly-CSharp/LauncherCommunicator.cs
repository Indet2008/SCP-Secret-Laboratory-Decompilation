// Rebuilt from the 14.2.8 client disassembly. The function pointers are exported by the official launcher
// process; when the game runs without it (editor, direct exe) they are null, so every call is guarded here
// instead of crashing like the original would.
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

	internal static bool Available => SendMethod != global::System.IntPtr.Zero;

	unsafe static LauncherCommunicator()
	{
		AssetVerificationProgress = (VerificationProgress*)(void*)GetProcAddress(global::System.IntPtr.Zero, "_InterlockedCompareExchange128_np");
		VerificationFinished = (uint*)(void*)GetProcAddress(global::System.IntPtr.Zero, "_InterlockedExchangePointer_HLEAcquire");
		SendMethod = ReadPointer(GetProcAddress(global::System.IntPtr.Zero, "_InterlockedExchangePointer_HLERelease"));
		PostAuth = ReadPointer(GetProcAddress(global::System.IntPtr.Zero, "_InterlockedXor8_np"));
		SetSDRActiveInteral = GetProcAddress(global::System.IntPtr.Zero, "_InterlockedExchange16");
		SetSDRInactiveInternal = GetProcAddress(global::System.IntPtr.Zero, "_InterlockedExchange64");
		ShutdownPtr = GetProcAddress(global::System.IntPtr.Zero, "_InterlockedExchange32");
		global::UnityEngine.Application.wantsToQuit += BeforeQuit;
	}

	private unsafe static global::System.IntPtr ReadPointer(global::System.IntPtr ptr)
	{
		if (!(ptr == global::System.IntPtr.Zero))
		{
			return *(global::System.IntPtr*)(void*)ptr;
		}
		return global::System.IntPtr.Zero;
	}

	private static bool BeforeQuit()
	{
		Shutdown();
		return true;
	}

	[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
	internal unsafe static global::System.ReadOnlySpan<byte> Send(string data)
	{
		if (SendMethod == global::System.IntPtr.Zero)
		{
			return default(global::System.ReadOnlySpan<byte>);
		}
		fixed (char* ptr = data)
		{
			long* ptr2 = ((delegate* unmanaged[Cdecl]<char*, long*>)(void*)SendMethod)(ptr);
			int num = (int)(*ptr2);
			if (num < 0)
			{
				throw new global::System.ArgumentOutOfRangeException("length");
			}
			return new global::System.ReadOnlySpan<byte>(ptr2 + 1, num);
		}
	}

	[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
	internal unsafe static void Heartbeat()
	{
		if (PostAuth != global::System.IntPtr.Zero)
		{
			((delegate* unmanaged[Cdecl]<void>)(void*)PostAuth)();
		}
	}

	internal static void NotifyPostAuth()
	{
		Heartbeat();
	}

	[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
	internal unsafe static void SetSDRActive()
	{
		if (SetSDRActiveInteral != global::System.IntPtr.Zero)
		{
			((delegate* unmanaged[Cdecl]<void>)(void*)SetSDRActiveInteral)();
		}
	}

	[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
	internal unsafe static void SetSDRInactive()
	{
		if (SetSDRInactiveInternal != global::System.IntPtr.Zero)
		{
			((delegate* unmanaged[Cdecl]<void>)(void*)SetSDRInactiveInternal)();
		}
	}

	[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
	internal unsafe static void Shutdown()
	{
		if (ShutdownPtr != global::System.IntPtr.Zero)
		{
			((delegate* unmanaged[Cdecl]<void>)(void*)ShutdownPtr)();
		}
	}

	[global::UnityEngine.Scripting.Preserve]
	public static global::System.IntPtr Receive(int command, global::System.IntPtr ptr)
	{
		try
		{
			switch (command)
			{
			case 0:
			{
				SdrRequestDataNative sdrRequestDataNative = global::System.Runtime.InteropServices.Marshal.PtrToStructure<SdrRequestDataNative>(ptr);
				string url = global::System.Runtime.InteropServices.Marshal.PtrToStringUTF8(sdrRequestDataNative.url);
				string type = global::System.Runtime.InteropServices.Marshal.PtrToStringUTF8(sdrRequestDataNative.type);
				byte[] data = new byte[(int)(ulong)sdrRequestDataNative.data_length];
				global::System.Runtime.InteropServices.Marshal.Copy(sdrRequestDataNative.data, data, 0, data.Length);
				global::System.IntPtr resultPtr = global::System.Runtime.InteropServices.Marshal.AllocHGlobal(global::System.Runtime.InteropServices.Marshal.SizeOf<HttpResultNative>());
				global::System.Runtime.InteropServices.Marshal.StructureToPtr(new HttpResultNative
				{
					code = -1,
					output = global::System.IntPtr.Zero
				}, resultPtr, fDeleteOld: false);
				MainThreadDispatcher.Dispatch(delegate
				{
					if (global::Utils.Http.SDR.SteamDatagramRelayHandler.ShouldUseSDR(url))
					{
						global::Utils.Http.SDR.SteamDatagramRelayHandler.QueueRequest(url, "POST", data, type, delegate(int code, string result)
						{
							WriteRequestResponse(result, code, resultPtr);
						});
					}
					else
					{
						WriteRequestResponse("URL not allowed.", 403, resultPtr);
					}
				});
				return resultPtr;
			}
			case 1:
			{
				HttpResultNative httpResultNative = global::System.Runtime.InteropServices.Marshal.PtrToStructure<HttpResultNative>(ptr);
				global::System.Runtime.InteropServices.Marshal.FreeHGlobal(httpResultNative.output);
				global::System.Runtime.InteropServices.Marshal.FreeHGlobal(ptr);
				return global::System.IntPtr.Zero;
			}
			default:
				return global::System.IntPtr.Zero;
			}
		}
		catch (global::System.Exception value)
		{
			global::System.Console.WriteLine(value);
			return global::System.IntPtr.Zero;
		}
	}

	[global::System.Runtime.InteropServices.DllImport("kernel32", CharSet = global::System.Runtime.InteropServices.CharSet.Ansi, ExactSpelling = true)]
	private static extern global::System.IntPtr GetProcAddress(global::System.IntPtr handle, string name);

	private unsafe static void WriteRequestResponse(string result, int status, global::System.IntPtr resultPtr)
	{
		byte[] bytes = global::System.Text.Encoding.UTF8.GetBytes(result ?? string.Empty);
		global::System.IntPtr intPtr = global::System.Runtime.InteropServices.Marshal.AllocHGlobal(bytes.Length + 8);
		*(long*)(void*)intPtr = bytes.Length;
		global::System.Runtime.InteropServices.Marshal.Copy(bytes, 0, intPtr + 8, bytes.Length);
		((HttpResultNative*)(void*)resultPtr)->output = intPtr;
		((HttpResultNative*)(void*)resultPtr)->code = ((status > 199 && status < 300) ? status : 0);
	}
}

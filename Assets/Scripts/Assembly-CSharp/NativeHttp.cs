internal static class NativeHttp
{
	public struct Config
	{
		public unsafe readonly sbyte* CurlVersion;

		public byte AllowTls12;

		public byte AllowTls13;

		public byte AllowIpv4;

		public byte AllowIpv6;

		public byte AllowHttp2;

		public byte AllowHttp3;

		public byte AllowEch;

		public byte AllowEarlyData;

		public byte EnableDoh;

		public byte EnableNagle;

		public byte WeakSecurity;

		public unsafe readonly sbyte* Proxy;

		public unsafe readonly sbyte* ProxyBypass;

		public override string ToString()
		{
			return default;
		}
	}

	private sealed class Coroutine : HttpCoroutine
	{
		private NativeHttp.AsyncHandle _handle;

		private global::System.Exception _exception;

		internal Coroutine(NativeHttp.AsyncHandle handle)
		{
		}

		internal Coroutine(global::System.Exception exception)
		{
		}

		public override void CheckResult()
		{
		}

		public override string GetText()
		{
			return default;
		}

		public override byte[] GetBytes()
		{
			return default;
		}

		public override global::System.ReadOnlySpan<byte> GetSpan()
		{
			return default;
		}

		public override float Wait()
		{
			return default;
		}

		public override void Dispose()
		{
		}
	}

	private struct AsyncHandle
	{
		private unsafe readonly void* _handle;

		private readonly NativeHttp.NativeData _data;

		public NativeHttp.Output Output
		{
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			readonly get
			{
				return default;
			}
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			private set
			{
			}
		}

		public unsafe AsyncHandle(void* handle, NativeHttp.NativeData data)
		{ this = default;
		}

		public AsyncHandle(NativeHttp.Output output)
		{ this = default;
		}

		public bool Poll()
		{
			return default;
		}
	}

	private readonly struct Output : global::System.IDisposable
	{
		private unsafe readonly NativeHttp.LpString* _data;

		public unsafe Output(NativeHttp.LpString* data)
		{ this = default;
		}

		public global::System.ReadOnlySpan<byte> AsSpan()
		{
			return default;
		}

		public byte[] ToArray()
		{
			return default;
		}

		public override string ToString()
		{
			return default;
		}

		public void Dispose()
		{
		}
	}

	private readonly struct NativeData : global::System.IDisposable
	{
		public unsafe readonly sbyte* Data;

		public readonly nuint Length;

		public NativeData(global::System.ReadOnlySpan<byte> data)
		{ this = default;
		}

		public NativeData(global::System.ReadOnlySpan<char> data)
		{ this = default;
		}

		public void Dispose()
		{
		}
	}

	private struct LpString
	{
		public readonly nuint Length;

		public unsafe fixed byte Output[1];
	}

	private readonly struct Result
	{
		public readonly int Code;

		public unsafe readonly NativeHttp.LpString* Output;
	}

	private readonly struct AsyncResult
	{
		public readonly NativeHttp.Result Result;

		public unsafe readonly void* Handle;
	}


	private unsafe static readonly void* Module;

	private unsafe static readonly NativeHttp.Config* NativeConfig;

	private static readonly nint NativeSendRequest;

	private static readonly nint NativeSendRequestAsync;

	private static readonly global::System.IntPtr NativePollAsync;

	private static readonly global::System.IntPtr FreeLpString;

	public unsafe static ref NativeHttp.Config GetConfig()
	{
		return ref *(NativeHttp.Config*)null;
	}

	public static string Get(string url)
	{
		return default;
	}

	public static global::System.Threading.Tasks.Task<string> GetAsync(string url)
	{
		return default;
	}

	public static HttpCoroutine GetCoroutine(string url)
	{
		return default;
	}

	public static string Post(string url, string data, string contentType)
	{
		return default;
	}

	public static global::System.Threading.Tasks.Task<string> PostAsync(string url, string data, string contentType)
	{
		return default;
	}

	public static HttpCoroutine PostCoroutine(string url, string data, string contentType)
	{
		return default;
	}

	private static global::System.Collections.Generic.IEnumerator<float> Run(global::System.Threading.Tasks.TaskCompletionSource<string> taskCompletionSource, HttpCoroutine coroutine)
	{
		return default;
	}

	private static NativeHttp.Output SendRequest(NativeHttp.NativeData url, NativeHttp.NativeData data, NativeHttp.NativeData contentType)
	{
		return default;
	}

	private static NativeHttp.AsyncHandle SendRequestAsync(NativeHttp.NativeData url, NativeHttp.NativeData data, NativeHttp.NativeData contentType)
	{
		return default;
	}

	private static NativeHttp.Output CheckResult(NativeHttp.Result result)
	{
		return default;
	}

	private unsafe static void* GetModule(string name)
	{
		//IL_0002: Expected I, but got O
		return null;
	}

	private unsafe static void* GetMethod(void* module, string name)
	{
		//IL_0002: Expected I, but got O
		return null;
	}
}

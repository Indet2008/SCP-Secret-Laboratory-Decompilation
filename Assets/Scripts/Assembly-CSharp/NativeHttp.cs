using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using MEC;

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

		public unsafe override string ToString()
		{
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.Append("Curl Version: ").AppendLine((CurlVersion == null) ? "(null)" : new string(CurlVersion));
			stringBuilder.Append("TLS 1.2: ").AppendLine((AllowTls12 != 0).ToString());
			stringBuilder.Append("TLS 1.3: ").AppendLine((AllowTls13 != 0).ToString());
			stringBuilder.Append("IPv4: ").AppendLine((AllowIpv4 != 0).ToString());
			stringBuilder.Append("IPv6: ").AppendLine((AllowIpv6 != 0).ToString());
			stringBuilder.Append("HTTP/2: ").AppendLine((AllowHttp2 != 0).ToString());
			stringBuilder.Append("HTTP/3: ").AppendLine((AllowHttp3 != 0).ToString());
			stringBuilder.Append("ECH: ").AppendLine((AllowEch != 0).ToString());
			stringBuilder.Append("Early Data: ").AppendLine((AllowEarlyData != 0).ToString());
			stringBuilder.Append("DoH: ").AppendLine((EnableDoh != 0).ToString());
			stringBuilder.Append("Nagle: ").AppendLine((EnableNagle != 0).ToString());
			stringBuilder.Append("Weak Security: ").AppendLine((WeakSecurity != 0).ToString());
			stringBuilder.Append("Proxy: ").AppendLine((Proxy == null) ? "(null)" : new string(Proxy));
			stringBuilder.Append("Proxy Bypass: ").Append((ProxyBypass == null) ? "(null)" : new string(ProxyBypass));
			return stringBuilder.ToString();
		}
	}

	private sealed class Coroutine : HttpCoroutine
	{
		private AsyncHandle _handle;

		private Exception _exception;

		internal Coroutine(AsyncHandle handle)
		{
			_handle = handle;
		}

		internal Coroutine(Exception exception)
		{
			_exception = exception;
		}

		public override void CheckResult()
		{
			if (_exception != null)
			{
				throw _exception;
			}
		}

		public override string GetText()
		{
			CheckResult();
			return Encoding.UTF8.GetString(_handle.Output.AsSpan());
		}

		public override byte[] GetBytes()
		{
			CheckResult();
			return _handle.Output.ToArray();
		}

		public override ReadOnlySpan<byte> GetSpan()
		{
			CheckResult();
			return _handle.Output.AsSpan();
		}

		public override float Wait()
		{
			if (Poll())
			{
				return 0f;
			}
			return Timing.WaitUntilTrue(Poll);
		}

		private bool Poll()
		{
			if (_exception != null)
			{
				return true;
			}
			try
			{
				return _handle.Poll();
			}
			catch (Exception exception)
			{
				_exception = exception;
				return true;
			}
		}

		public override void Dispose()
		{
			_handle.Output.Dispose();
		}
	}

	private struct AsyncHandle
	{
		private unsafe void* _handle;

		private NativeData _data;

		public Output Output { get; private set; }

		public unsafe AsyncHandle(void* handle, NativeData data)
		{
			_handle = handle;
			_data = data;
			Output = default(Output);
		}

		public unsafe AsyncHandle(Output output)
		{
			_handle = null;
			_data = default(NativeData);
			Output = output;
		}

		public unsafe bool Poll()
		{
			if (_handle == null)
			{
				return true;
			}
			AsyncResult asyncResult = ((delegate* unmanaged[Cdecl]<void*, AsyncResult>)NativePollAsync)(_handle);
			if (asyncResult.Result.Code == -1)
			{
				return false;
			}
			_handle = null;
			_data.Dispose();
			Output = CheckResult(asyncResult.Result);
			return true;
		}
	}

	private readonly struct Output : IDisposable
	{
		private unsafe readonly LpString* _data;

		public unsafe Output(LpString* data)
		{
			_data = data;
		}

		public unsafe ReadOnlySpan<byte> AsSpan()
		{
			if (_data == null)
			{
				return ReadOnlySpan<byte>.Empty;
			}
			return new ReadOnlySpan<byte>(_data->Output, checked((int)_data->Length));
		}

		public byte[] ToArray()
		{
			return AsSpan().ToArray();
		}

		public override string ToString()
		{
			return Encoding.UTF8.GetString(AsSpan());
		}

		public unsafe void Dispose()
		{
			if (_data != null)
			{
				((delegate* unmanaged[Cdecl]<LpString*, void>)FreeLpString)(_data);
			}
		}
	}

	private readonly struct NativeData : IDisposable
	{
		public unsafe readonly sbyte* Data;

		public readonly nuint Length;

		public unsafe NativeData(ReadOnlySpan<byte> data)
		{
			Data = (sbyte*)Marshal.AllocHGlobal(data.Length + 1);
			data.CopyTo(new Span<byte>(Data, data.Length));
			Length = (nuint)data.Length;
			Data[data.Length] = 0;
		}

		public unsafe NativeData(ReadOnlySpan<char> data)
		{
			int num = Encoding.UTF8.GetMaxByteCount(data.Length) + 1;
			Data = (sbyte*)Marshal.AllocHGlobal(num);
			int bytes = Encoding.UTF8.GetBytes(data, new Span<byte>(Data, num));
			Length = (nuint)bytes;
			Data[bytes] = 0;
		}

		public unsafe void Dispose()
		{
			if (Data != null)
			{
				Marshal.FreeHGlobal((IntPtr)Data);
			}
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

		public unsafe readonly LpString* Output;
	}

	private readonly struct AsyncResult
	{
		public readonly Result Result;

		public unsafe readonly void* Handle;
	}

	private unsafe static readonly void* Module;

	private unsafe static readonly Config* NativeConfig;

	private static readonly nint NativeSendRequest;

	private static readonly nint NativeSendRequestAsync;

	private static readonly IntPtr NativePollAsync;

	private static readonly IntPtr FreeLpString;

	unsafe static NativeHttp()
	{
		Module = GetModule("SL-AC");
		NativeConfig = ((delegate* unmanaged[Cdecl]<Config*>)GetMethod(Module, "GetConfig"))();
		NativeSendRequest = (nint)GetMethod(Module, "SendRequest");
		NativeSendRequestAsync = (nint)GetMethod(Module, "SendRequestAsync");
		NativePollAsync = (IntPtr)GetMethod(Module, "PollAsync");
		FreeLpString = (IntPtr)GetMethod(Module, "FreeLpString");
	}

	public unsafe static ref Config GetConfig()
	{
		return ref *NativeConfig;
	}

	public static string Get(string url)
	{
		using NativeData url2 = new NativeData(url.AsSpan());
		using NativeData data = default(NativeData);
		using NativeData contentType = default(NativeData);
		using Output output = SendRequest(url2, data, contentType);
		return Encoding.UTF8.GetString(output.AsSpan());
	}

	public static Task<string> GetAsync(string url)
	{
		TaskCompletionSource<string> taskCompletionSource = new TaskCompletionSource<string>();
		if (PlatformInfo.singleton.IsMainThread)
		{
			Start(taskCompletionSource, url);
		}
		else
		{
			Dispatch(taskCompletionSource, url);
		}
		return taskCompletionSource.Task;
		static void Dispatch(TaskCompletionSource<string> taskCompletionSource2, string url2)
		{
			MainThreadDispatcher.Dispatch(delegate
			{
				Start(taskCompletionSource2, url2);
			});
		}
		static void Start(TaskCompletionSource<string> taskCompletionSource2, string url2)
		{
			try
			{
				Timing.RunCoroutine(Run(taskCompletionSource2, GetCoroutine(url2)));
			}
			catch (Exception exception)
			{
				taskCompletionSource2.TrySetException(exception);
			}
		}
	}

	public static HttpCoroutine GetCoroutine(string url)
	{
		try
		{
			NativeData url2 = new NativeData(url.AsSpan());
			try
			{
				return new Coroutine(SendRequestAsync(url2, default(NativeData), default(NativeData)));
			}
			finally
			{
				url2.Dispose();
			}
		}
		catch (Exception exception)
		{
			return new Coroutine(exception);
		}
	}

	public static string Post(string url, string data, string contentType)
	{
		using NativeData url2 = new NativeData(url.AsSpan());
		using NativeData data2 = new NativeData(data.AsSpan());
		using NativeData contentType2 = new NativeData(contentType.AsSpan());
		using Output output = SendRequest(url2, data2, contentType2);
		return Encoding.UTF8.GetString(output.AsSpan());
	}

	public static Task<string> PostAsync(string url, string data, string contentType)
	{
		TaskCompletionSource<string> taskCompletionSource = new TaskCompletionSource<string>();
		if (PlatformInfo.singleton.IsMainThread)
		{
			Start(taskCompletionSource, url, data, contentType);
		}
		else
		{
			Dispatch(taskCompletionSource, url, data, contentType);
		}
		return taskCompletionSource.Task;
		static void Dispatch(TaskCompletionSource<string> taskCompletionSource2, string url2, string data2, string contentType2)
		{
			MainThreadDispatcher.Dispatch(delegate
			{
				Start(taskCompletionSource2, url2, data2, contentType2);
			});
		}
		static void Start(TaskCompletionSource<string> taskCompletionSource2, string url2, string data2, string contentType2)
		{
			try
			{
				Timing.RunCoroutine(Run(taskCompletionSource2, PostCoroutine(url2, data2, contentType2)));
			}
			catch (Exception exception)
			{
				taskCompletionSource2.TrySetException(exception);
			}
		}
	}

	public static HttpCoroutine PostCoroutine(string url, string data, string contentType)
	{
		try
		{
			NativeData url2 = new NativeData(url.AsSpan());
			NativeData contentType2 = new NativeData(contentType.AsSpan());
			try
			{
				return new Coroutine(SendRequestAsync(url2, new NativeData(data.AsSpan()), contentType2));
			}
			finally
			{
				url2.Dispose();
				contentType2.Dispose();
			}
		}
		catch (Exception exception)
		{
			return new Coroutine(exception);
		}
	}

	private static IEnumerator<float> Run(TaskCompletionSource<string> taskCompletionSource, HttpCoroutine coroutine)
	{
		using (coroutine)
		{
			yield return coroutine.Wait();
			try
			{
				taskCompletionSource.TrySetResult(coroutine.GetText());
			}
			catch (Exception exception)
			{
				taskCompletionSource.TrySetException(exception);
			}
		}
	}

	private unsafe static Output SendRequest(NativeData url, NativeData data, NativeData contentType)
	{
		return CheckResult(((delegate* unmanaged[Cdecl]<sbyte*, sbyte*, nuint, sbyte*, Result>)NativeSendRequest)(url.Data, data.Data, data.Length, contentType.Data));
	}

	private unsafe static AsyncHandle SendRequestAsync(NativeData url, NativeData data, NativeData contentType)
	{
		AsyncResult asyncResult = ((delegate* unmanaged[Cdecl]<sbyte*, sbyte*, nuint, sbyte*, AsyncResult>)NativeSendRequestAsync)(url.Data, data.Data, data.Length, contentType.Data);
		if (asyncResult.Handle != null)
		{
			return new AsyncHandle(asyncResult.Handle, data);
		}
		data.Dispose();
		return new AsyncHandle(CheckResult(asyncResult.Result));
	}

	private unsafe static Output CheckResult(Result result)
	{
		if (result.Code != 0)
		{
			Throw(result.Code, result.Output);
		}
		return new Output(result.Output);
		static void Throw(int code, LpString* output)
		{
			string message;
			using (Output output2 = new Output(output))
			{
				message = output2.ToString();
			}
			throw new NativeHttpException(code, message);
		}
	}

	private unsafe static void* GetModule(string name)
	{
		if (!GetModuleHandleExW(1u, name, out var module))
		{
			throw new Win32Exception(Marshal.GetLastWin32Error());
		}
		return (void*)module;
	}

	private unsafe static void* GetMethod(void* module, string name)
	{
		using NativeData nativeData = new NativeData(name.AsSpan());
		IntPtr procAddress = GetProcAddress((IntPtr)module, nativeData.Data);
		if (procAddress == IntPtr.Zero)
		{
			throw new Win32Exception(Marshal.GetLastWin32Error());
		}
		return (void*)procAddress;
	}

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern bool GetModuleHandleExW(uint dwFlags, string lpModuleName, out IntPtr phModule);

	[DllImport("kernel32.dll", SetLastError = true)]
	private unsafe static extern IntPtr GetProcAddress(IntPtr hModule, sbyte* lpProcName);
}

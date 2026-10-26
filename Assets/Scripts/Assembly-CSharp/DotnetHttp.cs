using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Authentication;
using System.Text;
using System.Threading.Tasks;
using MEC;

internal static class DotnetHttp
{
	private sealed class Coroutine : HttpCoroutine
	{
		private byte[] _data;

		private Exception _exception;

		internal async void Run(Task<byte[]> task)
		{
			try
			{
				_data = await task.ConfigureAwait(continueOnCapturedContext: false);
			}
			catch (Exception exception)
			{
				_exception = exception;
			}
		}

		internal void SetException(Exception exception)
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
			return Encoding.UTF8.GetString(_data);
		}

		public override byte[] GetBytes()
		{
			return GetSpan().ToArray();
		}

		public override ReadOnlySpan<byte> GetSpan()
		{
			return _data;
		}

		public override float Wait()
		{
			if (_data == null && _exception == null)
			{
				return WaitAsync();
			}
			return float.NegativeInfinity;
			float WaitAsync()
			{
				return Timing.WaitUntilTrue(() => _data != null || _exception != null);
			}
		}

		public override void Dispose()
		{
		}
	}

	private const string UserAgent = "SCPSL";

	private static readonly HttpClient Client = CreateClient();

	private static HttpClient CreateClient()
	{
		(SslProtocols, SecurityProtocolType) tuple = (SslProtocols.None, SecurityProtocolType.SystemDefault);
		if (StartupArgs.Args.Any((string arg) => arg == "--tls13"))
		{
			tuple.Item1 |= SslProtocols.Tls13;
			tuple.Item2 |= SecurityProtocolType.Tls13;
		}
		if (StartupArgs.Args.Any((string arg) => arg == "--tls12"))
		{
			tuple.Item1 |= SslProtocols.Tls12;
			tuple.Item2 |= SecurityProtocolType.Tls12;
		}
		(SslProtocols, SecurityProtocolType) tuple2 = tuple;
		if (tuple2.Item1 == SslProtocols.None && tuple2.Item2 == SecurityProtocolType.SystemDefault)
		{
			tuple = (SslProtocols.Tls12 | SslProtocols.Tls13, SecurityProtocolType.Tls12 | SecurityProtocolType.Tls13);
		}
		if (HttpQuery.WeakSecurity)
		{
			tuple = (SslProtocols.Tls12, SecurityProtocolType.Tls12);
		}
		ServicePointManager.SecurityProtocol = tuple.Item2;
		return new HttpClient(new HttpClientHandler
		{
			SslProtocols = tuple.Item1,
			AutomaticDecompression = (DecompressionMethods.GZip | DecompressionMethods.Deflate)
		})
		{
			Timeout = TimeSpan.FromSeconds(15.0),
			DefaultRequestHeaders = { { "User-Agent", "SCPSL" } }
		};
	}

	private static async Task<byte[]> GetCore(string url)
	{
		_ = 1;
		try
		{
			using HttpResponseMessage request = await Client.GetAsync(url).ConfigureAwait(continueOnCapturedContext: false);
			request.EnsureSuccessStatusCode();
			using HttpContent content = request.Content;
			return await content.ReadAsByteArrayAsync().ConfigureAwait(continueOnCapturedContext: false);
		}
		catch (Exception innerException)
		{
			throw new DotnetHttpException(innerException);
		}
	}

	private static async Task<byte[]> PostCore(string url, string data, string contentType)
	{
		_ = 1;
		try
		{
			using StringContent body = new StringContent(data, Encoding.UTF8, contentType);
			using HttpResponseMessage request = await Client.PostAsync(url, body).ConfigureAwait(continueOnCapturedContext: false);
			request.EnsureSuccessStatusCode();
			using HttpContent content = request.Content;
			return await content.ReadAsByteArrayAsync().ConfigureAwait(continueOnCapturedContext: false);
		}
		catch (Exception innerException)
		{
			throw new DotnetHttpException(innerException);
		}
	}

	public static string Get(string url)
	{
		return GetAsync(url).GetAwaiter().GetResult();
	}

	public static async Task<string> GetAsync(string url)
	{
		Encoding uTF = Encoding.UTF8;
		return uTF.GetString(await GetCore(url).ConfigureAwait(continueOnCapturedContext: false));
	}

	public static HttpCoroutine GetCoroutine(string url)
	{
		Coroutine coroutine = new Coroutine();
		try
		{
			coroutine.Run(GetCore(url));
		}
		catch (Exception exception)
		{
			coroutine.SetException(exception);
		}
		return coroutine;
	}

	public static string Post(string url, string data, string contentType)
	{
		return PostAsync(url, data, contentType).GetAwaiter().GetResult();
	}

	public static async Task<string> PostAsync(string url, string data, string contentType)
	{
		Encoding uTF = Encoding.UTF8;
		return uTF.GetString(await PostCore(url, data, contentType).ConfigureAwait(continueOnCapturedContext: false));
	}

	public static HttpCoroutine PostCoroutine(string url, string data, string contentType)
	{
		Coroutine coroutine = new Coroutine();
		try
		{
			coroutine.Run(PostCore(url, data, contentType));
		}
		catch (Exception exception)
		{
			coroutine.SetException(exception);
		}
		return coroutine;
	}
}

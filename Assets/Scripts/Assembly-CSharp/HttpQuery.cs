using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Utils.Http.SDR;

public static class HttpQuery
{
	private const string ThreadMessage = "Coroutines are only supported on the main thread!";

	public static readonly bool WeakSecurity = IsWeakSecurity();

	public static event Action<Exception> OnException;

	private static bool IsWeakSecurity()
	{
		return StartupArgs.Args.Any((string arg) => arg == "--weak-http-security");
	}

	public static string GetInfo()
	{
		return $"HTTP client: {ManagedHttp.Client}\nEncryption: {ServicePointManager.SecurityProtocol}\nWeak Security: {WeakSecurity}";
	}

	public static string Get(string url)
	{
		if (SteamDatagramRelayHandler.ShouldUseSDR(url))
		{
			return SDRHttpQuery.Get(url);
		}
		return ManagedHttp.Get(url);
	}

	public static Task<string> GetAsync(string url)
	{
		if (SteamDatagramRelayHandler.ShouldUseSDR(url))
		{
			return SDRHttpQuery.GetAsync(url);
		}
		return ManagedHttp.GetAsync(url);
	}

	public static HttpCoroutine GetCoroutine(string url)
	{
		if (!PlatformInfo.singleton.IsMainThread)
		{
			throw new InvalidOperationException("Coroutines are only supported on the main thread!");
		}
		if (SteamDatagramRelayHandler.ShouldUseSDR(url))
		{
			return SDRHttpQuery.GetCoroutine(url);
		}
		return ManagedHttp.GetCoroutine(url);
	}

	public static string Post(string url, string data, string contentType)
	{
		if (SteamDatagramRelayHandler.ShouldUseSDR(url))
		{
			return SDRHttpQuery.Post(url, data, contentType);
		}
		return ManagedHttp.Post(url, data, contentType);
	}

	public static Task<string> PostAsync(string url, string data, string contentType)
	{
		if (SteamDatagramRelayHandler.ShouldUseSDR(url))
		{
			return SDRHttpQuery.PostAsync(url, data, contentType);
		}
		return ManagedHttp.PostAsync(url, data, contentType);
	}

	public static HttpCoroutine PostCoroutine(string url, string data, string contentType)
	{
		if (!PlatformInfo.singleton.IsMainThread)
		{
			throw new InvalidOperationException("Coroutines are only supported on the main thread!");
		}
		if (SteamDatagramRelayHandler.ShouldUseSDR(url))
		{
			return SDRHttpQuery.PostCoroutine(url, data, contentType);
		}
		return ManagedHttp.PostCoroutine(url, data, contentType);
	}

	public static string ToPostArgs(IEnumerable<string> data)
	{
		return string.Join('&', data.Select((string element) => element.Replace("&", "[AMP]")));
	}

	public static string ToPostArgs(IEnumerable<(string, string)> data)
	{
		return string.Join('&', data.Select(((string, string) element) => (element.Item1 + "=" + element.Item2).Replace("&", "[AMP]")));
	}

	internal static void InvokeExceptionHandler(Exception exception)
	{
		OnException?.Invoke(exception);
	}
}

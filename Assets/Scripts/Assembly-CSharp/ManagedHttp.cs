using System.Linq;
using System.Threading.Tasks;

internal static class ManagedHttp
{
	public enum Mode : byte
	{
		HttpClient = 0,
		UnityWebRequest = 1
	}

	public const int TimeOut = 15;

	public static readonly Mode Client = (StartupArgs.Args.Any((string arg) => arg == "--unity-web-request") ? Mode.UnityWebRequest : Mode.HttpClient);

	public static string Get(string url)
	{
		if (Client != Mode.HttpClient)
		{
			return UnityHttp.Get(url);
		}
		return DotnetHttp.Get(url);
	}

	public static Task<string> GetAsync(string url)
	{
		if (Client != Mode.HttpClient)
		{
			return UnityHttp.GetAsync(url);
		}
		return DotnetHttp.GetAsync(url);
	}

	public static HttpCoroutine GetCoroutine(string url)
	{
		if (Client != Mode.HttpClient)
		{
			return UnityHttp.GetCoroutine(url);
		}
		return DotnetHttp.GetCoroutine(url);
	}

	public static string Post(string url, string data, string contentType)
	{
		if (Client != Mode.HttpClient)
		{
			return UnityHttp.Post(url, data, contentType);
		}
		return DotnetHttp.Post(url, data, contentType);
	}

	public static Task<string> PostAsync(string url, string data, string contentType)
	{
		if (Client != Mode.HttpClient)
		{
			return UnityHttp.PostAsync(url, data, contentType);
		}
		return DotnetHttp.PostAsync(url, data, contentType);
	}

	public static HttpCoroutine PostCoroutine(string url, string data, string contentType)
	{
		if (Client != Mode.HttpClient)
		{
			return UnityHttp.PostCoroutine(url, data, contentType);
		}
		return DotnetHttp.PostCoroutine(url, data, contentType);
	}
}

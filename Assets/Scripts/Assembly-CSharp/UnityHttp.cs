using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using MEC;
using UnityEngine.Networking;

internal static class UnityHttp
{
	private sealed class Coroutine : HttpCoroutine
	{
		private readonly UnityWebRequest _request;

		public Coroutine(UnityWebRequest request)
		{
			_request = request;
			request.timeout = 15;
		}

		public override void CheckResult()
		{
			if (_request.result != UnityWebRequest.Result.Success)
			{
				throw new UnityHttpException(_request.error);
			}
		}

		public override string GetText()
		{
			return Encoding.UTF8.GetString(GetSpan());
		}

		public override byte[] GetBytes()
		{
			return GetSpan().ToArray();
		}

		public override ReadOnlySpan<byte> GetSpan()
		{
			return _request.downloadHandler.nativeData;
		}

		public override float Wait()
		{
			return Timing.WaitUntilDone(_request.SendWebRequest());
		}

		public override void Dispose()
		{
			_request.Dispose();
		}
	}

	private const int SleepTime = 15;

	public static string Get(string url)
	{
		if (!PlatformInfo.singleton.IsMainThread)
		{
			return Dispatch(url);
		}
		return Start(url);
		static string Dispatch(string url2)
		{
			object result = null;
			MainThreadDispatcher.Dispatch(() =>
			{
				try
				{
					Volatile.Write(ref result, Start(url2));
				}
				catch (Exception value)
				{
					Volatile.Write(ref result, value);
				}
			});
			while (Volatile.Read(ref result) == null)
			{
				Thread.Sleep(15);
			}
			object obj = Volatile.Read(ref result);
			if (!(obj is Exception ex))
			{
				return (string)obj;
			}
			throw ex;
		}
		static string Start(string uri)
		{
			using UnityWebRequest unityWebRequest = UnityWebRequest.Get(uri);
			unityWebRequest.timeout = 15;
			UnityWebRequestAsyncOperation unityWebRequestAsyncOperation = unityWebRequest.SendWebRequest();
			while (!unityWebRequestAsyncOperation.isDone)
			{
				Thread.Sleep(15);
			}
			if (unityWebRequest.result != UnityWebRequest.Result.Success)
			{
				throw new UnityHttpException(unityWebRequest.error);
			}
			return Encoding.UTF8.GetString(unityWebRequest.downloadHandler.nativeData);
		}
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
			MainThreadDispatcher.Dispatch(() =>
			{
				Start(taskCompletionSource2, url2);
			});
		}
		static void Start(TaskCompletionSource<string> taskCompletionSource2, string uri)
		{
			try
			{
				Timing.RunCoroutine(Run(taskCompletionSource2, UnityWebRequest.Get(uri)));
			}
			catch (Exception exception)
			{
				taskCompletionSource2.SetException(exception);
			}
		}
	}

	public static HttpCoroutine GetCoroutine(string url)
	{
		return new Coroutine(UnityWebRequest.Get(url));
	}

	public static string Post(string url, string data, string contentType)
	{
		if (!PlatformInfo.singleton.IsMainThread)
		{
			return Dispatch(url, data, contentType);
		}
		return Start(url, data, contentType);
		static string Dispatch(string url2, string data2, string contentType2)
		{
			object result = null;
			MainThreadDispatcher.Dispatch(() =>
			{
				try
				{
					Volatile.Write(ref result, Start(url2, data2, contentType2));
				}
				catch (Exception value)
				{
					Volatile.Write(ref result, value);
				}
			});
			while (Volatile.Read(ref result) == null)
			{
				Thread.Sleep(15);
			}
			object obj = Volatile.Read(ref result);
			if (!(obj is Exception ex))
			{
				return (string)obj;
			}
			throw ex;
		}
		static string Start(string uri, string postData, string contentType2)
		{
			using UnityWebRequest unityWebRequest = UnityWebRequest.Post(uri, postData, contentType2);
			unityWebRequest.timeout = 15;
			UnityWebRequestAsyncOperation unityWebRequestAsyncOperation = unityWebRequest.SendWebRequest();
			while (!unityWebRequestAsyncOperation.isDone)
			{
				Thread.Sleep(15);
			}
			if (unityWebRequest.result != UnityWebRequest.Result.Success)
			{
				throw new UnityHttpException(unityWebRequest.error);
			}
			return Encoding.UTF8.GetString(unityWebRequest.downloadHandler.nativeData);
		}
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
			MainThreadDispatcher.Dispatch(() =>
			{
				Start(taskCompletionSource2, url2, data2, contentType2);
			});
		}
		static void Start(TaskCompletionSource<string> taskCompletionSource2, string uri, string postData, string contentType2)
		{
			try
			{
				Timing.RunCoroutine(Run(taskCompletionSource2, UnityWebRequest.Post(uri, postData, contentType2)));
			}
			catch (Exception exception)
			{
				taskCompletionSource2.SetException(exception);
			}
		}
	}

	public static HttpCoroutine PostCoroutine(string url, string data, string contentType)
	{
		return new Coroutine(UnityWebRequest.Post(url, data, contentType));
	}

	private static IEnumerator<float> Run(TaskCompletionSource<string> taskCompletionSource, UnityWebRequest request)
	{
		using (request)
		{
			request.timeout = 15;
			yield return Timing.WaitUntilDone(request.SendWebRequest());
			try
			{
				if (request.result != UnityWebRequest.Result.Success)
				{
					throw new UnityHttpException(request.error);
				}
				taskCompletionSource.SetResult(Encoding.UTF8.GetString(request.downloadHandler.nativeData));
			}
			catch (Exception exception)
			{
				taskCompletionSource.SetException(exception);
			}
		}
	}
}

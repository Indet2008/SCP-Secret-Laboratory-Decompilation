using System;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using MEC;

namespace Utils.Http.SDR
{
	internal static class SDRHttpQuery
	{
		private sealed class Coroutine : HttpCoroutine
		{
			private string _response;

			private Exception _exception;

			internal void ProcessResponse(int statusCode, string response)
			{
				if (statusCode < 200 || statusCode > 299)
				{
					_exception = new SDRHttpException(statusCode, response);
				}
				else
				{
					_response = response;
				}
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
				return _response;
			}

			public override byte[] GetBytes()
			{
				return Encoding.UTF8.GetBytes(_response);
			}

			public override ReadOnlySpan<byte> GetSpan()
			{
				return Encoding.UTF8.GetBytes(_response).AsSpan();
			}

			public override float Wait()
			{
				if (_response == null && _exception == null)
				{
					return WaitAsync();
				}
				return float.NegativeInfinity;
				float WaitAsync()
				{
					return Timing.WaitUntilTrue(() => _response != null || _exception != null);
				}
			}

			public override void Dispose()
			{
				throw new NotImplementedException();
			}
		}

		public static string Get(string url)
		{
			bool completed = false;
			int statusCode = 0;
			string response = string.Empty;
			SteamDatagramRelayHandler.QueueRequest(url, "GET", "", "", (int code, string content) =>
			{
				statusCode = code;
				response = content;
				completed = true;
			});
			while (!completed)
			{
				Thread.Sleep(100);
			}
			if (statusCode < 200 || statusCode > 299)
			{
				throw new SDRHttpException(statusCode, response);
			}
			return response;
		}

		public static async Task<string> GetAsync(string url)
		{
			bool completed = false;
			int statusCode = 0;
			string response = string.Empty;
			SteamDatagramRelayHandler.QueueRequest(url, "GET", "", "", (int code, string content) =>
			{
				statusCode = code;
				response = content;
				completed = true;
			});
			while (!completed)
			{
				await Task.Delay(100);
			}
			if (statusCode < 200 || statusCode > 299)
			{
				throw new SDRHttpException(statusCode, response);
			}
			return response;
		}

		public static HttpCoroutine GetCoroutine(string url)
		{
			Coroutine coroutine = new Coroutine();
			SteamDatagramRelayHandler.QueueRequest(url, "GET", "", "", (int code, string content) =>
			{
				coroutine.ProcessResponse(code, content);
			});
			return coroutine;
		}

		public static string Post(string url, string data, string contentType)
		{
			bool completed = false;
			int statusCode = 0;
			string response = string.Empty;
			SteamDatagramRelayHandler.QueueRequest(url, "POST", data, contentType, (int code, string content) =>
			{
				statusCode = code;
				response = content;
				completed = true;
			});
			while (!completed)
			{
				Thread.Sleep(100);
			}
			if (statusCode < 200 || statusCode > 299)
			{
				throw new SDRHttpException(statusCode, response);
			}
			return response;
		}

		public static async Task<string> PostAsync(string url, string data, string contentType)
		{
			bool completed = false;
			int statusCode = 0;
			string response = string.Empty;
			SteamDatagramRelayHandler.QueueRequest(url, "POST", data, contentType, (int code, string content) =>
			{
				statusCode = code;
				response = content;
				completed = true;
			});
			while (!completed)
			{
				await Task.Delay(100);
			}
			if (statusCode < 200 || statusCode > 299)
			{
				throw new SDRHttpException(statusCode, response);
			}
			return response;
		}

		public static HttpCoroutine PostCoroutine(string url, string data, string contentType)
		{
			Coroutine coroutine = new Coroutine();
			SteamDatagramRelayHandler.QueueRequest(url, "POST", data, contentType, (int code, string content) =>
			{
				coroutine.ProcessResponse(code, content);
			});
			return coroutine;
		}
	}
}

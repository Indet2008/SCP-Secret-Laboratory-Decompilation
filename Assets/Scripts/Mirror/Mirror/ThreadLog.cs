namespace Mirror
{
	public static class ThreadLog
	{
		private struct LogEntry
		{
			public int threadId;

			public global::UnityEngine.LogType type;

			public string message;

			public string stackTrace;

			public LogEntry(int threadId, global::UnityEngine.LogType type, string message, string stackTrace)
			{
				this.threadId = threadId;
				this.type = type;
				this.message = message;
				this.stackTrace = stackTrace;
			}
		}

		private static readonly global::System.Collections.Concurrent.ConcurrentQueue<global::Mirror.ThreadLog.LogEntry> logs = new global::System.Collections.Concurrent.ConcurrentQueue<global::Mirror.ThreadLog.LogEntry>();

		private static int mainThreadId;

		// The editor console already shows logs from other threads, so re-logging them there only duplicates every line.
		private static bool isEditor;

		[global::UnityEngine.RuntimeInitializeOnLoadMethod(global::UnityEngine.RuntimeInitializeLoadType.BeforeSceneLoad)]
		private static void Initialize()
		{
			mainThreadId = global::System.Threading.Thread.CurrentThread.ManagedThreadId;
			isEditor = global::UnityEngine.Application.isEditor;
			global::UnityEngine.Application.logMessageReceivedThreaded -= OnLog;
			global::UnityEngine.Application.logMessageReceivedThreaded += OnLog;
			global::Mirror.NetworkLoop.OnLateUpdate = (global::System.Action)global::System.Delegate.Remove(global::Mirror.NetworkLoop.OnLateUpdate, new global::System.Action(OnLateUpdate));
			global::Mirror.NetworkLoop.OnLateUpdate = (global::System.Action)global::System.Delegate.Combine(global::Mirror.NetworkLoop.OnLateUpdate, new global::System.Action(OnLateUpdate));
			global::UnityEngine.Debug.Log("ThreadLog initialized.");
		}

		private static bool IsMainThread()
		{
			return global::System.Threading.Thread.CurrentThread.ManagedThreadId == mainThreadId;
		}

		private static void OnLog(string message, string stackTrace, global::UnityEngine.LogType type)
		{
			if (!isEditor && !IsMainThread())
			{
				logs.Enqueue(new global::Mirror.ThreadLog.LogEntry(global::System.Threading.Thread.CurrentThread.ManagedThreadId, type, message, stackTrace));
			}
		}

		private static void OnLateUpdate()
		{
			global::Mirror.ThreadLog.LogEntry result;
			while (logs.TryDequeue(out result))
			{
				switch (result.type)
				{
				case global::UnityEngine.LogType.Log:
					global::UnityEngine.Debug.Log($"[T{result.threadId}] {result.message}\n{result.stackTrace}");
					break;
				case global::UnityEngine.LogType.Warning:
					global::UnityEngine.Debug.LogWarning($"[T{result.threadId}] {result.message}\n{result.stackTrace}");
					break;
				case global::UnityEngine.LogType.Error:
					global::UnityEngine.Debug.LogError($"[T{result.threadId}] {result.message}\n{result.stackTrace}");
					break;
				case global::UnityEngine.LogType.Exception:
					global::UnityEngine.Debug.LogError($"[T{result.threadId}] {result.message}\n{result.stackTrace}");
					break;
				}
			}
		}
	}
}

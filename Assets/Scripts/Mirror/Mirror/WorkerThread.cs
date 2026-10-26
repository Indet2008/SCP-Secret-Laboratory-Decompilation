namespace Mirror
{
	public class WorkerThread
	{
		private readonly global::System.Threading.Thread thread;

		protected volatile bool active;

		private readonly global::System.Diagnostics.Stopwatch watch = new global::System.Diagnostics.Stopwatch();

		public global::System.Action Init;

		public global::System.Action Tick;

		public global::System.Action Cleanup;

		public bool IsAlive => thread.IsAlive;

		public WorkerThread(string identifier)
		{
			global::Mirror.WorkerThread workerThread = this;
			thread = new global::System.Threading.Thread(() =>
			{
				workerThread.Guard(identifier);
			});
			thread.IsBackground = true;
		}

		public void Start()
		{
			if (thread.IsAlive)
			{
				global::UnityEngine.Debug.LogWarning("WorkerThread is still active, can't start it again.");
				return;
			}
			active = true;
			thread.Start();
		}

		public virtual void SignalStop()
		{
			active = false;
		}

		public bool StopBlocking(float timeout)
		{
			if (!thread.IsAlive)
			{
				return true;
			}
			watch.Restart();
			SignalStop();
			while (IsAlive)
			{
				global::System.Threading.Thread.Sleep(0);
				if (watch.Elapsed.TotalSeconds >= (double)timeout)
				{
					Interrupt();
					return false;
				}
			}
			return true;
		}

		public void Interrupt()
		{
			thread.Interrupt();
		}

		private void OnInit()
		{
			Init?.Invoke();
		}

		private void OnTick()
		{
			Tick?.Invoke();
		}

		private void OnCleanup()
		{
			Cleanup?.Invoke();
		}

		public void Guard(string identifier)
		{
			try
			{
				global::UnityEngine.Debug.Log(identifier + ": started.");
				OnInit();
				while (active)
				{
					OnTick();
				}
			}
			catch (global::System.Threading.ThreadInterruptedException)
			{
				global::UnityEngine.Debug.Log(identifier + ": interrupted. That's okay.");
			}
			catch (global::System.Threading.ThreadAbortException)
			{
				global::UnityEngine.Debug.LogWarning(identifier + ": aborted. This may happen after domain reload. That's okay.");
			}
			catch (global::System.Exception exception)
			{
				global::UnityEngine.Debug.LogException(exception);
			}
			finally
			{
				active = false;
				OnCleanup();
				global::UnityEngine.Profiling.Profiler.EndThreadProfiling();
				global::UnityEngine.Debug.Log(identifier + ": ended.");
			}
		}
	}
}

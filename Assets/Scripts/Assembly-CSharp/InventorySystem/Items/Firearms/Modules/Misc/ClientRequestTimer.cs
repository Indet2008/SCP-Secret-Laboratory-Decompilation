using System.Diagnostics;
using Mirror;

namespace InventorySystem.Items.Firearms.Modules.Misc
{
	public class ClientRequestTimer
	{
		private const float AdditionalTimeout = 0.25f;

		private Stopwatch _stopwatch;

		private double _timeoutDuration;

		public bool Sent { get; private set; }

		public bool Busy
		{
			get
			{
				if (Sent)
				{
					return !TimedOut;
				}
				return false;
			}
		}

		public bool TimedOut
		{
			get
			{
				if (!Sent)
				{
					return false;
				}
				return _stopwatch.Elapsed.TotalSeconds > _timeoutDuration;
			}
		}

		public void Trigger()
		{
			Sent = true;
			if (_stopwatch == null)
			{
				_stopwatch = Stopwatch.StartNew();
			}
			else
			{
				_stopwatch.Restart();
			}
			_timeoutDuration = NetworkTime.rtt + 0.25;
		}

		public void Reset()
		{
			Sent = false;
		}
	}
}

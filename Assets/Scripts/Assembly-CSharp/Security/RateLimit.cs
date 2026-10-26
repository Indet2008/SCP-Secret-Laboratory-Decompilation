using Mirror;
using UnityEngine;

namespace Security
{
	public class RateLimit
	{
		private readonly int _usagesAllowed;

		private uint _usages;

		private readonly float _timeWindow;

		private float _usageTime;

		private readonly NetworkConnection _conn;

		public RateLimit(int usagesAllowed, float timeWindow, NetworkConnection conn = null)
		{
			_usagesAllowed = usagesAllowed;
			_timeWindow = timeWindow;
			_conn = conn;
		}

		public bool CanExecute(bool countUsage = true)
		{
			if (_usagesAllowed < 0)
			{
				return true;
			}
			if (_timeWindow >= 0f && Time.fixedUnscaledTime - _usageTime > _timeWindow)
			{
				_usages = 1u;
				_usageTime = Time.fixedUnscaledTime;
				return true;
			}
			if (_usages >= _usagesAllowed)
			{
				if (ServerConsole.RateLimitKick && _conn != null)
				{
					ServerConsole.Disconnect(_conn, "Reason: Exceeding rate limit.");
				}
				return false;
			}
			if (countUsage)
			{
				_usages++;
			}
			return true;
		}

		public void Reset()
		{
			_usages = 0u;
			_usageTime = Time.fixedUnscaledTime;
		}
	}
}

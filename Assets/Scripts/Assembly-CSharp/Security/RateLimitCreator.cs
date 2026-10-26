using GameCore;
using Mirror;

namespace Security
{
	internal static class RateLimitCreator
	{
		private static readonly string[] ServerRateLimits = new string[2] { "playerInteract", "commands" };

		private static readonly uint[] DefaultThresholds = new uint[2] { 60u, 150u };

		private static readonly uint[] DefaultWindows = new uint[2] { 5u, 3u };

		private static uint[][] _limits;

		private static int _limitsAmount;

		private static bool _init;

		private static RateLimit _dummy;

		private static RateLimit[] _dummyTable;

		internal static void Load()
		{
			_init = true;
			_limitsAmount = ServerRateLimits.Length;
			_limits = new uint[_limitsAmount][];
			for (ushort num = 0; num < _limitsAmount; num++)
			{
				_limits[num] = new uint[2];
				_limits[num][0] = ConfigFile.ServerConfig.GetUInt("ratelimit_" + ServerRateLimits[num] + "_threshold", DefaultThresholds[num]);
				_limits[num][1] = ConfigFile.ServerConfig.GetUInt("ratelimit_" + ServerRateLimits[num] + "_window", DefaultWindows[num]);
			}
			_dummy = new DummyRateLimit();
			_dummyTable = new RateLimit[_limitsAmount];
			for (ushort num2 = 0; num2 < _limitsAmount; num2++)
			{
				_dummyTable[num2] = _dummy;
			}
			ServerConsole.AddLog("Rate limiting loaded");
		}

		internal static RateLimit[] CreateRateLimit(NetworkConnection connection, bool dummy = false)
		{
			if (NetworkServer.active && !dummy)
			{
				RateLimit[] array = new RateLimit[_limitsAmount];
				for (ushort num = 0; num < _limitsAmount; num++)
				{
					array[num] = new RateLimit((int)_limits[num][0], _limits[num][1], connection);
				}
				return array;
			}
			if (!_init)
			{
				Load();
			}
			return _dummyTable;
		}
	}
}

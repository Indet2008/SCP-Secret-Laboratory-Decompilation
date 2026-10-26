using System.Net;
using UnityEngine;

namespace LiteNetLib
{
	public class PausedSocketFix
	{
		private readonly LiteNetManager _netManager;

		private readonly IPAddress _ipv4;

		private readonly IPAddress _ipv6;

		private readonly int _port;

		private readonly bool _manualMode;

		private bool _initialized;

		public PausedSocketFix(LiteNetManager netManager, IPAddress ipv4, IPAddress ipv6, int port, bool manualMode)
		{
			_netManager = netManager;
			_ipv4 = ipv4;
			_ipv6 = ipv6;
			_port = port;
			_manualMode = manualMode;
			Application.focusChanged += Application_focusChanged;
			Application.quitting += Deinitialize;
			_initialized = true;
		}

		public void Deinitialize()
		{
			if (_initialized)
			{
				Application.focusChanged -= Application_focusChanged;
				Application.quitting -= Deinitialize;
			}
			if (_netManager.IsRunning)
			{
				_netManager.Stop();
			}
			_initialized = false;
		}

		private void Application_focusChanged(bool focused)
		{
			if (focused && _initialized && _netManager.IsRunning && _netManager.NotConnected && !_netManager.Start(_ipv4, _ipv6, _port, _manualMode))
			{
				NetDebug.WriteError($"[S] Cannot restore connection. Ipv4 {_ipv4}, Ipv6 {_ipv6}, Port {_port}, ManualMode {_manualMode}");
			}
		}
	}
}

using System;
using System.Threading.Tasks;
using LabApi.Events.Handlers;
using UnityEngine;

public static class Shutdown
{
	private static bool _quitting;

	public static event Action OnQuit;

	public static void Quit(bool quit = true, bool suppressShutdownBroadcast = false)
	{
		if (!_quitting)
		{
			_quitting = true;
			OnQuit?.Invoke();
			ServerEvents.OnShutdown();
			IdleMode.PauseIdleMode = true;
			ServerShutdown.Shutdown(suppressShutdownBroadcast);
			CentralServer.Abort = true;
			InternalShutdown(quit);
		}
	}

	private static async void InternalShutdown(bool quit)
	{
		for (int i = 0; (i < 20 && ServerShutdown.ShutdownState != ServerShutdown.ServerShutdownState.Complete) || i < 6; i++)
		{
			await Task.Delay(100);
		}
		if (quit)
		{
			Application.Quit();
		}
	}
}

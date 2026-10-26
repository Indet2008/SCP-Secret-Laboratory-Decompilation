using System;
using System.Collections.Generic;
using System.Diagnostics;
using Mirror;
using PlayerRoles.Spectating;
using UnityEngine;
using Utils.Networking;

namespace InventorySystem.Items.Usables.Scp1576
{
	public static class Scp1576SpectatorWarningHandler
	{
		public struct SpectatorWarningMessage : NetworkMessage
		{
			public bool IsStop;
		}

		private static readonly Stopwatch CooldownTimer = Stopwatch.StartNew();

		private static readonly HashSet<ushort> CurrentlyUsed = new HashSet<ushort>();

		private static bool _stopSoundScheduled;

		public static event Action OnStart;

		public static event Action OnStop;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				CurrentlyUsed.Clear();
				_stopSoundScheduled = false;
				NetworkClient.ReplaceHandler<SpectatorWarningMessage>(HandleMessage);
			};
			StaticUnityMethods.OnUpdate += () =>
			{
				if (_stopSoundScheduled && NetworkServer.active)
				{
					SendMessage(isStop: true);
					_stopSoundScheduled = false;
				}
			};
		}

		private static void SendMessage(bool isStop)
		{
			new SpectatorWarningMessage
			{
				IsStop = isStop
			}.SendToHubsConditionally((ReferenceHub x) => x.roleManager.CurrentRole is SpectatorRole);
		}

		private static void HandleMessage(SpectatorWarningMessage msg)
		{
			if (msg.IsStop)
			{
				OnStop?.Invoke();
			}
			else
			{
				OnStart?.Invoke();
			}
		}

		public static void TriggerStart(Scp1576Item item)
		{
			_stopSoundScheduled = false;
			if (CurrentlyUsed.Count == 0)
			{
				CooldownTimer.Restart();
				SendMessage(isStop: false);
			}
			CurrentlyUsed.Add(item.ItemSerial);
		}

		public static void TriggerStop(Scp1576Item item)
		{
			if (CurrentlyUsed.Remove(item.ItemSerial))
			{
				_stopSoundScheduled = CurrentlyUsed.Count == 0;
			}
		}
	}
}

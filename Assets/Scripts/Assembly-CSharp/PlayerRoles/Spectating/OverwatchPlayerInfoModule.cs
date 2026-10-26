using System;
using System.Text;
using CustomPlayerEffects;
using GameCore;
using Mirror;
using Mirror.LiteNetLib4Mirror;
using NorthwoodLib.Pools;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Subroutines;
using PlayerStatsSystem;
using UnityEngine;

namespace PlayerRoles.Spectating
{
	public class OverwatchPlayerInfoModule : StandardSubroutine<OverwatchRole>
	{
		private const float TimeBetweenUpdateSeconds = 0.25f;

		[SerializeField]
		private string _noSpectatedPlayerMessage = "No Player Selected";

		private float _pingResendRequestTime;

		private int _lastPingReceived;

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			ReferenceHub hub;
			if (!ServerStatic.IsDedicated)
			{
				writer.WriteInt(0);
			}
			else if (!(base.Role is OverwatchRole overwatchRole) || !ReferenceHub.TryGetHubNetID(overwatchRole.SyncedSpectatedNetId, out hub))
			{
				writer.WriteInt(0);
			}
			else if (hub.IsDummy)
			{
				writer.WriteInt(0);
			}
			else
			{
				writer.WriteInt(LiteNetLib4MirrorServer.Peers[hub.connectionToClient.connectionId].Ping * 2);
			}
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			if (!NetworkServer.active)
			{
				_lastPingReceived = reader.ReadInt();
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			ServerSendRpc(base.Owner);
		}

		private void Update()
		{
			if (base.Role.IsLocalPlayer && !ServerStatic.IsDedicated && OverwatchSettingsController.PlayerInfoEnabled)
			{
				_pingResendRequestTime += Time.deltaTime;
				if (!(_pingResendRequestTime < 0.25f))
				{
					_pingResendRequestTime = 0f;
					ClientSendCmd();
					OverwatchUIController.Instance.SetPlayerInfoText(GetPlayerInfo());
				}
			}
		}

		private string GetPlayerInfo()
		{
			if (base.Owner == null)
			{
				return string.Empty;
			}
			if (!SpectatorTargetTracker.TryGetTrackedPlayer(out var hub))
			{
				return _noSpectatedPlayerMessage;
			}
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			try
			{
				stringBuilder.AppendFormat("PlayerID: {0}\nNickname: {1}\n", hub.PlayerId, hub.nicknameSync.MyNick);
				if (hub.nicknameSync.HasCustomName)
				{
					stringBuilder.AppendFormat("Display name: {0}\n", hub.nicknameSync.DisplayName);
				}
				stringBuilder.AppendFormat("\nSpeed: {0}", FormattableString.Invariant($"{hub.GetVelocity().MagnitudeIgnoreY():F4}\n"));
				AdminFlagsStat module = hub.playerStats.GetModule<AdminFlagsStat>();
				if (module.HasFlag(AdminFlags.Noclip))
				{
					stringBuilder.AppendLine("<size=70%><color=#DC143C>NOCLIP</color></size>");
				}
				if (module.HasFlag(AdminFlags.GodMode))
				{
					stringBuilder.AppendLine("<size=70%><color=#FFFF00>GOD MODE</color></size>");
				}
				if (module.HasFlag(AdminFlags.BypassMode))
				{
					stringBuilder.AppendLine("<size=70%><color=#33CC33>BYPASS MODE</color></size>");
				}
				stringBuilder.AppendFormat("<size=70%><color=#FFFFFF>PING: {0}</color></size>\n", _lastPingReceived);
				stringBuilder.Append("<size=50%>");
				StatusEffectBase[] allEffects = hub.playerEffectsController.AllEffects;
				foreach (StatusEffectBase statusEffectBase in allEffects)
				{
					if (statusEffectBase.IsEnabled)
					{
						stringBuilder.AppendLine(statusEffectBase.GetDisplayNameComplete());
					}
				}
				stringBuilder.Append("</size>");
			}
			catch (Exception ex)
			{
				stringBuilder.Append("\n<color=#DC143C>EXCEPTION OCCURED</color>");
				GameCore.Console.AddLog("Overwatch HUD Update exception: " + ex.Message, Color.red);
				GameCore.Console.AddLog(ex.StackTrace, Color.red);
			}
			return StringBuilderPool.Shared.ToStringReturn(stringBuilder);
		}
	}
}

using System.Runtime.InteropServices;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using PlayerStatsSystem;

namespace PlayerRoles.FirstPersonControl.NetworkMessages
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	public struct FpcNoclipToggleMessage : NetworkMessage
	{
		public void ProcessMessage(NetworkConnection sender)
		{
			if (!ReferenceHub.TryGetHubNetID(sender.identity.netId, out var hub))
			{
				return;
			}
			bool isAllowed = FpcNoclip.IsPermitted(hub);
			AdminFlagsStat module = hub.playerStats.GetModule<AdminFlagsStat>();
			PlayerTogglingNoclipEventArgs obj = new PlayerTogglingNoclipEventArgs(hub, !module.HasFlag(AdminFlags.Noclip))
			{
				IsAllowed = isAllowed
			};
			PlayerEvents.OnTogglingNoclip(obj);
			if (obj.IsAllowed)
			{
				if (hub.roleManager.CurrentRole is IFpcRole)
				{
					module.InvertFlag(AdminFlags.Noclip);
				}
				else
				{
					hub.gameConsoleTransmission.SendToClient("Noclip is not supported for this class.", "yellow");
				}
				PlayerEvents.OnToggledNoclip(new PlayerToggledNoclipEventArgs(hub, module.HasFlag(AdminFlags.Noclip)));
			}
		}
	}
}

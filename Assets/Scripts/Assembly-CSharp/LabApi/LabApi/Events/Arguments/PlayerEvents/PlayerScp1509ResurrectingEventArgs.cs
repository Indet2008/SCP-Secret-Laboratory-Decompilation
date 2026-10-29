namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerScp1509ResurrectingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Scp1509Item Item { get; }

		public global::LabApi.Features.Wrappers.Player KilledPlayer { get; }

		public global::LabApi.Features.Wrappers.Player? RevivedPlayer { get; set; }

		public global::PlayerRoles.RoleTypeId RespawnRole { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerScp1509ResurrectingEventArgs(ReferenceHub owner, global::InventorySystem.Items.Scp1509.Scp1509Item scp1509Item, ReferenceHub killedPlayer, ReferenceHub revivePlayer, global::PlayerRoles.RoleTypeId respawnRole)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(owner);
			Item = global::LabApi.Features.Wrappers.Scp1509Item.Get(scp1509Item);
			KilledPlayer = global::LabApi.Features.Wrappers.Player.Get(killedPlayer);
			RevivedPlayer = global::LabApi.Features.Wrappers.Player.Get(revivePlayer);
			RespawnRole = respawnRole;
			IsAllowed = true;
		}
	}
}

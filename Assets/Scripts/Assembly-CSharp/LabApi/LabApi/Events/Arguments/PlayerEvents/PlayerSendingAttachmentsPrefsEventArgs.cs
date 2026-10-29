namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerSendingAttachmentsPrefsEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public ItemType FirearmType { get; set; }

		public uint OldAttachments { get; }

		public uint NewAttachments { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerSendingAttachmentsPrefsEventArgs(ReferenceHub player, ItemType firearm, uint oldAttachments, uint newAttachments)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(player);
			FirearmType = firearm;
			OldAttachments = oldAttachments;
			NewAttachments = newAttachments;
			IsAllowed = true;
		}
	}
}

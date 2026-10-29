namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerSentAttachmentsPrefsEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public ItemType FirearmType { get; }

		public uint OldAttachments { get; }

		public uint NewAttachments { get; }

		public PlayerSentAttachmentsPrefsEventArgs(ReferenceHub player, ItemType firearm, uint oldAttachments, uint newAttachments)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(player);
			FirearmType = firearm;
			OldAttachments = oldAttachments;
			NewAttachments = newAttachments;
		}
	}
}

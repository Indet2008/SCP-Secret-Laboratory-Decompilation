namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerChangingAttachmentsEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IFirearmItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.FirearmItem FirearmItem { get; }

		public uint OldAttachments { get; }

		public uint NewAttachments { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerChangingAttachmentsEventArgs(ReferenceHub player, global::InventorySystem.Items.Firearms.Firearm firearm, uint oldAttachments, uint newAttachments)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(player);
			FirearmItem = global::LabApi.Features.Wrappers.FirearmItem.Get(firearm);
			OldAttachments = oldAttachments;
			NewAttachments = newAttachments;
			IsAllowed = true;
		}
	}
}

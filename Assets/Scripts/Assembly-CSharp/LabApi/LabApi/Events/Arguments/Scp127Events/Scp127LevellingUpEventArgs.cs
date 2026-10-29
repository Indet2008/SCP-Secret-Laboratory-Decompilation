namespace LabApi.Events.Arguments.Scp127Events
{
	public class Scp127LevellingUpEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IScp127ItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Scp127Firearm Scp127Item { get; }

		public global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127Tier Tier { get; }

		public bool IsAllowed { get; set; }

		public Scp127LevellingUpEventArgs(global::InventorySystem.Items.Firearms.Firearm weapon, global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127Tier tier)
		{
			Scp127Item = (global::LabApi.Features.Wrappers.Scp127Firearm)global::LabApi.Features.Wrappers.FirearmItem.Get(weapon);
			Tier = tier;
			IsAllowed = true;
		}
	}
}

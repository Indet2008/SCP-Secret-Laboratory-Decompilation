namespace LabApi.Events.Arguments.Scp127Events
{
	public class Scp127GainingExperienceEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IScp127ItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Scp127Firearm Scp127Item { get; }

		public float ExperienceGain { get; set; }

		public bool IsAllowed { get; set; }

		public Scp127GainingExperienceEventArgs(global::InventorySystem.Items.Firearms.Firearm weapon, float exp)
		{
			Scp127Item = (global::LabApi.Features.Wrappers.Scp127Firearm)global::LabApi.Features.Wrappers.FirearmItem.Get(weapon);
			ExperienceGain = exp;
			IsAllowed = true;
		}
	}
}

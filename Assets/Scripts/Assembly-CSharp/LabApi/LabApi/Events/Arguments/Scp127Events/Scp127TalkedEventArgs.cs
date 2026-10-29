namespace LabApi.Events.Arguments.Scp127Events
{
	public class Scp127TalkedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IScp127ItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		public global::LabApi.Features.Wrappers.Scp127Firearm Scp127Item { get; }

		public global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127VoiceLinesTranslation VoiceLine { get; }

		public global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127VoiceTriggerBase.VoiceLinePriority Priority { get; }

		public Scp127TalkedEventArgs(global::InventorySystem.Items.Firearms.Firearm weapon, global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127VoiceLinesTranslation voiceLine, global::InventorySystem.Items.Firearms.Modules.Scp127.Scp127VoiceTriggerBase.VoiceLinePriority priority)
		{
			Scp127Item = (global::LabApi.Features.Wrappers.Scp127Firearm)global::LabApi.Features.Wrappers.FirearmItem.Get(weapon);
			VoiceLine = voiceLine;
			Priority = priority;
		}
	}
}

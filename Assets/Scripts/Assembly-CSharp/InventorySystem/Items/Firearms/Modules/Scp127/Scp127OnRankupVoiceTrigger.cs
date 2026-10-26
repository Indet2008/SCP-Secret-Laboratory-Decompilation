using AudioPooling;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Scp127
{
	public class Scp127OnRankupVoiceTrigger : Scp127VoiceTriggerBase
	{
		[SerializeField]
		private Scp127VoiceLineCollection _rankupLines;

		protected override MixerChannel DefaultAudioMixerChannel => MixerChannel.NoDucking;

		public override bool ContainsAudioClip(AudioClip clip)
		{
			return _rankupLines.Contains(clip);
		}

		protected override void RegisterEvents()
		{
			base.RegisterEvents();
			Scp127TierManagerModule.ServerOnLevelledUp += OnLevelledUp;
		}

		protected override void UnregisterEvents()
		{
			base.UnregisterEvents();
			Scp127TierManagerModule.ServerOnLevelledUp -= OnLevelledUp;
		}

		private void OnLevelledUp(Firearm fa)
		{
			if (!(fa != base.Firearm))
			{
				ServerPlayVoiceLineFromCollection(_rankupLines, null, VoiceLinePriority.High);
			}
		}
	}
}

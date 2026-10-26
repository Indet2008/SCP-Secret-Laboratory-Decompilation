using AudioPooling;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Scp127
{
	public class Scp127OnDieVoiceTrigger : Scp127VoiceTriggerBase
	{
		[SerializeField]
		private Scp127VoiceLineCollection _ownerDiedLines;

		protected override MixerChannel DefaultAudioMixerChannel => MixerChannel.NoDucking;

		public override bool ContainsAudioClip(AudioClip clip)
		{
			return _ownerDiedLines.Contains(clip);
		}

		protected override void RegisterEvents()
		{
			base.RegisterEvents();
			Scp127VoiceLineManagerModule.OnBeforeFriendshipReset += OnAnyPlayerDied;
		}

		protected override void UnregisterEvents()
		{
			base.UnregisterEvents();
			Scp127VoiceLineManagerModule.OnBeforeFriendshipReset -= OnAnyPlayerDied;
		}

		private void OnAnyPlayerDied(ReferenceHub deadHub)
		{
			if (base.IsServer && !(deadHub != base.Item.Owner))
			{
				ServerPlayVoiceLineFromCollection(_ownerDiedLines, null, VoiceLinePriority.VeryHigh);
			}
		}
	}
}

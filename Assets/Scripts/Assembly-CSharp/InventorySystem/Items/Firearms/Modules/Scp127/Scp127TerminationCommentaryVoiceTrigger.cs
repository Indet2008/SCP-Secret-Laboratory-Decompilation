using System;
using Cassie;
using PlayerRoles;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Scp127
{
	public class Scp127TerminationCommentaryVoiceTrigger : Scp127VoiceTriggerBase
	{
		[Serializable]
		private struct TerminationCommentary
		{
			public RoleTypeId Role;

			public AudioClip[] Lines;
		}

		[SerializeField]
		private TerminationCommentary[] _commentary;

		[SerializeField]
		private AudioClip[] _genericLines;

		protected override float DefaultAudioVolume => 1f;

		public override bool ContainsAudioClip(AudioClip clip)
		{
			TerminationCommentary[] commentary = _commentary;
			for (int i = 0; i < commentary.Length; i++)
			{
				if (commentary[i].Lines.Contains(clip))
				{
					return true;
				}
			}
			return _genericLines.Contains(clip);
		}

		protected override void RegisterEvents()
		{
			base.RegisterEvents();
			CassieScpTerminationAnnouncement.OnAnnouncementFinishedPlaying += OnFinishedPlaying;
		}

		protected override void UnregisterEvents()
		{
			base.UnregisterEvents();
			CassieScpTerminationAnnouncement.OnAnnouncementFinishedPlaying -= OnFinishedPlaying;
		}

		private void OnFinishedPlaying(CassieScpTerminationAnnouncement annc)
		{
			if (annc.Victims.Count == 0)
			{
				return;
			}
			RoleTypeId role = annc.Victims[0].Role;
			TerminationCommentary[] commentary = _commentary;
			for (int i = 0; i < commentary.Length; i++)
			{
				TerminationCommentary terminationCommentary = commentary[i];
				if (terminationCommentary.Role == role)
				{
					ServerPlayVoiceLine(terminationCommentary.Lines.RandomItem());
					break;
				}
			}
		}
	}
}

using System;
using Cassie;
using PlayerRoles;
using Respawning.Waves;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Scp127
{
	public class Scp127SpawnWaveVoiceTrigger : Scp127VoiceTriggerBase
	{
		[Serializable]
		private struct WaveLinePair
		{
			public Faction WaveFaction;

			public Scp127VoiceLineCollection Collection;
		}

		[SerializeField]
		private WaveLinePair[] _voiceLines;

		public override bool ContainsAudioClip(AudioClip clip)
		{
			WaveLinePair[] voiceLines = _voiceLines;
			for (int i = 0; i < voiceLines.Length; i++)
			{
				if (voiceLines[i].Collection.Contains(clip))
				{
					return true;
				}
			}
			return false;
		}

		protected override void RegisterEvents()
		{
			base.RegisterEvents();
			CassieWaveAnnouncement.OnAnnouncementFinishedPlaying += OnFinishedPlaying;
		}

		protected override void UnregisterEvents()
		{
			base.UnregisterEvents();
			CassieWaveAnnouncement.OnAnnouncementFinishedPlaying -= OnFinishedPlaying;
		}

		private void OnFinishedPlaying(CassieWaveAnnouncement annc)
		{
			IAnnouncedWave wave = annc.Wave;
			Faction faction;
			if (!(wave is ChaosSpawnWave) && !(wave is ChaosMiniWave))
			{
				if (!(wave is NtfSpawnWave) && !(wave is NtfMiniWave))
				{
					return;
				}
				faction = Faction.FoundationStaff;
			}
			else
			{
				faction = Faction.FoundationEnemy;
			}
			WaveLinePair[] voiceLines = _voiceLines;
			for (int i = 0; i < voiceLines.Length; i++)
			{
				WaveLinePair waveLinePair = voiceLines[i];
				if (waveLinePair.WaveFaction == faction)
				{
					ServerPlayVoiceLineFromCollection(waveLinePair.Collection);
					break;
				}
			}
		}
	}
}

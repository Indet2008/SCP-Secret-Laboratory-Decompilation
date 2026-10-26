using System;
using System.Collections.Generic;
using AudioPooling;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Scp127
{
	[CreateAssetMenu(fileName = "SCP-127 Voice Line Database", menuName = "ScriptableObject/Firearms/SCP-127 Voice Line Database")]
	public class Scp127VoiceLineDatabase : ScriptableObject
	{
		[Serializable]
		public class VoiceEntry
		{
			private const float SilenceThreshold = 0.01f;

			private const int SilenceFrameSize = 4800;

			public Scp127VoiceLinesTranslation Translation;

			public AudioClip Clip;

			public float[] SegmentTimestamps;

			public float LineDuration
			{
				get
				{
					if (!ClipDurationValid)
					{
						return Clip.length;
					}
					return SegmentTimestamps[^1];
				}
				private set
				{
					if (!ClipDurationValid)
					{
						SegmentTimestamps = new float[1];
					}
					SegmentTimestamps[^1] = value;
				}
			}

			private bool ClipDurationValid
			{
				get
				{
					if (SegmentTimestamps != null)
					{
						return SegmentTimestamps.Length != 0;
					}
					return false;
				}
			}

			public void RecalculateClipDuration()
			{
				float[] array = new float[Clip.samples * Clip.channels];
				Clip.GetData(array, 0);
				for (int num = array.Length - 1; num >= 0; num -= 4800)
				{
					float num2 = 0f;
					for (int i = 0; i <= 4800; i++)
					{
						int num3 = num - i;
						if (num3 < 0)
						{
							break;
						}
						num2 += Mathf.Abs(array[num3]);
					}
					if (num2 > 48f)
					{
						LineDuration = Clip.length * ((float)num / (float)array.Length);
						return;
					}
				}
				LineDuration = Clip.length;
			}
		}

		private readonly Dictionary<AudioClip, VoiceEntry> _entriesByClip = new Dictionary<AudioClip, VoiceEntry>();

		private readonly Dictionary<Scp127VoiceLinesTranslation, AudioClip> _clipsByTranslation = new Dictionary<Scp127VoiceLinesTranslation, AudioClip>();

		private bool _indexingSet;

		public VoiceEntry[] Entries;

		public bool TryGetClip(Scp127VoiceLinesTranslation translation, out AudioClip clip)
		{
			SetIndexing(force: false);
			return _clipsByTranslation.TryGetValue(translation, out clip);
		}

		public bool TryGetEntry(AudioClip voiceLine, out VoiceEntry entry)
		{
			SetIndexing(force: false);
			return _entriesByClip.TryGetValue(voiceLine, out entry);
		}

		public bool IsStillPlaying(AudioPoolSession session)
		{
			if (!session.SameSession)
			{
				return false;
			}
			AudioSource source = session.Source;
			if (!_entriesByClip.TryGetValue(source.clip, out var value))
			{
				return true;
			}
			float time = source.time;
			float lineDuration = value.LineDuration;
			return time < lineDuration;
		}

		public void SetIndexing(bool force)
		{
			if (!_indexingSet || force)
			{
				VoiceEntry[] entries = Entries;
				foreach (VoiceEntry voiceEntry in entries)
				{
					_entriesByClip[voiceEntry.Clip] = voiceEntry;
					_clipsByTranslation[voiceEntry.Translation] = voiceEntry.Clip;
				}
				_indexingSet = true;
			}
		}
	}
}

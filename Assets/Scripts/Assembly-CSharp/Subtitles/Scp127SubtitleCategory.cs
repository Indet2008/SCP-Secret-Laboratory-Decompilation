using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using InventorySystem.Items.Firearms.Modules.Scp127;
using UserSettings;
using UserSettings.UserInterfaceSettings;

namespace Subtitles
{
	public class Scp127SubtitleCategory : SubtitleCategory
	{
		private static int _maxChars;

		private static Scp127SubtitleCategory _singleton;

		private static float[] _segmentTimes;

		private const float SustainDuration = 5f;

		private static readonly string[] PauseSeperator = new string[1] { "<pause>" };

		private static readonly StringBuilder MessageReconstructor = new StringBuilder();

		private static readonly List<int> SegmentLengths = new List<int>();

		private static readonly Stopwatch ElapsedSw = new Stopwatch();

		protected override int MaxVisibleCharacters => _maxChars;

		private static int CurrentSegmentIndex
		{
			get
			{
				float num = (float)ElapsedSw.Elapsed.TotalSeconds;
				int result = 0;
				for (int i = 0; i < _segmentTimes.Length && !(_segmentTimes[i] > num); i++)
				{
					result = i + 1;
				}
				return result;
			}
		}

		private int CharacterIncreaseCutoff
		{
			get
			{
				int currentSegmentIndex = CurrentSegmentIndex;
				int num = 0;
				for (int i = 0; i < SegmentLengths.Count && i <= currentSegmentIndex; i++)
				{
					num += SegmentLengths[i];
				}
				return num;
			}
		}

		protected override void Awake()
		{
			_speakerStartStringSize = _speakerName.Length;
			_singleton = this;
		}

		protected override void FixedUpdate()
		{
			if (base.IsPlayingMessage)
			{
				_timer -= UnityEngine.Time.deltaTime;
				if (!(_timer > 0f))
				{
					base.IsPlayingMessage = false;
					CategoryText.text = string.Empty;
					CheckForMessageStart();
				}
				if (CategoryText.maxVisibleCharacters < _currentMessageSize)
				{
					_maxCharacters++;
					CategoryText.maxVisibleCharacters = MaxVisibleCharacters + _speakerStartStringSize;
				}
			}
			else
			{
				CheckForMessageStart();
			}
			if (base.IsPlayingMessage && _maxChars < CharacterIncreaseCutoff)
			{
				_maxChars++;
			}
		}

		public static void PlayLine(Scp127VoiceLineDatabase.VoiceEntry entry)
		{
			if (!UserSetting<bool>.Get(UISetting.EnableSubtitles) || _singleton == null)
			{
				return;
			}
			_singleton.ClearSubtitles();
			_segmentTimes = entry.SegmentTimestamps;
			_maxChars = 0;
			string text = Translations.Get(entry.Translation);
			string[] array = text.Split(PauseSeperator, StringSplitOptions.None);
			MessageReconstructor.Length = 0;
			SegmentLengths.Clear();
			for (int i = 0; i < array.Length; i++)
			{
				string text2 = array[i].Trim(' ').Replace("\n ", "\n");
				MessageReconstructor.Append(text2);
				MessageReconstructor.Append(' ');
				SegmentLengths.Add(text2.Length + 1);
			}
			ElapsedSw.Restart();
			if (SegmentLengths.Count > _segmentTimes.Length)
			{
				UnityEngine.Debug.LogWarning($"Translation error: Line \"{text}\" has {SegmentLengths.Count - 1} pauses, while SCP-127 expected up to {_segmentTimes.Length - 1}.");
			}
			float num = ((_segmentTimes.Length != 0) ? _segmentTimes[_segmentTimes.Length - 1] : entry.Clip.length);
			_singleton.AddSubtitle(MessageReconstructor.ToString(), num + 5f, 0f);
		}
	}
}

using System;
using System.Collections.Generic;
using System.Text;
using Cassie.Interpreters;
using NorthwoodLib.Pools;
using UnityEngine;

namespace Cassie
{
	public class CassieTtsAnnouncer : MonoBehaviour
	{
		private readonly struct ScheduledClip
		{
			public readonly CassieLine Value;

			public readonly double DspTime;

			public readonly CassiePlaybackModifiers Modifiers;

			public ScheduledClip(CassieLine value, double dspTime, CassiePlaybackModifiers modifiers)
			{
				Value = value;
				DspTime = dspTime;
				Modifiers = modifiers;
			}
		}

		public static readonly CassieInterpreter[] Interpreters = new CassieInterpreter[7]
		{
			new LookupWordInterpreter(),
			new ModifierInterpreter(),
			new NumberInterpreter(),
			new PastTenseInterpreter(),
			new ContinuousInterpreter(),
			new PluralInterpreter(),
			new DegreeInterpreter()
		};

		private const int MaxInstantiatedSources = 25;

		private static CassieTtsAnnouncer _singleton;

		private static bool _singletonSet;

		private static double _nextWordDsp;

		private double _unloadingDspTime;

		private readonly Queue<ScheduledClip> _scheduledClips = new Queue<ScheduledClip>();

		private readonly Queue<CassieLineSource> _sourcePool = new Queue<CassieLineSource>();

		[SerializeField]
		private CassieLineDatabase _clipDatabase;

		[SerializeField]
		private CassieLineSource _clipSourceTemplate;

		[SerializeField]
		private CassieBackgroundPlayer _background;

		[SerializeField]
		private float _preloadTime;

		[SerializeField]
		private float _schedulerOffset;

		public static CassieTtsPayload LastAnnouncement { get; private set; }

		public static event Action OnSingletonSet;

		public static bool TryPlay(CassieTtsPayload tts, out float totalDuration)
		{
			Clear();
			if (!_singletonSet)
			{
				totalDuration = 0f;
				return false;
			}
			double num = (_nextWordDsp = AudioSettings.dspTime);
			if (tts.PlayBackground)
			{
				_nextWordDsp += 2.5;
			}
			StringBuilder stringBuilder = ((tts.SubtitleSource == CassieTtsPayload.SubtitleMode.Automatic) ? StringBuilderPool.Shared.Rent() : null);
			_singleton.ScheduleClips(tts.Content.AsSpan(), default, stringBuilder);
			totalDuration = (float)(_nextWordDsp - num);
			if (tts.PlayBackground)
			{
				double num2 = num + (double)_singleton._schedulerOffset;
				double endingTime = num2 + (double)totalDuration;
				_singleton._background.Play(num2, endingTime);
			}
			switch (tts.SubtitleSource)
			{
			case CassieTtsPayload.SubtitleMode.Automatic:
				tts.PlayOtherSubtitle(totalDuration, stringBuilder.ToString());
				StringBuilderPool.Shared.Return(stringBuilder);
				break;
			case CassieTtsPayload.SubtitleMode.Custom:
				tts.PlayOtherSubtitle(totalDuration);
				break;
			case CassieTtsPayload.SubtitleMode.FromTranslation:
				tts.PlaySubtitleMessage();
				break;
			}
			LastAnnouncement = tts;
			return true;
		}

		public static void Clear()
		{
			if (!_singletonSet)
			{
				return;
			}
			_singleton._background.Clear();
			_singleton._scheduledClips.Clear();
			foreach (CassieLineSource item in _singleton._sourcePool)
			{
				if (item.IsBusy)
				{
					item.Clear();
				}
			}
		}

		public static bool TryGetDatabase(out CassieLineDatabase db)
		{
			if (_singletonSet)
			{
				db = _singleton._clipDatabase;
				return true;
			}
			db = null;
			return false;
		}

		private void ScheduleClips(ReadOnlySpan<char> remaining, CassiePlaybackModifiers modifiers, StringBuilder autoSubtitleBuilder)
		{
			int num = remaining.IndexOf(' ');
			ReadOnlySpan<char> readOnlySpan;
			ReadOnlySpan<char> readOnlySpan2;
			if (num >= 0)
			{
				readOnlySpan = remaining;
				readOnlySpan2 = readOnlySpan.Slice(0, num);
			}
			else
			{
				readOnlySpan2 = remaining;
			}
			ReadOnlySpan<char> word = readOnlySpan2;
			CassieInterpreter[] interpreters = Interpreters;
			for (int i = 0; i < interpreters.Length; i++)
			{
				bool halt;
				foreach (CassieInterpreter.Result result in interpreters[i].GetResults(_clipDatabase, ref modifiers, word, autoSubtitleBuilder, out halt))
				{
					_scheduledClips.Enqueue(new ScheduledClip(result.Line, _nextWordDsp, result.Modifiers));
					_nextWordDsp += result.Modifiers.GetTimeUntilNextWord(result.Line);
				}
				if (halt)
				{
					break;
				}
			}
			if (num >= 0)
			{
				readOnlySpan = remaining;
				int i = num + 1;
				remaining = readOnlySpan.Slice(i, readOnlySpan.Length - i);
				ScheduleClips(remaining, modifiers, autoSubtitleBuilder);
			}
		}

		private void Awake()
		{
			_singleton = this;
			_singletonSet = true;
			_clipDatabase.ValidateCache();
		}

		private void OnDestroy()
		{
			_singletonSet = false;
		}

		private void Update()
		{
			double dspTime = AudioSettings.dspTime;
			foreach (CassieLineSource item in _singleton._sourcePool)
			{
				item.UpdateSpatialization(_clipSourceTemplate);
			}
			if (!_scheduledClips.TryPeek(out var result))
			{
				if (dspTime > _unloadingDspTime)
				{
					CassieLineSource.UpdateUnusedClips();
				}
			}
			else
			{
				if (result.DspTime - dspTime > (double)_preloadTime)
				{
					return;
				}
				CassieLineSource cassieLineSource;
				if (!_sourcePool.TryPeek(out var result2) || result2.IsBusy)
				{
					if (_sourcePool.Count > 25)
					{
						return;
					}
					cassieLineSource = UnityEngine.Object.Instantiate(_clipSourceTemplate, base.transform);
				}
				else
				{
					cassieLineSource = _sourcePool.Dequeue();
				}
				cassieLineSource.Schedule(result.Value, result.DspTime + (double)_schedulerOffset, result.Modifiers);
				cassieLineSource.UpdateSpatialization(_clipSourceTemplate);
				_unloadingDspTime = Math.Max(_unloadingDspTime, cassieLineSource.ScheduledEndTime);
				_scheduledClips.Dequeue();
				_sourcePool.Enqueue(cassieLineSource);
			}
		}
	}
}

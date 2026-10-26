using System.Collections.Generic;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Text;
using UnityEngine;
using UserSettings;
using UserSettings.UserInterfaceSettings;

namespace Subtitles
{
	public class SubtitleController : MonoBehaviour
	{
		public static SubtitleController Singleton;

		[SerializeField]
		private Subtitle[] subtitles;

		[SerializeField]
		private SubtitleCategory[] subtitleCategories;

		private Dictionary<SubtitleType, Subtitle> Subtitles = new Dictionary<SubtitleType, Subtitle>();

		public void SetupSubtitle(SubtitlePart[] subtitles)
		{
			if (!base.enabled || subtitles.Length == 0 || subtitles == null)
			{
				return;
			}
			float num = 0f;
			Subtitle subtitle = null;
			StringBuilder stringBuilder = new StringBuilder();
			int num2 = subtitles.Length;
			Subtitle subtitle2 = null;
			for (int i = 0; i < num2; i++)
			{
				SubtitlePart subtitlePart = subtitles[i];
				SubtitleType subtitle3 = subtitlePart.Subtitle;
				if (Subtitles.TryGetValue(subtitle3, out var value))
				{
					string[] optionalData = subtitlePart.OptionalData;
					num += value.Duration;
					if (subtitle2 != null && subtitle2.RequestSpace)
					{
						stringBuilder.Append(" ");
					}
					string translation = GetTranslation(value);
					string value2 = ReplaceInfo(translation, optionalData, value.ConvertNumbers);
					stringBuilder.Append(value2);
					if (subtitle == null && value.SubtitleCategory != CassieAnnouncementType.None)
					{
						subtitle = value;
					}
					subtitle2 = value;
					continue;
				}
				Debug.LogError($"Unable to find serialized data for {subtitle3}");
				return;
			}
			AddSubtitle(stringBuilder.ToString(), num, subtitle);
		}

		public void ClearSubtitles(CassieAnnouncementType type)
		{
			subtitleCategories[(uint)((type != CassieAnnouncementType.None) ? (type - 1) : CassieAnnouncementType.None)].ClearSubtitles();
		}

		public void AddSubtitle(string message, float duration, Subtitle masterSubtitle)
		{
			if (base.enabled)
			{
				SubtitleCategory subtitleCategory = subtitleCategories[(uint)(masterSubtitle.SubtitleCategory - 1)];
				if (masterSubtitle.SubtitleCategory != CassieAnnouncementType.Normal)
				{
					subtitleCategory.ClearSubtitles();
				}
				subtitleCategory.AddSubtitle(message, duration, masterSubtitle.Delay);
			}
		}

		private void Awake()
		{
			Singleton = this;
			UpdateEnabled(UserSetting<bool>.Get(UISetting.EnableSubtitles));
			UserSetting<bool>.AddListener(UISetting.EnableSubtitles, UpdateEnabled);
			Subtitle[] array = subtitles;
			foreach (Subtitle subtitle in array)
			{
				Subtitles.Add(subtitle.SubtitleTypeValue, subtitle);
			}
		}

		private void OnDestroy()
		{
			UserSetting<bool>.RemoveListener(UISetting.EnableSubtitles, UpdateEnabled);
		}

		[RuntimeInitializeOnLoadMethod]
		private static void SetDefaultPrefs()
		{
			UserSetting<bool>.SetDefaultValue(UISetting.EnableSubtitles, defaultValue: true);
		}

		private void UpdateEnabled(bool b)
		{
			base.enabled = b;
		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		private string ReplaceInfo(string message, string[] optionalData, bool convertNumbers)
		{
			if (optionalData == null || optionalData.Length == 0)
			{
				return message;
			}
			if (convertNumbers)
			{
				for (int i = 0; i < optionalData.Length; i++)
				{
					if (int.TryParse(optionalData[i], out var result))
					{
						optionalData[i] = result.ToString(CultureInfo.CurrentCulture);
					}
				}
			}
			return string.Format(message, optionalData);
		}

		private string GetTranslation(Subtitle subtitle)
		{
			if (!TranslationReader.TryGet("Subtitles", (int)subtitle.SubtitleTypeValue, out var val))
			{
				return subtitle.DefaultValue;
			}
			return val;
		}
	}
}

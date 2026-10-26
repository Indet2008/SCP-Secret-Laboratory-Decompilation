using System.Collections.Generic;
using TMPro;
using UnityEngine;

namespace VoiceChat
{
	public class VoiceChatMicrophoneSelector : TMP_Dropdown
	{
		private const string PrefsKeyMicName = "VcMicName";

		private static string _defaultOption;

		private static List<OptionData> _noMicError;

		protected override void Awake()
		{
			base.Awake();
			RefreshOptions();
			if (TryGetPreferredMicrophone(out var mic))
			{
				base.value = 0;
				for (int i = 0; i < base.options.Count; i++)
				{
					if (!(base.options[i].text != mic))
					{
						base.value = i;
						break;
					}
				}
			}
			base.onValueChanged.AddListener(OnValueChanged);
		}

		private void RefreshOptions()
		{
			string[] devices = Microphone.devices;
			int num = devices.Length;
			if (num == 0)
			{
				base.options = _noMicError;
				return;
			}
			SetOption(0, _defaultOption);
			for (int i = 0; i < num; i++)
			{
				SetOption(i + 1, devices[i]);
			}
			num++;
			if (num != base.options.Count)
			{
				base.options.RemoveRange(num, base.options.Count - num);
			}
		}

		private void SetOption(int index, string text)
		{
			while (index >= base.options.Count)
			{
				base.options.Add(new OptionData());
			}
			base.options[index].text = text;
		}

		private void Update()
		{
			RefreshOptions();
		}

		private void OnValueChanged(int i)
		{
			string text = ((i == 0) ? string.Empty : base.options[i].text);
			PlayerPrefsSl.Set("VcMicName", text);
			VoiceChatMicCapture.RestartRecording();
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			TranslationReader.OnTranslationsRefreshed += () =>
			{
				_defaultOption = TranslationReader.Get("Facility", 45, "Automatic (System Default)");
				_noMicError = new List<OptionData>
				{
					new OptionData(TranslationReader.Get("Facility", 46, "No Microphone Detected!"))
				};
			};
		}

		public static bool TryGetPreferredMicrophone(out string mic)
		{
			string[] devices = Microphone.devices;
			if (devices.Length == 0)
			{
				mic = null;
				return false;
			}
			mic = PlayerPrefsSl.Get("VcMicName", string.Empty);
			if (!string.IsNullOrEmpty(mic) && !devices.Contains<string>(mic))
			{
				mic = string.Empty;
			}
			return true;
		}
	}
}

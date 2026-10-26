using PlayerRoles;
using PlayerRoles.Spectating;
using UnityEngine;
using UnityEngine.Audio;

namespace UserSettings.AudioSettings
{
	public class MixerAudioSettings : MonoBehaviour
	{
		private class AudioSlider
		{
			private readonly VolumeSliderSetting _setting;

			private readonly string _floatName;

			private AudioMixer _mixer;

			protected bool MixerSet;

			public AudioSlider(VolumeSliderSetting setting, string floatName)
			{
				_setting = setting;
				_floatName = floatName;
				UserSetting<float>.AddListener(_setting, SetFloat);
				UserSetting<float>.SetDefaultValue(_setting, 0.7f);
			}

			public void SetMixer(AudioMixer mixer)
			{
				_mixer = mixer;
				MixerSet = true;
				SetFloat(UserSetting<float>.Get(_setting));
			}

			private void SetFloat(float vol)
			{
				if (MixerSet)
				{
					float effectiveVolume = GetEffectiveVolume(vol);
					ApplyVolumeToMixer(effectiveVolume);
				}
			}

			protected virtual float GetEffectiveVolume(float volume)
			{
				return Mathf.Clamp01(volume);
			}

			protected void ApplyVolumeToMixer(float volume)
			{
				volume = Mathf.Clamp01(volume);
				float value = ((!(volume > 0f)) ? (-144f) : (20f * Mathf.Log10(volume)));
				_mixer.SetFloat(_floatName, value);
			}
		}

		private class SpectatorMuteableAudioSlider : AudioSlider
		{
			private readonly VolumeSliderSetting _volumeSetting;

			private readonly VolumeSliderSetting _muteSetting;

			public SpectatorMuteableAudioSlider(VolumeSliderSetting volumeSetting, VolumeSliderSetting muteSetting, string floatName)
				: base(volumeSetting, floatName)
			{
				_volumeSetting = volumeSetting;
				_muteSetting = muteSetting;
				UserSetting<bool>.AddListener(_muteSetting, OnMuteChanged);
				UserSetting<bool>.SetDefaultValue(_muteSetting, defaultValue: false);
			}

			private void OnMuteChanged(bool muted)
			{
				if (MixerSet)
				{
					float volume = UserSetting<float>.Get(_volumeSetting);
					float effectiveVolume = GetEffectiveVolume(volume);
					ApplyVolumeToMixer(effectiveVolume);
				}
			}

			public void OnRoleChanged()
			{
				if (MixerSet)
				{
					float volume = UserSetting<float>.Get(_volumeSetting);
					float effectiveVolume = GetEffectiveVolume(volume);
					ApplyVolumeToMixer(effectiveVolume);
				}
			}

			protected override float GetEffectiveVolume(float volume)
			{
				if (!UserSetting<bool>.Get(_muteSetting))
				{
					return base.GetEffectiveVolume(volume);
				}
				if (!ReferenceHub.TryGetLocalHub(out var hub) || !(hub.roleManager.CurrentRole is SpectatorRole))
				{
					return base.GetEffectiveVolume(volume);
				}
				return 0f;
			}
		}

		public enum VolumeSliderSetting
		{
			Master = 0,
			VoiceChat = 1,
			SoundEffects = 2,
			MenuMusic = 3,
			MenuUI = 4,
			Scp127Voice = 5,
			Scp3114Voice = 6,
			ChaseThemes = 7,
			SoundEffectsWhileSpectating = 8
		}

		[SerializeField]
		private AudioMixer _mixer;

		private const float DefaultSliderVal = 0.7f;

		private static readonly AudioSlider[] Sliders = new AudioSlider[5]
		{
			new AudioSlider(VolumeSliderSetting.Master, "AudioSettings_Master"),
			new AudioSlider(VolumeSliderSetting.VoiceChat, "AudioSettings_VoiceChat"),
			new SpectatorMuteableAudioSlider(VolumeSliderSetting.SoundEffects, VolumeSliderSetting.SoundEffectsWhileSpectating, "AudioSettings_Effects"),
			new AudioSlider(VolumeSliderSetting.MenuMusic, "AudioSettings_MenuMusic"),
			new AudioSlider(VolumeSliderSetting.MenuUI, "AudioSettings_Interface")
		};

		private void Start()
		{
			Sliders.ForEach((AudioSlider x) =>
			{
				x.SetMixer(_mixer);
			});
			PlayerRoleManager.OnRoleChanged += ManageSpectatorMuteableAudio;
		}

		private void OnDestroy()
		{
			PlayerRoleManager.OnRoleChanged -= ManageSpectatorMuteableAudio;
		}

		private static void ManageSpectatorMuteableAudio(ReferenceHub hub, PlayerRoleBase role, PlayerRoleBase newRole)
		{
			if (!ReferenceHub.TryGetLocalHub(out var hub2) || hub != hub2)
			{
				return;
			}
			bool num = role is SpectatorRole;
			bool flag = newRole is SpectatorRole;
			if (!num && !flag)
			{
				return;
			}
			AudioSlider[] sliders = Sliders;
			for (int i = 0; i < sliders.Length; i++)
			{
				if (sliders[i] is SpectatorMuteableAudioSlider spectatorMuteableAudioSlider)
				{
					spectatorMuteableAudioSlider.OnRoleChanged();
				}
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void ApplyOtherDefaults()
		{
			UserSetting<float>.SetDefaultValue(VolumeSliderSetting.Scp127Voice, 1f);
			UserSetting<float>.SetDefaultValue(VolumeSliderSetting.Scp3114Voice, 1f);
			UserSetting<float>.SetDefaultValue(VolumeSliderSetting.ChaseThemes, 0.5f);
		}
	}
}

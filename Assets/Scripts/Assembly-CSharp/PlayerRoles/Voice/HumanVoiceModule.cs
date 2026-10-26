using AudioPooling;
using CustomPlayerEffects;
using InventorySystem.Items;
using InventorySystem.Items.Usables.Scp1576;
using PlayerRoles.Spectating;
using PlayerRoles.Visibility;
using UnityEngine;
using VoiceChat;
using VoiceChat.Playbacks;

namespace PlayerRoles.Voice
{
	public class HumanVoiceModule : StandardVoiceModule, IRadioVoiceModule
	{
		private const float RadioProximityRatio = 0.35f;

		[SerializeField]
		private AudioClip[] _radioOnSounds;

		[SerializeField]
		private AudioClip[] _radioOffSounds;

		[SerializeField]
		private float _toggleSoundsVolume;

		private VisibilityController _vctrl;

		private bool _wasTransmitting;

		private bool Transmitting
		{
			get
			{
				return _wasTransmitting;
			}
			set
			{
				if (Transmitting != value)
				{
					AudioSourcePoolManager.Play2D((value ? _radioOnSounds : _radioOffSounds).RandomItem(), _toggleSoundsVolume, MixerChannel.VoiceChat);
					_wasTransmitting = value;
				}
			}
		}

		public SingleBufferPlayback FirstProxPlayback => ProximityPlaybacks[0];

		[field: SerializeField]
		public SingleBufferPlayback[] ProximityPlaybacks { get; private set; }

		[field: SerializeField]
		public SingleBufferPlayback Scp1576Playback { get; private set; }

		[field: SerializeField]
		public PersonalRadioPlayback RadioPlayback { get; private set; }

		public override bool IsSpeaking => FirstProxPlayback.MaxSamples > 0;

		private bool CheckProximity(ReferenceHub hub)
		{
			if (hub != base.Owner)
			{
				return _vctrl.ValidateVisibility(hub);
			}
			return false;
		}

		protected override VoiceChatChannel ProcessInputs(bool primary, bool alt)
		{
			if ((primary | alt) && base.Owner.playerEffectsController.GetEffect<Scp1576>().IsEnabled)
			{
				Transmitting = false;
				return VoiceChatChannel.Scp1576;
			}
			if (alt && RadioPlayback.RadioUsable && !base.Owner.HasBlock(BlockedInteraction.ItemPrimaryAction))
			{
				Transmitting = true;
				return VoiceChatChannel.Radio;
			}
			Transmitting = false;
			if (!primary)
			{
				return VoiceChatChannel.None;
			}
			return VoiceChatChannel.Proximity;
		}

		protected override void ProcessSamples(float[] data, int len)
		{
			base.ProcessSamples(data, len);
			switch (base.CurrentChannel)
			{
			case VoiceChatChannel.RoundSummary:
				return;
			case VoiceChatChannel.Scp1576:
				Scp1576Playback.WriteBuffer(data, len);
				return;
			case VoiceChatChannel.Radio:
				RadioPlayback.DistributeSamples(data, len);
				break;
			}
			SingleBufferPlayback[] proximityPlaybacks = ProximityPlaybacks;
			for (int i = 0; i < proximityPlaybacks.Length; i++)
			{
				proximityPlaybacks[i].WriteBuffer(data, len);
			}
		}

		protected override void Update()
		{
			base.Update();
			bool flag = IsSpeaking && base.CurrentChannel == VoiceChatChannel.Radio && ReferenceHub.TryGetLocalHub(out var hub) && hub.roleManager.CurrentRole is IVoiceRole { VoiceModule: IRadioVoiceModule voiceModule } && voiceModule.RadioPlayback.RadioUsable;
			SingleBufferPlayback[] proximityPlaybacks = ProximityPlaybacks;
			for (int i = 0; i < proximityPlaybacks.Length; i++)
			{
				proximityPlaybacks[i].Source.volume = (flag ? 0.35f : 1f);
			}
		}

		protected override void Awake()
		{
			base.Awake();
			_vctrl = (base.Role as ICustomVisibilityRole).VisibilityController;
		}

		public override VoiceChatChannel ValidateSend(VoiceChatChannel channel)
		{
			if (channel != VoiceChatChannel.Proximity)
			{
				if (channel != VoiceChatChannel.Radio)
				{
					if (channel == VoiceChatChannel.Scp1576)
					{
						if (!Scp1576Item.ValidatedReceivers.Contains(base.Owner))
						{
							return VoiceChatChannel.Proximity;
						}
						return VoiceChatChannel.Scp1576;
					}
				}
				else if (RadioPlayback.RadioUsable)
				{
					goto IL_0031;
				}
				return VoiceChatChannel.None;
			}
			goto IL_0031;
			IL_0031:
			return channel;
		}

		public override VoiceChatChannel ValidateReceive(ReferenceHub speaker, VoiceChatChannel channel)
		{
			VoiceChatChannel voiceChatChannel = base.ValidateReceive(speaker, channel);
			if (voiceChatChannel == VoiceChatChannel.Intercom || voiceChatChannel == VoiceChatChannel.RoundSummary)
			{
				return voiceChatChannel;
			}
			switch (channel)
			{
			case VoiceChatChannel.Spectator:
				if (Scp1576Item.ValidatedReceivers.Contains(base.Owner) && CheckProximity(speaker))
				{
					return VoiceChatChannel.Scp1576;
				}
				break;
			case VoiceChatChannel.Proximity:
				if (!CheckProximity(speaker))
				{
					break;
				}
				goto case VoiceChatChannel.Radio;
			case VoiceChatChannel.Radio:
			case VoiceChatChannel.Mimicry:
				if (speaker.roleManager.CurrentRole is SpectatorRole)
				{
					return VoiceChatChannel.None;
				}
				return channel;
			case VoiceChatChannel.Scp1576:
				if (CheckProximity(speaker))
				{
					return VoiceChatChannel.Proximity;
				}
				break;
			}
			return VoiceChatChannel.None;
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			RadioPlayback.Setup(base.Owner, ProximityPlaybacks);
			SingleBufferPlayback[] proximityPlaybacks = ProximityPlaybacks;
			for (int i = 0; i < proximityPlaybacks.Length; i++)
			{
				proximityPlaybacks[i].Source.mute = base.Owner.isLocalPlayer;
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_wasTransmitting = false;
		}
	}
}

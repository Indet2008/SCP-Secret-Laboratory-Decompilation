using Mirror;
using PlayerRoles.PlayableScps.Scp079.Map;
using UnityEngine;
using VoiceChat;

namespace PlayerRoles.PlayableScps.Scp079
{
	public class Scp079SpeakerAbility : Scp079KeyAbilityBase, IScp079AuxRegenModifier
	{
		[SerializeField]
		private float _regenMultiplier;

		private bool _syncUsing;

		private string _abilityName;

		private Scp079VoiceModule _voiceModule;

		public float AuxRegenMultiplier
		{
			get
			{
				if (!IsUsingSpeaker)
				{
					return 1f;
				}
				return _regenMultiplier;
			}
		}

		public string AuxReductionMessage { get; private set; }

		public bool CanTransmit => !base.LostSignalHandler.Lost;

		public override ActionName ActivationKey => ActionName.AltVoiceChat;

		public override bool IsReady => true;

		public override bool IsVisible
		{
			get
			{
				if (!Scp079ToggleMenuAbilityBase<Scp079MapToggler>.Visible)
				{
					return CanTransmit;
				}
				return false;
			}
		}

		public override string AbilityName => _abilityName;

		public override string FailMessage => null;

		private bool IsUsingSpeaker
		{
			get
			{
				if (!NetworkServer.active)
				{
					return _syncUsing;
				}
				bool serverIsSending = _voiceModule.ServerIsSending;
				bool flag = VoiceChatMutes.IsMuted(base.Owner);
				VoiceChatChannel currentChannel = _voiceModule.CurrentChannel;
				if (serverIsSending && !flag)
				{
					return currentChannel == VoiceChatChannel.Proximity;
				}
				return false;
			}
		}

		protected override void Trigger()
		{
		}

		private void RefreshNearestSpeaker()
		{
			if (base.CurrentCamSync.TryGetCurrentCamera(out var cam) && Scp079Speaker.TryGetSpeaker(cam, out var best))
			{
				_voiceModule.ProximityPlayback.transform.position = best.Position;
			}
		}

		protected override void Awake()
		{
			base.Awake();
			_abilityName = Translations.Get(Scp079HudTranslation.UseSpeaker);
			AuxReductionMessage = Translations.Get(Scp079HudTranslation.SpeakerAuxPause);
			base.CurrentCamSync.OnCameraChanged += RefreshNearestSpeaker;
		}

		protected override void Update()
		{
			base.Update();
			if (NetworkServer.active && _syncUsing != IsUsingSpeaker)
			{
				ServerSendRpc(toAll: true);
			}
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			_voiceModule = base.CastRole.VoiceModule as Scp079VoiceModule;
			RefreshNearestSpeaker();
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_syncUsing = false;
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteBool(IsUsingSpeaker);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			_syncUsing = reader.ReadBool();
		}
	}
}

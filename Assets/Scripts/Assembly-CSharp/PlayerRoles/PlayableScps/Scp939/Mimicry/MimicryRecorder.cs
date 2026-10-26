using System;
using System.Collections.Generic;
using Footprinting;
using Mirror;
using PlayerRoles.PlayableScps.Scp079.Rewards;
using PlayerRoles.Subroutines;
using PlayerStatsSystem;
using UnityEngine;
using Utils.Networking;
using VoiceChat;
using VoiceChat.Networking;

namespace PlayerRoles.PlayableScps.Scp939.Mimicry
{
	public class MimicryRecorder : StandardSubroutine<Scp939Role>
	{
		public readonly struct MimicryRecording
		{
			public readonly Footprint Owner;

			public readonly PlaybackBuffer Buffer;

			public MimicryRecording(ReferenceHub owner, PlaybackBuffer buffer)
			{
				Owner = new Footprint(owner);
				Buffer = buffer;
				Buffer.Reorganize();
			}
		}

		private readonly Dictionary<HumanRole, PlaybackBuffer> _received = new Dictionary<HumanRole, PlaybackBuffer>();

		private readonly HashSet<ReferenceHub> _serverSentVoices = new HashSet<ReferenceHub>();

		private readonly HashSet<ReferenceHub> _serverSentConfirmations = new HashSet<ReferenceHub>();

		private bool _wasLocal;

		private bool _syncMute;

		private ReferenceHub _syncPlayer;

		[SerializeField]
		private int _maxDurationSamples;

		[SerializeField]
		private int _minDurationSamples;

		[SerializeField]
		private GameObject _confirmationBox;

		private const double MarkUptime = 5.0;

		private readonly List<Footprint> _lastAttackedPlayers = new List<Footprint>();

		public readonly List<MimicryRecording> SavedVoices = new List<MimicryRecording>();

		[field: SerializeField]
		public int MaxRecordings { get; private set; }

		[field: SerializeField]
		public MimicryPreviewPlayback PreviewPlayback { get; private set; }

		[field: SerializeField]
		public MimicryTransmitter Transmitter { get; private set; }

		public event Action OnSavedVoicesModified;

		public event Action<Scp939HudTranslation> OnSavedVoicesItemAdded;

		private void OnRoleChanged(ReferenceHub ply, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (prevRole is HumanRole role)
			{
				UnregisterRole(role);
			}
			if (newRole is HumanRole role2)
			{
				RegisterRole(role2);
			}
		}

		private void ServerRemoveClient(ReferenceHub ply)
		{
			_syncMute = true;
			_syncPlayer = ply;
			ServerSendRpc(toAll: false);
			RemoveRecordingsOfPlayer(ply);
		}

		private void RemoveRecordingsOfPlayer(ReferenceHub ply)
		{
			_serverSentVoices.Remove(ply);
			for (int i = 0; i < SavedVoices.Count; i++)
			{
				if (!(SavedVoices[i].Owner.Hub != ply))
				{
					RemoveIndex(i--);
				}
			}
		}

		private void OnAnyPlayerWasDamaged(ReferenceHub ply, DamageHandlerBase dh)
		{
			if (!VoiceChatMutes.IsMuted(ply) && IsPrivacyAccepted(ply) && dh is Scp939DamageHandler scp939DamageHandler && !(scp939DamageHandler.Attacker.Hub != base.Owner))
			{
				_lastAttackedPlayers.Add(new Footprint(ply));
			}
		}

		private void ClearExpiredTargets()
		{
			for (int num = _lastAttackedPlayers.Count - 1; num >= 0; num--)
			{
				Footprint footprint = _lastAttackedPlayers[num];
				if (footprint.Hub == null || (double)footprint.Stopwatch.Elapsed.Seconds > 5.0)
				{
					_lastAttackedPlayers.RemoveAt(num);
				}
			}
		}

		private bool WasAttackedRecently(ReferenceHub ply)
		{
			ClearExpiredTargets();
			foreach (Footprint lastAttackedPlayer in _lastAttackedPlayers)
			{
				if (lastAttackedPlayer.Hub == ply)
				{
					return true;
				}
			}
			return false;
		}

		private void OnAnyPlayerKilled(ReferenceHub ply, DamageHandlerBase dh)
		{
			if (!VoiceChatMutes.IsMuted(ply) && IsPrivacyAccepted(ply) && WasAttackedRecently(ply) && ply.roleManager.CurrentRole is HumanRole ply2 && WasKilledByTeammate(ply2, dh))
			{
				_syncPlayer = ply;
				_syncMute = false;
				if (base.Owner.isLocalPlayer)
				{
					SaveRecording(ply);
				}
				else
				{
					ServerSendRpc(toAll: false);
				}
				_serverSentVoices.Add(ply);
				_serverSentConfirmations.Remove(ply);
			}
		}

		private bool WasKilledByTeammate(HumanRole ply, DamageHandlerBase dh)
		{
			if (dh is AttackerDamageHandler attackerDamageHandler)
			{
				return attackerDamageHandler.Attacker.Role.GetTeam() == Team.SCPs;
			}
			if (!(dh is UniversalDamageHandler universalDamageHandler))
			{
				return false;
			}
			bool flag = Scp079RewardManager.CheckForRoomInteractions(ply.FpcModule.Position);
			if ((universalDamageHandler.TranslationId == DeathTranslations.Tesla.Id) & flag)
			{
				return true;
			}
			if (universalDamageHandler.TranslationId == DeathTranslations.PocketDecay.Id)
			{
				return true;
			}
			return false;
		}

		private void OnPlayerMuteChanges(ReferenceHub ply, VcMuteFlags _)
		{
			if (VoiceChatMutes.IsMuted(ply) && _serverSentVoices.Remove(ply))
			{
				ServerRemoveClient(ply);
			}
		}

		private void OnPlayerPrivacyChanges(ReferenceHub ply)
		{
			if (!IsPrivacyAccepted(ply) && _serverSentVoices.Remove(ply))
			{
				ServerRemoveClient(ply);
			}
		}

		private bool IsPrivacyAccepted(ReferenceHub hub)
		{
			return VoiceChatPrivacySettings.CheckUserFlags(hub, VcPrivacyFlags.SettingsSelected | VcPrivacyFlags.AllowMicCapture | VcPrivacyFlags.AllowRecording);
		}

		private void UnregisterRole(HumanRole role)
		{
			if (_received.TryGetValue(role, out var value))
			{
				role.VoiceModule.OnSamplesReceived -= value.Write;
				_received.Remove(role);
			}
		}

		private void RegisterRole(HumanRole role)
		{
			PlaybackBuffer playbackBuffer = new PlaybackBuffer(_maxDurationSamples, endlessTapeMode: true);
			_received[role] = playbackBuffer;
			role.VoiceModule.OnSamplesReceived += playbackBuffer.Write;
		}

		private void SaveRecording(ReferenceHub ply)
		{
			if (ply.roleManager.CurrentRole is HumanRole key && _received.TryGetValue(key, out var value) && value.Length >= _minDurationSamples)
			{
				SavedVoices.Add(new MimicryRecording(ply, value));
				OnSavedVoicesItemAdded?.Invoke(Scp939HudTranslation.YouGotAVoicelinePopup);
				OnSavedVoicesModified?.Invoke();
				ClientSendCmd();
			}
		}

		public void RemoveVoice(PlaybackBuffer voiceRecord)
		{
			for (int i = 0; i < SavedVoices.Count; i++)
			{
				if (SavedVoices[i].Buffer == voiceRecord)
				{
					RemoveIndex(i--);
				}
			}
		}

		public void RemoveIndex(int id)
		{
			SavedVoices.RemoveAt(id);
			OnSavedVoicesModified?.Invoke();
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteBool(_syncMute);
			writer.WriteReferenceHub(_syncPlayer);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			_syncMute = reader.ReadBool();
			_syncPlayer = reader.ReadReferenceHub();
			if (_syncPlayer == null)
			{
				return;
			}
			if (_syncPlayer.isLocalPlayer)
			{
				if (!MimicryConfirmationBox.Remember)
				{
					UnityEngine.Object.Instantiate(_confirmationBox);
				}
			}
			else if (_syncMute)
			{
				RemoveRecordingsOfPlayer(_syncPlayer);
			}
			else
			{
				SaveRecording(_syncPlayer);
			}
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			base.ClientWriteCmd(writer);
			writer.WriteReferenceHub(_syncPlayer);
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			ReferenceHub rh = reader.ReadReferenceHub();
			if (_serverSentVoices.Contains(rh) && _serverSentConfirmations.Add(rh))
			{
				ServerSendRpc((ReferenceHub x) => x == rh);
			}
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			PlayerStats.OnAnyPlayerDamaged += OnAnyPlayerWasDamaged;
			PlayerStats.OnAnyPlayerDied += OnAnyPlayerKilled;
			VoiceChatMutes.OnFlagsSet += OnPlayerMuteChanges;
			VoiceChatPrivacySettings.OnUserFlagsChanged += OnPlayerPrivacyChanges;
			if (!base.Owner.isLocalPlayer)
			{
				return;
			}
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.roleManager.CurrentRole is HumanRole role)
				{
					RegisterRole(role);
				}
			}
			_wasLocal = true;
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
			ReferenceHub.OnPlayerRemoved += RemoveRecordingsOfPlayer;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			PlayerStats.OnAnyPlayerDamaged -= OnAnyPlayerWasDamaged;
			PlayerStats.OnAnyPlayerDied -= OnAnyPlayerKilled;
			VoiceChatMutes.OnFlagsSet -= OnPlayerMuteChanges;
			VoiceChatPrivacySettings.OnUserFlagsChanged -= OnPlayerPrivacyChanges;
			_serverSentVoices.Clear();
			_serverSentConfirmations.Clear();
			if (_wasLocal)
			{
				_wasLocal = false;
				SavedVoices.Clear();
				_received.Clear();
				PreviewPlayback.StopPreview();
				PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
				ReferenceHub.OnPlayerRemoved -= RemoveRecordingsOfPlayer;
			}
		}
	}
}

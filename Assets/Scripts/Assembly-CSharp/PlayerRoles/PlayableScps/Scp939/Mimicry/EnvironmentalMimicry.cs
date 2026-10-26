using System;
using LabApi.Events.Arguments.Scp939Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939.Mimicry
{
	public class EnvironmentalMimicry : StandardSubroutine<Scp939Role>
	{
		private byte _syncOption;

		private bool _hasSound;

		private EnvMimicrySequence _currentlyPlayed;

		private MimicPointController _mimicPoint;

		[SerializeField]
		private float _activationCooldown;

		public readonly AbilityCooldown Cooldown = new AbilityCooldown();

		[field: SerializeField]
		public EnvMimicrySequence[] Sequences { get; private set; }

		public string CooldownText => string.Format(Translations.Get(Scp939HudTranslation.EnvMimicryCooldown), ((float)Mathf.RoundToInt(Cooldown.Remaining * 10f) / 10f).ToString("0.0"));

		public event Action OnSoundPlayed;

		protected override void Awake()
		{
			base.Awake();
			GetSubroutine<MimicPointController>(out _mimicPoint);
		}

		public override void ResetObject()
		{
			base.ResetObject();
			Cooldown.Clear();
			_hasSound = false;
			if (!(_currentlyPlayed == null))
			{
				UnityEngine.Object.Destroy(_currentlyPlayed);
				_currentlyPlayed = null;
			}
		}

		public void ClientSelect(EnvMimicrySequence sequence)
		{
			int num = Sequences.Length;
			for (int i = 0; i < num; i++)
			{
				if (!(Sequences[i] != sequence))
				{
					_syncOption = (byte)i;
					ClientSendCmd();
					return;
				}
			}
			Debug.LogError("Sequence " + ((sequence == null) ? "null" : sequence.name) + " is not whitelisted!");
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			base.ClientWriteCmd(writer);
			writer.WriteByte(_syncOption);
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (Cooldown.IsReady)
			{
				_syncOption = reader.ReadByte();
				float activationCooldown = _activationCooldown;
				Scp939MimickingEnvironmentEventArgs e = new Scp939MimickingEnvironmentEventArgs(base.Owner, _syncOption, _activationCooldown);
				Scp939Events.OnMimickingEnvironment(e);
				if (e.IsAllowed)
				{
					_syncOption = e.SelectedSequence;
					activationCooldown = e.CooldownTime;
					Cooldown.Trigger(activationCooldown);
					ServerSendRpc(toAll: true);
					Scp939Events.OnMimickedEnvironment(new Scp939MimickedEnvironmentEventArgs(base.Owner, _syncOption));
				}
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteByte(_syncOption);
			Cooldown.WriteCooldown(writer);
			writer.WriteInt(UnityEngine.Random.Range(int.MinValue, int.MaxValue));
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			_syncOption = (byte)(reader.ReadByte() % Sequences.Length);
			Cooldown.ReadCooldown(reader);
			_currentlyPlayed = UnityEngine.Object.Instantiate(Sequences[_syncOption]);
			_currentlyPlayed.EnqueueAll(reader.ReadInt());
			_hasSound = true;
			OnSoundPlayed?.Invoke();
		}

		private void Update()
		{
			if (_hasSound && !(_currentlyPlayed == null) && !_currentlyPlayed.UpdateSequence(_mimicPoint.MimicPointTransform))
			{
				_hasSound = false;
				_currentlyPlayed = null;
				UnityEngine.Object.Destroy(_currentlyPlayed);
			}
		}
	}
}

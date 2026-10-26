using LabApi.Events.Arguments.Scp049Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.PlayableScps.HUDs;
using PlayerRoles.Subroutines;

namespace PlayerRoles.PlayableScps.Scp049
{
	public class Scp049CallAbility : KeySubroutine<Scp049Role>
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioClip _startCall;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioClip _endCall;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.CooldownAudio _cooldownAudio;


		private const float BaseCooldown = 45f;

		private const float EffectDuration = 20f;

		public readonly AbilityCooldown Cooldown = new AbilityCooldown();

		public readonly AbilityCooldown Duration = new AbilityCooldown();

		private bool _serverTriggered;

		public AbilityHud CallAbilityHUD;

		public bool IsMarkerShown
		{
			get
			{
				if (!Duration.IsReady)
				{
					if (NetworkServer.active)
					{
						return _serverTriggered;
					}
					return true;
				}
				return false;
			}
		}

		protected override ActionName TargetKey => ActionName.Reload;

		private void ServerRefreshDuration()
		{
			if (_serverTriggered && Duration.IsReady)
			{
				Cooldown.Trigger(45.0);
				_serverTriggered = false;
				ServerSendRpc(toAll: true);
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			if (!_serverTriggered && Cooldown.IsReady)
			{
				Scp049UsingDoctorsCallEventArgs e = new Scp049UsingDoctorsCallEventArgs(base.Owner);
				Scp049Events.OnUsingDoctorsCall(e);
				if (e.IsAllowed)
				{
					Duration.Trigger(20.0);
					_serverTriggered = true;
					ServerSendRpc(toAll: true);
					Scp049Events.OnUsedDoctorsCall(new Scp049UsedDoctorsCallEventArgs(base.Owner));
				}
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			Cooldown.WriteCooldown(writer);
			Duration.WriteCooldown(writer);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			Cooldown.ReadCooldown(reader);
			Duration.ReadCooldown(reader);
			if (Cooldown.Remaining >= 45f)
			{
				AbilityAudio(start: false);
			}
			else if (Duration.Remaining >= 20f)
			{
				AbilityAudio(start: true);
			}
		}

		private void AbilityAudio(bool start)
		{
		}

		protected override void Update()
		{
			base.Update();
			if (NetworkServer.active)
			{
				ServerRefreshDuration();
			}
		}

		protected override void OnKeyDown()
		{
			base.OnKeyDown();
			if (Cooldown.IsReady && Duration.IsReady)
			{
				ClientSendCmd();
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			Cooldown.Clear();
			Duration.Clear();
			_serverTriggered = false;
		}
	}
}

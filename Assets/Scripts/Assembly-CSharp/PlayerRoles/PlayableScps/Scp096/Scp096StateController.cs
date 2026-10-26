using System;
using System.Diagnostics;
using LabApi.Events.Arguments.Scp096Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.Subroutines;

namespace PlayerRoles.PlayableScps.Scp096
{
	public class Scp096StateController : StandardSubroutine<Scp096Role>
	{
		private Scp096RageState _rageState;

		private Scp096AbilityState _abilityState;

		private readonly Stopwatch _rageChangeSw = new Stopwatch();

		private readonly Stopwatch _abilityChangeSw = new Stopwatch();

		public Scp096RageState RageState
		{
			get
			{
				return _rageState;
			}
			set
			{
				if (_rageState != value)
				{
					OnRageUpdate?.Invoke(value);
					_rageState = value;
					_rageChangeSw.Restart();
					if (NetworkServer.active)
					{
						ServerSendRpc(toAll: true);
					}
				}
			}
		}

		public Scp096AbilityState AbilityState
		{
			get
			{
				return _abilityState;
			}
			set
			{
				if (_abilityState != value)
				{
					OnAbilityUpdate?.Invoke(value);
					_abilityState = value;
					_abilityChangeSw.Restart();
					if (NetworkServer.active)
					{
						ServerSendRpc(toAll: true);
					}
				}
			}
		}

		public float LastRageUpdate => (float)_rageChangeSw.Elapsed.TotalSeconds;

		public float LastAbilityUpdate => (float)_abilityChangeSw.Elapsed.TotalSeconds;

		public event Action<Scp096RageState> OnRageUpdate;

		public event Action<Scp096AbilityState> OnAbilityUpdate;

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteByte((byte)RageState);
			writer.WriteByte((byte)AbilityState);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			if (!NetworkServer.active)
			{
				RageState = (Scp096RageState)reader.ReadByte();
				AbilityState = (Scp096AbilityState)reader.ReadByte();
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			RageState = Scp096RageState.Docile;
			AbilityState = Scp096AbilityState.None;
			_rageChangeSw.Stop();
			_abilityChangeSw.Stop();
			ReferenceHub.OnPlayerAdded -= OnPlayerJoin;
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			_rageChangeSw.Start();
			_abilityChangeSw.Start();
			ReferenceHub.OnPlayerAdded += OnPlayerJoin;
		}

		private void OnPlayerJoin(ReferenceHub hub)
		{
			if (NetworkServer.active)
			{
				ServerSendRpc(hub);
			}
		}

		public void SetRageState(Scp096RageState state)
		{
			Scp096ChangingStateEventArgs e = new Scp096ChangingStateEventArgs(base.Owner, state);
			Scp096Events.OnChangingState(e);
			if (e.IsAllowed)
			{
				state = e.State;
				RageState = state;
				Scp096Events.OnChangedState(new Scp096ChangedStateEventArgs(base.Owner, state));
			}
		}

		public void SetAbilityState(Scp096AbilityState state)
		{
			AbilityState = state;
		}
	}
}

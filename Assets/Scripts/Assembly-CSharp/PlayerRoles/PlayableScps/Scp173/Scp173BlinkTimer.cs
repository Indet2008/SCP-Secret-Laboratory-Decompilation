using System;
using GameObjectPools;
using Mirror;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp173
{
	public class Scp173BlinkTimer : SubroutineBase, IPoolResettable
	{
		private const float CooldownBaseline = 3f;

		private const float CooldownPerObserver = 0f;

		private const float BreakneckCooldownMultiplier = 0.5f;

		public const float SustainTime = 2f;

		private Scp173ObserversTracker _observers;

		private Scp173MovementModule _fpcModule;

		private Scp173BreakneckSpeedsAbility _breakneckSpeedsAbility;

		private float _totalCooldown;

		private double _initialStopTime;

		private double _endSustainTime;

		private float TotalCooldown
		{
			get
			{
				if (!NetworkServer.active)
				{
					return _totalCooldown;
				}
				return TotalCooldownServer;
			}
		}

		private float TotalCooldownServer => _totalCooldown * (_breakneckSpeedsAbility.IsActive ? 0.5f : 1f);

		private float RemainingSustain => (float)(_endSustainTime - NetworkTime.time);

		public float RemainingBlinkCooldown => Mathf.Max(0f, (float)(_initialStopTime + (double)TotalCooldown - NetworkTime.time));

		public float RemainingSustainPercent
		{
			get
			{
				if (_endSustainTime != -1.0)
				{
					return Mathf.Clamp(RemainingSustain, 0f, 2f) / 2f;
				}
				return 1f;
			}
		}

		public bool AbilityReady
		{
			get
			{
				if (RemainingSustainPercent > 0f)
				{
					return RemainingBlinkCooldown <= 0f;
				}
				return false;
			}
		}

		protected override void Awake()
		{
			base.Awake();
			if (base.Role is Scp173Role scp173Role)
			{
				_fpcModule = scp173Role.FpcModule as Scp173MovementModule;
				scp173Role.SubroutineModule.TryGetSubroutine<Scp173BreakneckSpeedsAbility>(out _breakneckSpeedsAbility);
				scp173Role.SubroutineModule.TryGetSubroutine<Scp173ObserversTracker>(out _observers);
				_observers.OnObserversChanged += OnObserversChanged;
				Scp173BreakneckSpeedsAbility breakneckSpeedsAbility = _breakneckSpeedsAbility;
				breakneckSpeedsAbility.OnToggled = (Action)Delegate.Combine(breakneckSpeedsAbility.OnToggled, (Action)(() =>
				{
					ServerSendRpc(toAll: true);
				}));
			}
		}

		private void OnObserversChanged(int prev, int current)
		{
			if (NetworkServer.active)
			{
				if (prev == 0 && RemainingSustainPercent == 0f)
				{
					_initialStopTime = NetworkTime.time;
					_totalCooldown = 3f;
				}
				_totalCooldown += 0f * (float)(current - prev);
				_endSustainTime = ((current > 0) ? (-1.0) : (NetworkTime.time + 2.0));
				ServerSendRpc(toAll: true);
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteDouble(_initialStopTime);
			writer.WriteDouble(_endSustainTime);
			writer.WriteFloat(TotalCooldownServer);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			if (!NetworkServer.active)
			{
				_initialStopTime = reader.ReadDouble();
				_endSustainTime = reader.ReadDouble();
				_totalCooldown = reader.ReadFloat();
			}
		}

		public void ResetObject()
		{
			_totalCooldown = 0f;
			_initialStopTime = 0.0;
			_endSustainTime = 0.0;
		}

		public void ServerBlink(Vector3 pos)
		{
			int currentObservers = _observers.CurrentObservers;
			_fpcModule.ServerTeleportTo(pos);
			_initialStopTime = NetworkTime.time;
			_observers.UpdateObservers();
			if (currentObservers == _observers.CurrentObservers)
			{
				ServerSendRpc(toAll: true);
			}
		}
	}
}

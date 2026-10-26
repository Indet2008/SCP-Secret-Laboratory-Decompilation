using System;
using System.Diagnostics;
using LabApi.Events.Arguments.Scp173Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.PlayableScps.HUDs;
using PlayerRoles.Spectating;
using PlayerRoles.Subroutines;
using UnityEngine;
using UnityEngine.Rendering;

namespace PlayerRoles.PlayableScps.Scp173
{
	public class Scp173BreakneckSpeedsAbility : KeySubroutine<Scp173Role>
	{
		private const float RechargeTime = 40f;

		private const float StareLimit = 10f;

		private const float MinimalTime = 1f;

		public AbilityHud BreakneckAbilityHUD;

		private readonly Stopwatch _duration = new Stopwatch();

		private float _disableTime;

		private Scp173ObserversTracker _observersTracker;

		[SerializeField]
		private Volume _ppVolume;

		[SerializeField]
		private float _ppLerpSpeed;

		[SerializeField]
		private CooldownAudio _cooldownAudio;

		public readonly AbilityCooldown Cooldown = new AbilityCooldown();

		public Action OnToggled;

		private float Elapsed => (float)_duration.Elapsed.TotalSeconds;

		public bool IsActive
		{
			get
			{
				return _duration.IsRunning;
			}
			private set
			{
				if (value == IsActive)
				{
					return;
				}
				Scp173BreakneckSpeedChangingEventArgs e = new Scp173BreakneckSpeedChangingEventArgs(base.Owner, value);
				Scp173Events.OnBreakneckSpeedChanging(e);
				if (!e.IsAllowed)
				{
					return;
				}
				if (value)
				{
					_duration.Start();
					_disableTime = 0f;
				}
				else
				{
					_duration.Reset();
				}
				if (NetworkServer.active)
				{
					if (!value)
					{
						Cooldown.Trigger(40.0);
					}
					ServerSendRpc(toAll: true);
					OnToggled?.Invoke();
					Scp173Events.OnBreakneckSpeedChanged(new Scp173BreakneckSpeedChangedEventArgs(base.Owner, value));
				}
			}
		}

		protected override ActionName TargetKey => ActionName.Run;

		private void UpdateServerside()
		{
			if (!IsActive)
			{
				return;
			}
			if (_disableTime > 0f)
			{
				if (!(Elapsed < _disableTime))
				{
					IsActive = false;
				}
			}
			else if (_observersTracker.IsObserved)
			{
				_disableTime = Elapsed + 10f;
			}
		}

		protected override void OnKeyDown()
		{
			base.OnKeyDown();
			if (Cooldown.IsReady)
			{
				ClientSendCmd();
			}
		}

		protected override void Update()
		{
			base.Update();
			if (base.Owner.isLocalPlayer || base.Owner.IsLocallySpectated())
			{
				_ppVolume.enabled = true;
				_ppVolume.weight = Mathf.Lerp(_ppVolume.weight, IsActive ? 1 : 0, Time.deltaTime * _ppLerpSpeed);
			}
			else
			{
				_ppVolume.enabled = false;
			}
			if (NetworkServer.active)
			{
				UpdateServerside();
			}
		}

		protected override void Awake()
		{
			base.Awake();
			GetSubroutine<Scp173ObserversTracker>(out _observersTracker);
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			if (IsActive)
			{
				if (!(Elapsed < 1f))
				{
					IsActive = false;
				}
			}
			else if (Cooldown.IsReady)
			{
				IsActive = true;
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			writer.WriteBool(IsActive);
			if (!IsActive)
			{
				Cooldown.WriteCooldown(writer);
			}
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			IsActive = reader.ReadBool();
			if (!IsActive)
			{
				Cooldown.ReadCooldown(reader);
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_ppVolume.weight = 0f;
			IsActive = false;
			Cooldown.Clear();
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			Cooldown.Trigger(40.0);
		}
	}
}

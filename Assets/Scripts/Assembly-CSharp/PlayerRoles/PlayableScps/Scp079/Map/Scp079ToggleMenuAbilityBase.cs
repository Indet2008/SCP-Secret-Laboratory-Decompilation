using System.Diagnostics;
using AudioPooling;
using Mirror;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using PlayerRoles.Spectating;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Map
{
	public abstract class Scp079ToggleMenuAbilityBase<T> : Scp079KeyAbilityBase where T : Scp079ToggleMenuAbilityBase<T>
	{
		[SerializeField]
		private float _cooldown;

		[SerializeField]
		private AudioClip _soundOpen;

		[SerializeField]
		private AudioClip _soundClose;

		private string _openTxt;

		private string _closeTxt;

		private static bool _trackedInstanceSet;

		private static Scp079ToggleMenuAbilityBase<T> _trackedInstance;

		private static readonly Stopwatch CooldownSw = Stopwatch.StartNew();

		public override bool IsReady => CooldownSw.Elapsed.TotalSeconds > (double)_cooldown;

		public override string AbilityName
		{
			get
			{
				if (!SyncState)
				{
					return _openTxt;
				}
				return _closeTxt;
			}
		}

		public override string FailMessage => null;

		protected bool SyncState { get; set; }

		protected abstract Scp079HudTranslation OpenTranslation { get; }

		protected abstract Scp079HudTranslation CloseTranslation { get; }

		public static bool IsOpen
		{
			get
			{
				if (_trackedInstanceSet)
				{
					return _trackedInstance.SyncState;
				}
				return false;
			}
			internal set
			{
				if (_trackedInstanceSet && _trackedInstance.SyncState != value)
				{
					_trackedInstance.SyncState = value;
					CooldownSw.Restart();
					if (_trackedInstance.Role.IsLocalPlayer)
					{
						_trackedInstance.ClientSendCmd();
					}
				}
			}
		}

		public static bool Visible
		{
			get
			{
				if (_trackedInstanceSet)
				{
					if (!_trackedInstance.SyncState)
					{
						return !_trackedInstance.IsReady;
					}
					return true;
				}
				return false;
			}
		}

		private void OnSpectatorTargetChanged()
		{
			if (base.CastRole.IsSpectated || base.CastRole.IsLocalPlayer)
			{
				_trackedInstance = this;
				_trackedInstanceSet = true;
			}
			else
			{
				_trackedInstanceSet = false;
			}
		}

		private void PlaySound()
		{
			AudioSourcePoolManager.Play2D(SyncState ? _soundOpen : _soundClose);
		}

		protected override void Trigger()
		{
			if (base.CurrentCamSync.CurClientSwitchState == Scp079CurrentCameraSync.ClientSwitchState.None)
			{
				IsOpen = !IsOpen;
				PlaySound();
			}
		}

		protected override void Start()
		{
			base.Start();
			_openTxt = Translations.Get(OpenTranslation);
			_closeTxt = Translations.Get(CloseTranslation);
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			base.ClientWriteCmd(writer);
			writer.WriteBool(SyncState);
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			SyncState = reader.ReadBool();
			ServerSendRpc(toAll: true);
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteBool(SyncState);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			bool syncState = SyncState;
			SyncState = reader.ReadBool();
			if (syncState != SyncState && base.Owner.IsLocallySpectated() && base.CastRole.SubroutineModule.TryGetSubroutine<Scp079CurrentCameraSync>(out var subroutine) && subroutine.CurClientSwitchState == Scp079CurrentCameraSync.ClientSwitchState.None)
			{
				PlaySound();
			}
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			ReferenceHub.OnPlayerAdded += base.ServerSendRpc;
			SpectatorTargetTracker.OnTargetChanged += OnSpectatorTargetChanged;
			if (base.Role.IsLocalPlayer)
			{
				_trackedInstance = this;
				_trackedInstanceSet = true;
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			ReferenceHub.OnPlayerAdded -= base.ServerSendRpc;
			SpectatorTargetTracker.OnTargetChanged -= OnSpectatorTargetChanged;
			SyncState = false;
			if (_trackedInstanceSet && !(this != _trackedInstance))
			{
				_trackedInstanceSet = false;
			}
		}
	}
}

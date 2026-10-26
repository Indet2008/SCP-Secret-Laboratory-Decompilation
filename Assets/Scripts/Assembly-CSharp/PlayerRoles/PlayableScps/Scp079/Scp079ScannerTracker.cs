using System;
using AudioPooling;
using Mirror;
using PlayerRoles.PlayableScps.Scp079.GUI;
using RelativePositioning;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079
{
	public class Scp079ScannerTracker : Scp079AbilityBase
	{
		private const int InitialTrackerSize = 32;

		private Scp079ScannerSequence _sequence;

		private int _lastRefreshedIndex;

		private bool _sequenceActive;

		private string _statusScanning;

		private string _statusNextScan;

		private string _statusDisabled;

		[SerializeField]
		private float _sequenceTime;

		[SerializeField]
		private float _warningTime;

		[SerializeField]
		private float _maxCampingTime;

		[SerializeField]
		private float _areaBaselineRadius;

		[SerializeField]
		private float _areaAdditiveRadius;

		[SerializeField]
		private float _addZonesPenalty;

		[SerializeField]
		private float _scannedEffectDuration;

		[SerializeField]
		private AudioClip _alarmSound;

		[SerializeField]
		private float _alarmHeight;

		[SerializeField]
		private float _alarmRange;

		public Scp079ScannerTrackedPlayer[] TrackedPlayers = new Scp079ScannerTrackedPlayer[32];

		public string StatusText
		{
			get
			{
				if (_sequence.SequencePaused)
				{
					return _statusDisabled;
				}
				int num = Mathf.CeilToInt(_sequence.RemainingTime);
				if (num > 0)
				{
					return string.Format(_statusNextScan, num);
				}
				return _statusScanning;
			}
		}

		public event Action<ReferenceHub> OnDetected;

		private void AddTarget(ReferenceHub hub)
		{
			int num = TrackedPlayers.Length;
			for (int i = 0; i < num; i++)
			{
				if (TrackedPlayers[i] == null)
				{
					TrackedPlayers[i] = new Scp079ScannerTrackedPlayer(hub);
					return;
				}
			}
			Array.Resize(ref TrackedPlayers, num + 32);
			TrackedPlayers[num] = new Scp079ScannerTrackedPlayer(hub);
		}

		private void RemoveTarget(ReferenceHub hub)
		{
			int num = TrackedPlayers.Length;
			int hashCode = hub.GetHashCode();
			for (int i = 0; i < num; i++)
			{
				Scp079ScannerTrackedPlayer obj = TrackedPlayers[i];
				if (obj != null && obj.PlayerHash == hashCode)
				{
					TrackedPlayers[i] = null;
					break;
				}
			}
		}

		private void OnRoleChanged(ReferenceHub ply, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (prevRole is HumanRole)
			{
				RemoveTarget(ply);
			}
			if (newRole is HumanRole)
			{
				AddTarget(ply);
			}
		}

		private void Update()
		{
			if (!_sequenceActive || !NetworkServer.active)
			{
				return;
			}
			int num = TrackedPlayers.Length;
			for (int i = 0; i < num; i++)
			{
				int num2 = ++_lastRefreshedIndex % num;
				Scp079ScannerTrackedPlayer scp079ScannerTrackedPlayer = TrackedPlayers[num2];
				if (scp079ScannerTrackedPlayer != null)
				{
					_lastRefreshedIndex = num2;
					scp079ScannerTrackedPlayer.Update(_areaBaselineRadius, _areaAdditiveRadius, _maxCampingTime);
					break;
				}
			}
			_sequence.ServerUpdate(out var rpcRequested);
			if (rpcRequested)
			{
				ServerSendRpc(toAll: true);
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			_sequence.WriteRpc(writer);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			_sequence.ReadRpc(reader);
		}

		protected override void Awake()
		{
			base.Awake();
			_statusScanning = Translations.Get(Scp079HudTranslation.ScanStatusScanning);
			_statusNextScan = Translations.Get(Scp079HudTranslation.ScanStatusWaiting);
			_statusDisabled = Translations.Get(Scp079HudTranslation.ScanStatusDisabled);
		}

		internal void ClientProcessScanResult(ReferenceHub ply, int nextScan, NetworkReader data)
		{
			if (ply != null && ply.roleManager.CurrentRole is HumanRole detectedHuman)
			{
				Scp079NotificationManager.AddNotification(new Scp079ScannerNotification(detectedHuman));
				AudioSourcePoolManager.PlayAtPosition(_alarmSound, data.ReadRelativePosition(), _alarmRange, 1f, FalloffType.Exponential, MixerChannel.NoDucking).Source.transform.position += Vector3.up * _alarmHeight;
				OnDetected?.Invoke(ply);
			}
			else
			{
				Scp079NotificationManager.AddNotification(new Scp079ScannerNotification(nextScan));
			}
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			_sequence = new Scp079ScannerSequence(base.CastRole);
			if (!NetworkServer.active)
			{
				return;
			}
			_sequenceActive = true;
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
			ReferenceHub.OnPlayerRemoved += RemoveTarget;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.roleManager.CurrentRole is HumanRole)
				{
					AddTarget(allHub);
				}
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			if (_sequenceActive)
			{
				_sequenceActive = false;
				PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
				ReferenceHub.OnPlayerRemoved -= RemoveTarget;
				Array.Clear(TrackedPlayers, 0, TrackedPlayers.Length);
			}
		}
	}
}

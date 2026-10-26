using System;
using GameObjectPools;
using InventorySystem.Items.ThrowableProjectiles;
using MapGeneration;
using Mirror;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079
{
	public class Scp079LostSignalHandler : SubroutineBase, IPoolSpawnable
	{
		[SerializeField]
		private float _ghostlightLockoutDuration;

		private Scp079CurrentCameraSync _curCamSync;

		private Scp079AuxManager _auxManager;

		private double _recoveryTime;

		private bool _prevLost;

		public bool Lost => _recoveryTime > NetworkTime.time;

		public float RemainingTime => Mathf.Max(0f, (float)(_recoveryTime - NetworkTime.time));

		public event Action OnStatusChanged;

		private void Update()
		{
			bool lost = Lost;
			if (NetworkServer.active & lost)
			{
				_auxManager.CurrentAux = 0f;
			}
			if (_prevLost != lost)
			{
				_prevLost = lost;
				OnStatusChanged?.Invoke();
				if (_curCamSync.TryGetCurrentCamera(out var cam))
				{
					cam.IsActive = !lost;
				}
			}
		}

		protected override void Awake()
		{
			base.Awake();
			SubroutineManagerModule subroutineModule = (base.Role as ISubroutinedRole).SubroutineModule;
			subroutineModule.TryGetSubroutine<Scp079CurrentCameraSync>(out _curCamSync);
			subroutineModule.TryGetSubroutine<Scp079AuxManager>(out _auxManager);
			Scp2176Projectile.OnServerShattered += (Scp2176Projectile projectile, RoomIdentifier rid) =>
			{
				if (NetworkServer.active && !base.Role.Pooled && !(rid != _curCamSync.CurrentCamera.Room) && base.Role.TryGetOwner(out var hub) && !hub.characterClassManager.GodMode)
				{
					ServerLoseSignal(Lost ? 0f : _ghostlightLockoutDuration);
				}
			};
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteDouble(_recoveryTime);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			_recoveryTime = reader.ReadDouble();
		}

		public void ServerLoseSignal(float duration)
		{
			_recoveryTime = NetworkTime.time + (double)duration;
			ServerSendRpc(toAll: true);
		}

		public void SpawnObject()
		{
			_recoveryTime = 0.0;
			_prevLost = false;
		}
	}
}

using System;
using System.Collections.Generic;
using CustomPlayerEffects;
using GameObjectPools;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using NetworkManagerUtils.Dummies;
using PlayerRoles.FirstPersonControl.NetworkMessages;
using PlayerRoles.FirstPersonControl.Spawnpoints;
using PlayerRoles.SpawnData;
using UnityEngine;

namespace PlayerRoles
{
	public sealed class PlayerRoleManager : NetworkBehaviour, IRootDummyActionProvider
	{
		public delegate void ServerRoleSet(ReferenceHub userHub, RoleTypeId newRole, RoleChangeReason reason);

		public delegate void RoleChanged(ReferenceHub userHub, PlayerRoleBase prevRole, PlayerRoleBase newRole);

		public readonly Dictionary<uint, RoleTypeId> PreviouslySentRole = new Dictionary<uint, RoleTypeId>();

		private ReferenceHub _hub;

		private bool _hubSet;

		private bool _anySet;

		private PlayerRoleBase _curRole;

		private IRootDummyActionProvider[] _dummyProviders;

		private const RoleTypeId DefaultRole = RoleTypeId.None;

		public PlayerRoleBase CurrentRole
		{
			get
			{
				if (!_anySet)
				{
					InitializeNewRole(RoleTypeId.None, RoleChangeReason.None);
				}
				return _curRole;
			}
			set
			{
				_curRole = value;
				_anySet = true;
			}
		}

		public bool DummyActionsDirty { get; set; }

		public ReferenceHub Hub
		{
			get
			{
				if (!_hubSet && ReferenceHub.TryGetHub(base.gameObject, out _hub))
				{
					_hubSet = true;
				}
				return _hub;
			}
		}

		public static event ServerRoleSet OnServerRoleSet;

		public static event RoleChanged OnRoleChanged;

		private void OnDestroy()
		{
			if (CurrentRole is DestroyedRole destroyedRole && destroyedRole != null)
			{
				destroyedRole.DisableRole(RoleTypeId.Destroyed);
			}
		}

		public override void OnStopClient()
		{
			base.OnStopClient();
			InitializeNewRole(RoleTypeId.Destroyed, RoleChangeReason.Destroyed);
		}

		private PlayerRoleBase GetRoleBase(RoleTypeId targetId)
		{
			if (!targetId.TryGetRoleTemplate<PlayerRoleBase>(out var result))
			{
				Debug.LogError($"Role #{targetId} could not be found. Player with ID {Hub.PlayerId} will receive the default role ({RoleTypeId.None}).");
				if (!RoleTypeId.None.TryGetRoleTemplate<PlayerRoleBase>(out result))
				{
					throw new NotImplementedException("Role change failed. Default role is not correctly implemented.");
				}
			}
			if (!PoolManager.Singleton.TryGetPoolObject(result.gameObject, out var poolObject, autoSetup: false) || !(poolObject is PlayerRoleBase result2))
			{
				throw new InvalidOperationException($"Role {targetId} failed to initialize, pool was not found or dequed object was of incorrect type.");
			}
			return result2;
		}

		public void InitializeNewRole(RoleTypeId targetId, RoleChangeReason reason, RoleSpawnFlags spawnFlags = RoleSpawnFlags.All, NetworkReader data = null)
		{
			PlayerRoleBase playerRoleBase;
			bool flag;
			if (_anySet)
			{
				playerRoleBase = CurrentRole;
				playerRoleBase.DisableRole(targetId);
				flag = true;
			}
			else
			{
				playerRoleBase = null;
				flag = false;
			}
			PlayerRoleBase roleBase = GetRoleBase(targetId);
			Transform transform = roleBase.transform;
			if (targetId != RoleTypeId.Destroyed || reason != RoleChangeReason.Destroyed)
			{
				transform.parent = base.transform;
				transform.ResetLocalPose();
			}
			CurrentRole = roleBase;
			roleBase.Init(Hub, reason, spawnFlags);
			RoleSpawnpointManager.SetPosition(Hub, CurrentRole);
			roleBase.SetupPoolObject();
			if (CurrentRole is ISpawnDataReader spawnDataReader && data != null)
			{
				spawnDataReader.ReadSpawnData(data);
			}
			if (flag)
			{
				OnRoleChanged?.Invoke(Hub, playerRoleBase, CurrentRole);
			}
			SpawnProtected.TryGiveProtection(Hub);
			if (Hub.IsDummy)
			{
				_dummyProviders = roleBase.GetComponentsInChildren<IRootDummyActionProvider>();
				DummyActionsDirty = true;
			}
		}

		[Server]
		public void ServerSetRole(RoleTypeId newRole, RoleChangeReason reason, RoleSpawnFlags spawnFlags = RoleSpawnFlags.All, Action<PlayerRoleBase> beforeSendAction = null)
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void PlayerRoles.PlayerRoleManager::ServerSetRole(PlayerRoles.RoleTypeId,PlayerRoles.RoleChangeReason,PlayerRoles.RoleSpawnFlags,System.Action`1<PlayerRoles.PlayerRoleBase>)' called when server was not active");
				return;
			}
			PlayerChangingRoleEventArgs e = new PlayerChangingRoleEventArgs(Hub, CurrentRole, newRole, reason, spawnFlags);
			PlayerEvents.OnChangingRole(e);
			if (e.IsAllowed)
			{
				newRole = e.NewRole;
				reason = e.ChangeReason;
				spawnFlags = e.SpawnFlags;
				RoleTypeId roleTypeId = CurrentRole.RoleTypeId;
				OnServerRoleSet?.Invoke(Hub, newRole, reason);
				InitializeNewRole(newRole, reason, spawnFlags);
				beforeSendAction?.Invoke(CurrentRole);
				SendNewRoleInfo();
				if (Hub.isLocalPlayer && CurrentRole is Spectating.SpectatorRole spectatorRole)
				{
					// The host's own player never receives RoleSyncInfo, so it would never see the
					// spectator start screen or the death screen; replay its private spawn data locally.
					using NetworkWriterPooled networkWriterPooled = NetworkWriterPool.Get();
					spectatorRole.WritePrivateSpawnData(networkWriterPooled);
					using NetworkReaderPooled reader = NetworkReaderPool.Get(networkWriterPooled.ToArraySegment());
					spectatorRole.ReadSpawnData(reader);
				}
				PlayerEvents.OnChangedRole(new PlayerChangedRoleEventArgs(_hub, roleTypeId, CurrentRole, reason, spawnFlags));
			}
		}

		public void PopulateDummyActions(Action<DummyAction> actionAdder, Action<string> categoryAdder)
		{
			if (_dummyProviders != null)
			{
				IRootDummyActionProvider[] dummyProviders = _dummyProviders;
				for (int i = 0; i < dummyProviders.Length; i++)
				{
					dummyProviders[i].PopulateDummyActions(actionAdder, categoryAdder);
				}
				DummyActionsDirty = false;
			}
		}

		private void SendNewRoleInfo()
		{
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (!allHub.isLocalPlayer)
				{
					RoleTypeId roleTypeId = FpcServerPositionDistributor.GetVisibleRole(allHub, Hub);
					NetworkWriterPooled networkWriterPooled = NetworkWriterPool.Get();
					RoleTypeId? roleTypeId2 = FpcServerPositionDistributor.InvokeRoleSyncEvent(Hub, allHub, roleTypeId, networkWriterPooled);
					if (roleTypeId2.HasValue)
					{
						roleTypeId = roleTypeId2.Value;
					}
					allHub.connectionToClient.Send(new RoleSyncInfo(Hub, roleTypeId, allHub, networkWriterPooled));
					PreviouslySentRole[allHub.netId] = roleTypeId;
					NetworkWriterPool.Return(networkWriterPooled);
				}
			}
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}

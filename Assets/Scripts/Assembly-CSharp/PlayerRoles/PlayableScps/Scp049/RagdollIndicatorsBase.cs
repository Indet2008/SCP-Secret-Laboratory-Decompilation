using System.Collections.Generic;
using System.Linq;
using Mirror;
using PlayerRoles.Ragdolls;
using PlayerRoles.Spectating;
using PlayerRoles.Subroutines;
using UnityEngine;
using Utils.Networking;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp049
{
	public abstract class RagdollIndicatorsBase<T> : StandardSubroutine<T> where T : PlayerRoleBase
	{
		private readonly struct Indicator
		{
			public readonly GameObject Instance;

			private readonly CanvasGroup _group;

			public void SetAlpha(float f)
			{
				f = Mathf.Clamp01(f);
				_group.alpha = f;
			}

			public Indicator(GameObject inst)
			{
				Instance = inst;
				_group = inst.GetComponentInChildren<CanvasGroup>();
				SetAlpha(0f);
			}
		}

		private enum ListSyncRpcType
		{
			FullResync = 0,
			Add = 1,
			Remove = 2
		}

		[SerializeField]
		private float _showDelay;

		[SerializeField]
		private float _fullOpacityDistance;

		[SerializeField]
		private float _visibleDistance;

		[SerializeField]
		private GameObject _indicatorTemplate;

		[SerializeField]
		private Vector3 _posOffset;

		private readonly Dictionary<BasicRagdoll, Indicator> _indicatorInstances = new Dictionary<BasicRagdoll, Indicator>();

		private readonly HashSet<BasicRagdoll> _availableRagdolls = new HashSet<BasicRagdoll>();

		private ListSyncRpcType _rpcType;

		private uint _syncRagdoll;

		protected virtual void Update()
		{
			if (NetworkServer.active && !ServerCheckNew())
			{
				ServerRevalidateOld();
			}
		}

		protected virtual GameObject GenerateIndicator(BasicRagdoll ragdoll)
		{
			return Object.Instantiate(_indicatorTemplate);
		}

		protected abstract bool ValidateRagdoll(BasicRagdoll ragdoll);

		private bool ServerCheckNew()
		{
			foreach (BasicRagdoll allRagdoll in RagdollManager.AllRagdolls)
			{
				if (ValidateRagdoll(allRagdoll) && !(allRagdoll.Info.ExistenceTime <= _showDelay) && _availableRagdolls.Add(allRagdoll))
				{
					ServerSendRpc(ListSyncRpcType.Add, allRagdoll);
					return true;
				}
			}
			return false;
		}

		private void ServerRevalidateOld()
		{
			if (_availableRagdolls.TryGetFirst((BasicRagdoll x) => !ValidateRagdoll(x), out var first))
			{
				_availableRagdolls.Remove(first);
				ServerSendRpc(ListSyncRpcType.Remove, first);
			}
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
			RagdollManager.OnRagdollRemoved += ClientRemoveRagdoll;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_availableRagdolls.Clear();
			PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
			RagdollManager.OnRagdollRemoved -= ClientRemoveRagdoll;
			_indicatorInstances.ForEachValue((Indicator x) =>
			{
				Object.Destroy(x.Instance);
			});
			_indicatorInstances.Clear();
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteByte((byte)_rpcType);
			if (_rpcType != ListSyncRpcType.FullResync)
			{
				writer.WriteUInt(_syncRagdoll);
				return;
			}
			_availableRagdolls.ForEach((BasicRagdoll x) =>
			{
				writer.WriteUInt(x.netId);
			});
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			_rpcType = (ListSyncRpcType)reader.ReadByte();
			switch (_rpcType)
			{
			case ListSyncRpcType.Add:
			case ListSyncRpcType.Remove:
				ClientProcessRpcSingularNetId(reader.ReadUInt(), _rpcType);
				return;
			case ListSyncRpcType.FullResync:
				break;
			default:
				return;
			}
			while (_availableRagdolls.Count > 0)
			{
				ClientRemoveRagdoll(_availableRagdolls.First());
			}
			while (reader.Remaining > 0)
			{
				ClientProcessRpcSingularNetId(reader.ReadUInt(), ListSyncRpcType.Add);
			}
		}

		private void ClientProcessRpcSingularNetId(uint netId, ListSyncRpcType rpcType)
		{
			if (NetworkUtils.SpawnedNetIds.TryGetValue(netId, out var value) && value.TryGetComponent<BasicRagdoll>(out var component))
			{
				switch (rpcType)
				{
				case ListSyncRpcType.Add:
					_availableRagdolls.Add(component);
					break;
				case ListSyncRpcType.Remove:
					ClientRemoveRagdoll(component);
					break;
				}
			}
		}

		private void OnRoleChanged(ReferenceHub hub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (NetworkServer.active && newRole is SpectatorRole)
			{
				_rpcType = ListSyncRpcType.FullResync;
				ServerSendRpc(hub);
			}
		}

		private void ServerSendRpc(ListSyncRpcType rpcType, BasicRagdoll ragdoll)
		{
			_rpcType = rpcType;
			_syncRagdoll = ragdoll.netId;
			ServerSendRpc((ReferenceHub x) => x == base.Owner || x.roleManager.CurrentRole is SpectatorRole);
		}

		private void ClientRemoveRagdoll(BasicRagdoll ragdoll)
		{
			_availableRagdolls.Remove(ragdoll);
			if (_indicatorInstances.TryGetValue(ragdoll, out var value))
			{
				Object.Destroy(value.Instance);
				_indicatorInstances.Remove(ragdoll);
			}
		}
	}
}

using System;
using Interactables.Interobjects.DoorUtils;
using Mirror;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079
{
	public class Scp079DoorStateChanger : Scp079DoorAbility
	{
		[Serializable]
		private struct DoorCost
		{
			public DoorPermissionFlags Perm;

			public int Cost;
		}

		[SerializeField]
		private int _defaultCost;

		[SerializeField]
		private DoorCost[] _doorCostsheet;

		[SerializeField]
		private AudioClip _confirmationSound;

		private Scp079DoorLockChanger _lockChanger;

		private static string _openText;

		private static string _closeText;

		public override ActionName ActivationKey => ActionName.Shoot;

		public override string AbilityName => string.Format(LastDoor.TargetState ? _closeText : _openText, GetCostForDoor(TargetAction, LastDoor));

		protected override DoorAction TargetAction
		{
			get
			{
				if (!LastDoor.TargetState)
				{
					return DoorAction.Opened;
				}
				return DoorAction.Closed;
			}
		}

		public static event Action<Scp079Role, DoorVariant> OnServerDoorToggled;

		protected override void Start()
		{
			base.Start();
			_openText = Translations.Get(Scp079HudTranslation.OpenDoor);
			_closeText = Translations.Get(Scp079HudTranslation.CloseDoor);
			GetSubroutine<Scp079DoorLockChanger>(out _lockChanger);
		}

		protected override int GetCostForDoor(DoorAction action, DoorVariant door)
		{
			DoorPermissionFlags requiredPermissions = door.RequiredPermissions.RequiredPermissions;
			int num = _defaultCost;
			DoorCost[] doorCostsheet = _doorCostsheet;
			for (int i = 0; i < doorCostsheet.Length; i++)
			{
				DoorCost doorCost = doorCostsheet[i];
				if (requiredPermissions.HasFlagAll(doorCost.Perm))
				{
					num = Mathf.Max(num, doorCost.Cost);
				}
			}
			if (_lockChanger.LockedDoor == door && action == DoorAction.Closed)
			{
				num += _lockChanger.LockClosedDoorCost - _lockChanger.LockOpenDoorCost;
			}
			return num;
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			base.ClientWriteCmd(writer);
			writer.WriteUInt(LastDoor.netId);
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (NetworkServer.spawned.TryGetValue(reader.ReadUInt(), out var value) && value.TryGetComponent<DoorVariant>(out LastDoor) && IsReady && base.Role.TryGetOwner(out var hub) && !base.LostSignalHandler.Lost)
			{
				bool targetState = LastDoor.TargetState;
				LastDoor.ServerInteract(hub, 0);
				if (targetState != LastDoor.TargetState)
				{
					base.RewardManager.MarkRooms(LastDoor.Rooms);
					OnServerDoorToggled?.Invoke(base.CastRole, LastDoor);
					base.AuxManager.CurrentAux -= GetCostForDoor(TargetAction, LastDoor);
					ServerSendRpc(toAll: true);
				}
			}
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			PlayConfirmationSound(_confirmationSound);
		}
	}
}

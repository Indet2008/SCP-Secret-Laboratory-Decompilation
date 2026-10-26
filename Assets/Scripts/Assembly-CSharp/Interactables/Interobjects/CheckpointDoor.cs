using System;
using System.Runtime.InteropServices;
using Footprinting;
using Interactables.Interobjects.DoorButtons;
using Interactables.Interobjects.DoorUtils;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using Mirror;
using Mirror.RemoteCalls;
using UnityEngine;

namespace Interactables.Interobjects
{
	public class CheckpointDoor : DoorVariant, IDamageableDoor
	{
		public enum SequenceState
		{
			Idle = 0,
			Granted = 1,
			OpenLoop = 2,
			ClosingWarning = 3
		}

		[SerializeField]
		private AudioSource _loudSource;

		[SerializeField]
		private AudioSource _beepSource;

		[SerializeField]
		private AudioClip _deniedClip;

		[SerializeField]
		private AudioClip _warningClip;

		[SyncVar(hook = "SequenceHook")]
		private byte _curSequence;

		private bool _prevDestroyed;

		[field: SerializeField]
		public DoorVariant[] SubDoors { get; private set; }

		[field: SerializeField]
		public CheckpointSequenceController SequenceCtrl { get; private set; }

		public SequenceState CurSequence
		{
			get
			{
				return (SequenceState)_curSequence;
			}
			set
			{
				byte b = (byte)value;
				if (_curSequence == b)
				{
					return;
				}
				CheckpointDoorSequenceChangingEventArgs e = new CheckpointDoorSequenceChangingEventArgs(this, (SequenceState)_curSequence, value);
				ServerEvents.OnCheckpointDoorSequenceChanging(e);
				if (e.IsAllowed)
				{
					b = (byte)e.NewSequence;
					Network_curSequence = b;
					if (NetworkServer.active)
					{
						OnSequenceChanged?.Invoke();
						ServerEvents.OnCheckpointDoorSequenceChanged(new CheckpointDoorSequenceChangedEventArgs(this, value));
					}
				}
			}
		}

		public float MaxHealth
		{
			get
			{
				float num = 0f;
				int num2 = 0;
				DoorVariant[] subDoors = SubDoors;
				for (int i = 0; i < subDoors.Length; i++)
				{
					if (subDoors[i] is IDamageableDoor damageableDoor)
					{
						num += damageableDoor.MaxHealth;
						num2++;
					}
				}
				return num / (float)num2;
			}
			set
			{
				DoorVariant[] subDoors = SubDoors;
				for (int i = 0; i < subDoors.Length; i++)
				{
					if (subDoors[i] is BreakableDoor breakableDoor)
					{
						breakableDoor.MaxHealth = value;
					}
				}
			}
		}

		public float RemainingHealth
		{
			get
			{
				float num = 0f;
				int num2 = 0;
				DoorVariant[] subDoors = SubDoors;
				for (int i = 0; i < subDoors.Length; i++)
				{
					if (subDoors[i] is IDamageableDoor damageableDoor)
					{
						num += damageableDoor.RemainingHealth;
						num2++;
					}
				}
				return num / (float)num2;
			}
			set
			{
				DoorVariant[] subDoors = SubDoors;
				for (int i = 0; i < subDoors.Length; i++)
				{
					if (subDoors[i] is BreakableDoor breakableDoor)
					{
						breakableDoor.RemainingHealth = value;
					}
				}
			}
		}

		public bool IsDestroyed
		{
			get
			{
				DoorVariant[] subDoors = SubDoors;
				for (int i = 0; i < subDoors.Length; i++)
				{
					if (!(subDoors[i] is IDamageableDoor damageableDoor))
					{
						return false;
					}
					if (!damageableDoor.IsDestroyed)
					{
						return false;
					}
				}
				return true;
			}
			set
			{
				DoorVariant[] subDoors = SubDoors;
				for (int i = 0; i < subDoors.Length; i++)
				{
					if (subDoors[i] is IDamageableDoor damageableDoor)
					{
						damageableDoor.IsDestroyed = value;
					}
				}
			}
		}

		public byte Network_curSequence
		{
			get
			{
				return _curSequence;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _curSequence, 8uL, SequenceHook);
			}
		}

		public event Action OnDestroyedChanged;

		public event Action OnSequenceChanged;

		private void SequenceHook(byte prev, byte cur)
		{
			if (prev != cur && !NetworkServer.active)
			{
				OnSequenceChanged?.Invoke();
			}
		}

		protected override void Awake()
		{
			base.Awake();
			SequenceCtrl.Init(this);
			ButtonVariant[] buttons = base.Buttons;
			for (int i = 0; i < buttons.Length; i++)
			{
				if (buttons[i] is CheckpointKeycardButton checkpointKeycardButton)
				{
					checkpointKeycardButton.Init(this);
				}
			}
			OnSequenceChanged += () =>
			{
				if (CurSequence == SequenceState.ClosingWarning)
				{
					PlayWarningSound();
				}
			};
		}

		protected override void Update()
		{
			base.Update();
			if (_prevDestroyed != IsDestroyed)
			{
				OnDestroyedChanged?.Invoke();
				_prevDestroyed = !_prevDestroyed;
			}
			if (NetworkServer.active)
			{
				CurSequence = SequenceCtrl.UpdateSequence();
			}
		}

		public override bool AllowInteracting(ReferenceHub ply, byte colliderId)
		{
			if (IsDestroyed)
			{
				return false;
			}
			if (CurSequence != SequenceState.Idle)
			{
				return false;
			}
			DoorVariant[] subDoors = SubDoors;
			for (int i = 0; i < subDoors.Length; i++)
			{
				if (!subDoors[i].AllowInteracting(null, colliderId))
				{
					return false;
				}
			}
			return true;
		}

		public override float GetExactState()
		{
			if (SubDoors.Length == 0)
			{
				return 0f;
			}
			float num = 0f;
			DoorVariant[] subDoors = SubDoors;
			foreach (DoorVariant doorVariant in subDoors)
			{
				num = Mathf.Max(num, doorVariant.GetExactState());
			}
			return num;
		}

		public override bool IsConsideredOpen()
		{
			DoorVariant[] subDoors = SubDoors;
			for (int i = 0; i < subDoors.Length; i++)
			{
				if (subDoors[i].IsConsideredOpen())
				{
					return true;
				}
			}
			return false;
		}

		public override bool AnticheatPassageApproved()
		{
			DoorVariant[] subDoors = SubDoors;
			for (int i = 0; i < subDoors.Length; i++)
			{
				if (subDoors[i].AnticheatPassageApproved())
				{
					return true;
				}
			}
			return false;
		}

		public void ToggleAllDoors(bool newState)
		{
			DoorVariant[] subDoors = SubDoors;
			foreach (DoorVariant doorVariant in subDoors)
			{
				if (!(doorVariant is IDamageableDoor { IsDestroyed: not false }))
				{
					doorVariant.NetworkTargetState = newState;
				}
			}
		}

		public bool ServerDamage(float hp, DoorDamageType type, Footprint attacker = default(Footprint))
		{
			bool flag = false;
			DoorVariant[] subDoors = SubDoors;
			for (int i = 0; i < subDoors.Length; i++)
			{
				if (subDoors[i] is IDamageableDoor damageableDoor)
				{
					flag |= damageableDoor.ServerDamage(hp, type, attacker);
				}
			}
			return flag;
		}

		public bool ServerRepair()
		{
			bool flag = false;
			DoorVariant[] subDoors = SubDoors;
			for (int i = 0; i < subDoors.Length; i++)
			{
				if (subDoors[i] is IDamageableDoor damageableDoor)
				{
					flag |= damageableDoor.ServerRepair();
				}
			}
			return flag;
		}

		public float GetHealthPercent()
		{
			float num = 1f;
			DoorVariant[] subDoors = SubDoors;
			for (int i = 0; i < subDoors.Length; i++)
			{
				if (subDoors[i] is IDamageableDoor damageableDoor)
				{
					num *= damageableDoor.GetHealthPercent();
				}
			}
			return num;
		}

		public void ClientDestroyEffects()
		{
		}

		public void ClientRepairEffects()
		{
		}

		internal override void TargetStateChanged()
		{
			base.TargetStateChanged();
			_loudSource.Play();
		}

		public override void LockBypassDenied(ReferenceHub ply, byte colliderId)
		{
			RpcPlayDeniedBeep();
		}

		public override void PermissionsDenied(ReferenceHub ply, byte colliderId)
		{
			RpcPlayDeniedBeep();
			PlayDeniedButtonAnims(ply.GetCombinedPermissions(this));
		}

		[ClientRpc]
		public void RpcPlayWarningSound()
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			SendRPCInternal("System.Void Interactables.Interobjects.CheckpointDoor::RpcPlayWarningSound()", -1870757840, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		public void PlayWarningSound()
		{
			_beepSource.PlayOneShot(_warningClip);
		}

		[ClientRpc]
		private void RpcPlayDeniedBeep()
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			SendRPCInternal("System.Void Interactables.Interobjects.CheckpointDoor::RpcPlayDeniedBeep()", -1557414586, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		[ClientRpc]
		private void PlayDeniedButtonAnims(DoorPermissionFlags perms)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			GeneratedNetworkCode._Write_Interactables_002EInterobjects_002EDoorUtils_002EDoorPermissionFlags(writer, perms);
			SendRPCInternal("System.Void Interactables.Interobjects.CheckpointDoor::PlayDeniedButtonAnims(Interactables.Interobjects.DoorUtils.DoorPermissionFlags)", 534590385, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcPlayWarningSound()
		{
			PlayWarningSound();
		}

		protected static void InvokeUserCode_RpcPlayWarningSound(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcPlayWarningSound called on server.");
			}
			else
			{
				((CheckpointDoor)obj).UserCode_RpcPlayWarningSound();
			}
		}

		protected void UserCode_RpcPlayDeniedBeep()
		{
			_beepSource.PlayOneShot(_deniedClip);
		}

		protected static void InvokeUserCode_RpcPlayDeniedBeep(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcPlayDeniedBeep called on server.");
			}
			else
			{
				((CheckpointDoor)obj).UserCode_RpcPlayDeniedBeep();
			}
		}

		protected void UserCode_PlayDeniedButtonAnims__DoorPermissionFlags(DoorPermissionFlags perms)
		{
			ButtonVariant[] buttons = base.Buttons;
			for (int i = 0; i < buttons.Length; i++)
			{
				if (buttons[i] is BasicDoorButton basicDoorButton)
				{
					basicDoorButton.TriggerDoorDenied(perms);
				}
			}
		}

		protected static void InvokeUserCode_PlayDeniedButtonAnims__DoorPermissionFlags(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC PlayDeniedButtonAnims called on server.");
			}
			else
			{
				((CheckpointDoor)obj).UserCode_PlayDeniedButtonAnims__DoorPermissionFlags(GeneratedNetworkCode._Read_Interactables_002EInterobjects_002EDoorUtils_002EDoorPermissionFlags(reader));
			}
		}

		static CheckpointDoor()
		{
			RemoteProcedureCalls.RegisterRpc(typeof(CheckpointDoor), "System.Void Interactables.Interobjects.CheckpointDoor::RpcPlayWarningSound()", InvokeUserCode_RpcPlayWarningSound);
			RemoteProcedureCalls.RegisterRpc(typeof(CheckpointDoor), "System.Void Interactables.Interobjects.CheckpointDoor::RpcPlayDeniedBeep()", InvokeUserCode_RpcPlayDeniedBeep);
			RemoteProcedureCalls.RegisterRpc(typeof(CheckpointDoor), "System.Void Interactables.Interobjects.CheckpointDoor::PlayDeniedButtonAnims(Interactables.Interobjects.DoorUtils.DoorPermissionFlags)", InvokeUserCode_PlayDeniedButtonAnims__DoorPermissionFlags);
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				NetworkWriterExtensions.WriteByte(writer, _curSequence);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 8L) != 0L)
			{
				NetworkWriterExtensions.WriteByte(writer, _curSequence);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _curSequence, SequenceHook, NetworkReaderExtensions.ReadByte(reader));
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 8L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _curSequence, SequenceHook, NetworkReaderExtensions.ReadByte(reader));
			}
		}
	}
}

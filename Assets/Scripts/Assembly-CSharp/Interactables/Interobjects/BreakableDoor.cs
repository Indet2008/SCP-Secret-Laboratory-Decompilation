using System;
using System.Runtime.InteropServices;
using Footprinting;
using Interactables.Interobjects.DoorUtils;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using Mirror;
using UnityEngine;

namespace Interactables.Interobjects
{
	public class BreakableDoor : BasicDoor, IDamageableDoor, INonInteractableDoor, IScp106PassableDoor
	{
		[SyncVar]
		private bool _destroyed;

		private bool _prevDestroyed;

		private BrokenDoor _brokenInstance;

		[Header("Breakable Door Settings")]
		[SerializeField]
		private float _maxHealth = 80f;

		[SerializeField]
		private BrokenDoor _brokenPrefab;

		[SerializeField]
		private DoorDamageType _ignoredDamageSources;

		[SerializeField]
		private GameObject _objectToReplace;

		[SerializeField]
		private bool _nonInteractable;

		[SerializeField]
		[SyncVar]
		private bool _restrict106WhileLocked;

		public float RemainingHealth { get; set; }

		public float MaxHealth
		{
			get
			{
				return _maxHealth;
			}
			set
			{
				_maxHealth = value;
			}
		}

		public DoorDamageType IgnoredDamageSources
		{
			get
			{
				return _ignoredDamageSources;
			}
			set
			{
				_ignoredDamageSources = value;
			}
		}

		public bool IsDestroyed
		{
			get
			{
				return _destroyed;
			}
			set
			{
				if (value != _destroyed)
				{
					if (value)
					{
						ServerDamage(_maxHealth, DoorDamageType.ServerCommand);
					}
					else
					{
						ServerRepair();
					}
				}
			}
		}

		public bool IgnoreLockdowns => _nonInteractable;

		public bool IgnoreRemoteAdmin => _nonInteractable;

		public bool IsScp106Passable
		{
			get
			{
				if (_restrict106WhileLocked && ActiveLocks != 0)
				{
					return TargetState;
				}
				return true;
			}
			set
			{
				Network_restrict106WhileLocked = !value;
			}
		}

		public bool Network_destroyed
		{
			get
			{
				return _destroyed;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _destroyed, 8uL, null);
			}
		}

		public bool Network_restrict106WhileLocked
		{
			get
			{
				return _restrict106WhileLocked;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _restrict106WhileLocked, 16uL, null);
			}
		}

		public event Action OnDestroyedChanged;

		[Server]
		public bool ServerDamage(float hp, DoorDamageType type, Footprint attacker = default(Footprint))
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Boolean Interactables.Interobjects.BreakableDoor::ServerDamage(System.Single,Interactables.Interobjects.DoorUtils.DoorDamageType,Footprinting.Footprint)' called when server was not active");
				return default;
			}
			if (_destroyed)
			{
				return false;
			}
			if (_ignoredDamageSources.HasFlagFast(type))
			{
				return false;
			}
			if (_brokenPrefab == null || _objectToReplace == null)
			{
				return false;
			}
			DoorDamagingEventArgs e = new DoorDamagingEventArgs(this, hp, type);
			ServerEvents.OnDoorDamaging(e);
			if (!e.IsAllowed)
			{
				return false;
			}
			hp = e.Damage;
			type = e.DamageType;
			RemainingHealth -= hp;
			ServerEvents.OnDoorDamaged(new DoorDamagedEventArgs(this, hp, type));
			if (RemainingHealth <= 0f)
			{
				Network_destroyed = true;
				DoorEvents.TriggerAction(this, DoorAction.Destroyed, null);
				if (!attacker.IsSet)
				{
					return true;
				}
				ServerLogs.AddLog(ServerLogs.Modules.Door, string.Format("{0} destroyed {1} door using {2}.", attacker.LoggedNameFromFootprint(), DoorName ?? "unnamed", type), ServerLogs.ServerLogType.GameEvent);
			}
			return true;
		}

		[Server]
		public bool ServerRepair()
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Boolean Interactables.Interobjects.BreakableDoor::ServerRepair()' called when server was not active");
				return default;
			}
			if (!_destroyed)
			{
				return false;
			}
			float maxHealth = _maxHealth;
			DoorRepairingEventArgs e = new DoorRepairingEventArgs(this, maxHealth);
			ServerEvents.OnDoorRepairing(e);
			if (!e.IsAllowed)
			{
				return false;
			}
			maxHealth = e.RemainingHealth;
			Network_destroyed = false;
			RemainingHealth = maxHealth;
			ServerEvents.OnDoorRepaired(new DoorRepairedEventArgs(this, maxHealth));
			return true;
		}

		public override float GetExactState()
		{
			if (!_destroyed)
			{
				return base.GetExactState();
			}
			return 1f;
		}

		public override bool AllowInteracting(ReferenceHub ply, byte colliderId)
		{
			if (!_destroyed)
			{
				return base.AllowInteracting(ply, colliderId);
			}
			return false;
		}

		internal override void TargetStateChanged()
		{
			if (!_destroyed)
			{
				base.TargetStateChanged();
			}
		}

		protected override void Update()
		{
			base.Update();
			if (!_prevDestroyed && _destroyed)
			{
				_prevDestroyed = true;
				ClientDestroyEffects();
				OnDestroyedChanged?.Invoke();
			}
			if (_prevDestroyed && !_destroyed)
			{
				_prevDestroyed = false;
				ClientRepairEffects();
				OnDestroyedChanged?.Invoke();
			}
		}

		protected override void Awake()
		{
			base.Awake();
			RemainingHealth = _maxHealth;
		}

		public void ClientDestroyEffects()
		{
			_objectToReplace.SetActive(value: false);
			if (_brokenPrefab != null && _brokenInstance == null)
			{
				Transform transform = _objectToReplace.transform;
				_brokenInstance = UnityEngine.Object.Instantiate(_brokenPrefab, transform.position, transform.rotation, transform.parent);
				_brokenInstance.transform.localScale = transform.localScale;
			}
		}

		public void ClientRepairEffects()
		{
			_objectToReplace.SetActive(value: true);
			if (_brokenInstance != null)
			{
				UnityEngine.Object.Destroy(_brokenInstance.gameObject);
				_brokenInstance = null;
			}
		}

		public float GetHealthPercent()
		{
			return Mathf.Clamp01(RemainingHealth / _maxHealth);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteBool(_destroyed);
				writer.WriteBool(_restrict106WhileLocked);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 8L) != 0L)
			{
				writer.WriteBool(_destroyed);
			}
			if ((base.syncVarDirtyBits & 0x10L) != 0L)
			{
				writer.WriteBool(_restrict106WhileLocked);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _destroyed, null, reader.ReadBool());
				GeneratedSyncVarDeserialize(ref _restrict106WhileLocked, null, reader.ReadBool());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 8L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _destroyed, null, reader.ReadBool());
			}
			if ((num & 0x10L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _restrict106WhileLocked, null, reader.ReadBool());
			}
		}
	}
}

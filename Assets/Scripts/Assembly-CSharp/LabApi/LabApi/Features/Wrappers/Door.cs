namespace LabApi.Features.Wrappers
{
	public class Door
	{
		private static readonly global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Func<global::Interactables.Interobjects.DoorUtils.DoorVariant, global::LabApi.Features.Wrappers.Door>> TypeWrappers = new global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Func<global::Interactables.Interobjects.DoorUtils.DoorVariant, global::LabApi.Features.Wrappers.Door>>();

		private static readonly global::System.Collections.Generic.Dictionary<string, global::LabApi.Features.Enums.DoorName> DoorNameDictionary = new global::System.Collections.Generic.Dictionary<string, global::LabApi.Features.Enums.DoorName>
		{
			{
				"LCZ_CAFE",
				global::LabApi.Features.Enums.DoorName.LczPc
			},
			{
				"LCZ_WC",
				global::LabApi.Features.Enums.DoorName.LczWc
			},
			{
				"CHECKPOINT_LCZ_A",
				global::LabApi.Features.Enums.DoorName.LczCheckpointA
			},
			{
				"CHECKPOINT_LCZ_B",
				global::LabApi.Features.Enums.DoorName.LczCheckpointB
			},
			{
				"LCZ_ARMORY",
				global::LabApi.Features.Enums.DoorName.LczArmory
			},
			{
				"173_BOTTOM",
				global::LabApi.Features.Enums.DoorName.Lcz173Bottom
			},
			{
				"173_GATE",
				global::LabApi.Features.Enums.DoorName.Lcz173Gate
			},
			{
				"173_CONNECTOR",
				global::LabApi.Features.Enums.DoorName.Lcz173Connector
			},
			{
				"173_ARMORY",
				global::LabApi.Features.Enums.DoorName.Lcz173Armory
			},
			{
				"GR18_INNER",
				global::LabApi.Features.Enums.DoorName.LczGr18Inner
			},
			{
				"GR18",
				global::LabApi.Features.Enums.DoorName.LczGr18Gate
			},
			{
				"914",
				global::LabApi.Features.Enums.DoorName.Lcz914Gate
			},
			{
				"330",
				global::LabApi.Features.Enums.DoorName.Lcz330
			},
			{
				"330_CHAMBER",
				global::LabApi.Features.Enums.DoorName.Lcz330Chamber
			},
			{
				"079_FIRST",
				global::LabApi.Features.Enums.DoorName.Hcz079FirstGate
			},
			{
				"079_SECOND",
				global::LabApi.Features.Enums.DoorName.Hcz079SecondGate
			},
			{
				"079_ARMORY",
				global::LabApi.Features.Enums.DoorName.Hcz079Armory
			},
			{
				"096",
				global::LabApi.Features.Enums.DoorName.Hcz096
			},
			{
				"939_CRYO",
				global::LabApi.Features.Enums.DoorName.Hcz939Cryo
			},
			{
				"HCZ_ARMORY",
				global::LabApi.Features.Enums.DoorName.HczArmory
			},
			{
				"049_ARMORY",
				global::LabApi.Features.Enums.DoorName.Hcz049Armory
			},
			{
				"HID_CHAMBER",
				global::LabApi.Features.Enums.DoorName.HczHidChamber
			},
			{
				"HID_UPPER",
				global::LabApi.Features.Enums.DoorName.HczHidUpper
			},
			{
				"HID_LOWER",
				global::LabApi.Features.Enums.DoorName.HczHidLower
			},
			{
				"HID_LAB",
				global::LabApi.Features.Enums.DoorName.HczHidChamber
			},
			{
				"NUKE_ARMORY",
				global::LabApi.Features.Enums.DoorName.HczNukeArmory
			},
			{
				"106_PRIMARY",
				global::LabApi.Features.Enums.DoorName.Hcz106Primiary
			},
			{
				"106_SECONDARY",
				global::LabApi.Features.Enums.DoorName.Hcz106Secondary
			},
			{
				"HCZ_127_LAB",
				global::LabApi.Features.Enums.DoorName.Hcz127Lab
			},
			{
				"CHECKPOINT_EZ_HCZ_A",
				global::LabApi.Features.Enums.DoorName.HczCheckpoint
			},
			{
				"INTERCOM",
				global::LabApi.Features.Enums.DoorName.EzIntercom
			},
			{
				"GATE_A",
				global::LabApi.Features.Enums.DoorName.EzGateA
			},
			{
				"GATE_B",
				global::LabApi.Features.Enums.DoorName.EzGateB
			},
			{
				"SURFACE_GATE",
				global::LabApi.Features.Enums.DoorName.SurfaceGate
			},
			{
				"SURFACE_NUKE",
				global::LabApi.Features.Enums.DoorName.SurfaceNuke
			},
			{
				"ESCAPE_PRIMARY",
				global::LabApi.Features.Enums.DoorName.SurfaceEscapePrimary
			},
			{
				"ESCAPE_SECONDARY",
				global::LabApi.Features.Enums.DoorName.SurfaceEscapeSecondary
			},
			{
				"ESCAPE_FINAL",
				global::LabApi.Features.Enums.DoorName.SurfaceEscapeFinal
			}
		};

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Door> List => Dictionary.Values;

		protected static global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.DoorUtils.DoorVariant, global::LabApi.Features.Wrappers.Door> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.DoorUtils.DoorVariant, global::LabApi.Features.Wrappers.Door>();

		public bool IsDestroyed => Base == null;

		public global::Interactables.Interobjects.DoorUtils.DoorVariant Base { get; }

		public global::LabApi.Features.Enums.DoorName DoorName { get; }

		public string NameTag => Base.DoorName;

		public global::LabApi.Features.Wrappers.Room[] Rooms
		{
			get
			{
				if (Base.Rooms == null)
				{
					return global::System.Array.Empty<global::LabApi.Features.Wrappers.Room>();
				}
				return global::System.Linq.Enumerable.ToArray(global::System.Linq.Enumerable.Select(Base.Rooms, global::LabApi.Features.Wrappers.Room.Get));
			}
		}

		public global::MapGeneration.FacilityZone Zone => global::System.Linq.Enumerable.FirstOrDefault(Rooms)?.Zone ?? global::MapGeneration.FacilityZone.Other;

		public bool IsOpened
		{
			get
			{
				return Base.TargetState;
			}
			set
			{
				Base.NetworkTargetState = value;
			}
		}

		public bool CanInteract => Base.AllowInteracting(null, 0);

		public float ExactState => Base.GetExactState();

		public bool IsLocked
		{
			get
			{
				return Base.ActiveLocks > 0;
			}
			set
			{
				Base.ServerChangeLock(global::Interactables.Interobjects.DoorUtils.DoorLockReason.AdminCommand, value);
			}
		}

		public global::Interactables.Interobjects.DoorUtils.DoorLockReason LockReason => (global::Interactables.Interobjects.DoorUtils.DoorLockReason)Base.ActiveLocks;

		public global::Interactables.Interobjects.DoorUtils.DoorPermissionFlags Permissions
		{
			get
			{
				return Base.RequiredPermissions.RequiredPermissions;
			}
			set
			{
				Base.RequiredPermissions.RequiredPermissions = value;
			}
		}

		public bool Bypass2176
		{
			get
			{
				return Base.RequiredPermissions.Bypass2176;
			}
			set
			{
				Base.RequiredPermissions.Bypass2176 = value;
			}
		}

		public global::UnityEngine.Transform Transform => Base.transform;

		public global::UnityEngine.GameObject GameObject => Base.gameObject;

		public global::UnityEngine.Vector3 Position => Transform.position;

		public global::UnityEngine.Quaternion Rotation => Transform.rotation;

		protected bool CanCache
		{
			get
			{
				if (!IsDestroyed)
				{
					return Base.isActiveAndEnabled;
				}
				return false;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("doorVariant")]
		public static global::LabApi.Features.Wrappers.Door? Get(global::Interactables.Interobjects.DoorUtils.DoorVariant? doorVariant)
		{
			if (doorVariant == null)
			{
				return null;
			}
			if (Dictionary.TryGetValue(doorVariant, out global::LabApi.Features.Wrappers.Door value))
			{
				return value;
			}
			return CreateDoorWrapper(doorVariant);
		}

		public static global::LabApi.Features.Wrappers.Door? Get(string nametag)
		{
			if (!global::Interactables.Interobjects.DoorUtils.DoorNametagExtension.NamedDoors.TryGetValue(nametag, out var value))
			{
				return null;
			}
			return Get(value.TargetDoor);
		}

		public static global::LabApi.Features.Wrappers.Door? Get(global::LabApi.Features.Enums.DoorName doorName)
		{
			global::System.Collections.Generic.KeyValuePair<string, global::LabApi.Features.Enums.DoorName> keyValuePair = global::System.Linq.Enumerable.FirstOrDefault<global::System.Collections.Generic.KeyValuePair<string, global::LabApi.Features.Enums.DoorName>>(DoorNameDictionary, (global::System.Collections.Generic.KeyValuePair<string, global::LabApi.Features.Enums.DoorName> door) => door.Value == doorName);
			if (string.IsNullOrEmpty(keyValuePair.Key))
			{
				return null;
			}
			if (!global::Interactables.Interobjects.DoorUtils.DoorNametagExtension.NamedDoors.TryGetValue(keyValuePair.Key, out var value))
			{
				return null;
			}
			return Get(value.TargetDoor);
		}

		public static global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Door> Get(global::MapGeneration.FacilityZone facilityZone)
		{
			return global::System.Linq.Enumerable.Where(List, (global::LabApi.Features.Wrappers.Door x) => global::System.Linq.Enumerable.First(x.Rooms).Zone.Equals(facilityZone));
		}

		public static global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Door> Get(global::LabApi.Features.Wrappers.Room roomId)
		{
			return Get(roomId.Base);
		}

		public static global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Door> Get(global::MapGeneration.RoomIdentifier roomId)
		{
			return global::System.Linq.Enumerable.Where(List, (global::LabApi.Features.Wrappers.Door x) => global::System.Linq.Enumerable.First(x.Rooms).Equals(roomId));
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void Initialize()
		{
			global::Interactables.Interobjects.DoorUtils.DoorVariant.OnInstanceCreated += OnAdded;
			global::Interactables.Interobjects.DoorUtils.DoorVariant.OnInstanceRemoved += OnRemoved;
			Register((global::Interactables.Interobjects.BreakableDoor x) => new global::LabApi.Features.Wrappers.BreakableDoor(x));
			Register((global::Interactables.Interobjects.ElevatorDoor x) => new global::LabApi.Features.Wrappers.ElevatorDoor(x));
			Register((global::Interactables.Interobjects.Timed173PryableDoor x) => new global::LabApi.Features.Wrappers.Timed173Gate(x));
			Register((global::Interactables.Interobjects.PryableDoor x) => (!x.name.StartsWith("HCZ BulkDoor")) ? new global::LabApi.Features.Wrappers.Gate(x) : new global::LabApi.Features.Wrappers.BulkheadDoor(x));
			Register((global::Interactables.Interobjects.BasicNonInteractableDoor x) => new global::LabApi.Features.Wrappers.NonInteractableDoor(x));
			Register((global::Interactables.Interobjects.CheckpointDoor x) => new global::LabApi.Features.Wrappers.CheckpointDoor(x));
			Register((global::Interactables.Interobjects.DummyDoor x) => new global::LabApi.Features.Wrappers.DummyDoor(x));
			Register((global::Interactables.Interobjects.DoorUtils.DoorVariant x) => new global::LabApi.Features.Wrappers.Door(x));
		}

		protected static global::LabApi.Features.Wrappers.Door CreateDoorWrapper(global::Interactables.Interobjects.DoorUtils.DoorVariant doorVariant)
		{
			global::System.Type type = doorVariant.GetType();
			if (!TypeWrappers.TryGetValue(type, out global::System.Func<global::Interactables.Interobjects.DoorUtils.DoorVariant, global::LabApi.Features.Wrappers.Door> value))
			{
				global::LabApi.Features.Console.Logger.Warn("Unable to find Door wrapper for " + type.Name + ", backup up to base constructor!");
				return new global::LabApi.Features.Wrappers.Door(doorVariant);
			}
			return value(doorVariant);
		}

		private static void OnAdded(global::Interactables.Interobjects.DoorUtils.DoorVariant doorVariant)
		{
			try
			{
				if (!Dictionary.ContainsKey(doorVariant))
				{
					CreateDoorWrapper(doorVariant);
				}
			}
			catch (global::System.Exception arg)
			{
				global::LabApi.Features.Console.Logger.Error($"An exception occurred while handling the creation of a new door in LabApi.Features.Wrappers.Door.OnAdded(DoorVariant). Error: {arg}");
			}
		}

		private static void OnRemoved(global::Interactables.Interobjects.DoorUtils.DoorVariant doorVariant)
		{
			if (Dictionary.TryGetValue(doorVariant, out global::LabApi.Features.Wrappers.Door value))
			{
				value.OnRemove();
			}
		}

		private static void Register<T>(global::System.Func<T, global::LabApi.Features.Wrappers.Door> constructor) where T : global::Interactables.Interobjects.DoorUtils.DoorVariant
		{
			TypeWrappers.Add(typeof(T), (global::Interactables.Interobjects.DoorUtils.DoorVariant x) => constructor((T)x));
		}

		protected Door(global::Interactables.Interobjects.DoorUtils.DoorVariant doorVariant)
		{
			Base = doorVariant;
			if (CanCache)
			{
				Dictionary.Add(doorVariant, this);
			}
			if (doorVariant.TryGetComponent<global::Interactables.Interobjects.DoorUtils.DoorNametagExtension>(out var component) && !string.IsNullOrEmpty(component.GetName))
			{
				if (DoorNameDictionary.TryGetValue(component.GetName, out var value))
				{
					DoorName = value;
				}
				else
				{
					global::LabApi.Features.Console.Logger.InternalWarn("Missing DoorName enum value for door name tag " + component.GetName);
				}
			}
		}

		public void Lock(global::Interactables.Interobjects.DoorUtils.DoorLockReason reason, bool enabled)
		{
			Base.ServerChangeLock(reason, enabled);
		}

		public void PlayLockBypassDeniedSound()
		{
			Base.LockBypassDenied(null, 0);
		}

		public void PlayPermissionDeniedAnimation()
		{
			Base.PermissionsDenied(null, 0);
		}

		public override string ToString()
		{
			return $"[{GetType().Name}: DoorName={DoorName}, NameTag={NameTag}, Zone={Zone}, IsOpened={IsOpened}, IsLocked={IsLocked}, Permissions={Permissions}]";
		}

		internal virtual void OnRemove()
		{
			Dictionary.Remove(Base);
		}
	}
}

namespace LabApi.Features.Wrappers
{
	public class Ragdoll
	{
		public static global::System.Collections.Generic.Dictionary<global::PlayerRoles.Ragdolls.BasicRagdoll, global::LabApi.Features.Wrappers.Ragdoll> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::PlayerRoles.Ragdolls.BasicRagdoll, global::LabApi.Features.Wrappers.Ragdoll>();

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Ragdoll> List => Dictionary.Values;

		public global::PlayerRoles.Ragdolls.BasicRagdoll Base { get; private set; }

		public bool IsDestroyed => Base == null;

		public global::PlayerRoles.RoleTypeId Role
		{
			get
			{
				return Base.NetworkInfo.RoleType;
			}
			set
			{
				Base.NetworkInfo = new global::PlayerRoles.Ragdolls.RagdollData(Base.Info.OwnerHub, Base.Info.Handler, value, Base.Info.StartRelativePosition, Base.Info.StartRelativeRotation, Base.Info.Nickname, Base.Info.CreationTime, Base.Info.Serial);
			}
		}

		public string Nickname
		{
			get
			{
				return Base.NetworkInfo.Nickname;
			}
			set
			{
				Base.NetworkInfo = new global::PlayerRoles.Ragdolls.RagdollData(Base.Info.OwnerHub, Base.Info.Handler, Base.Info.RoleType, Base.Info.StartRelativePosition, Base.Info.StartRelativeRotation, value, Base.Info.CreationTime, Base.Info.Serial);
			}
		}

		public global::PlayerStatsSystem.DamageHandlerBase DamageHandler
		{
			get
			{
				return Base.NetworkInfo.Handler;
			}
			set
			{
				Base.NetworkInfo = new global::PlayerRoles.Ragdolls.RagdollData(Base.Info.OwnerHub, value, Base.Info.RoleType, Base.Info.StartRelativePosition, Base.Info.StartRelativeRotation, Base.Info.Nickname, Base.Info.CreationTime, Base.Info.Serial);
			}
		}

		public global::UnityEngine.Vector3 Position
		{
			get
			{
				return Base.transform.position;
			}
			set
			{
				Base.transform.position = value;
				global::RelativePositioning.RelativePosition relPos = new global::RelativePositioning.RelativePosition(value);
				global::UnityEngine.Quaternion relativeRotation = global::RelativePositioning.WaypointBase.GetRelativeRotation(relPos.WaypointId, global::RelativePositioning.WaypointBase.GetWorldRotation(Base.Info.StartRelativePosition.WaypointId, Base.Info.StartRelativeRotation));
				Base.NetworkInfo = new global::PlayerRoles.Ragdolls.RagdollData(Base.Info.OwnerHub, Base.Info.Handler, Base.Info.RoleType, relPos, relativeRotation, Base.Info.Scale, Base.Info.Nickname, Base.Info.CreationTime, Base.Info.Serial);
			}
		}

		public global::UnityEngine.Quaternion Rotation
		{
			get
			{
				return Base.transform.rotation;
			}
			set
			{
				Base.transform.rotation = value;
				global::UnityEngine.Quaternion relativeRotation = global::RelativePositioning.WaypointBase.GetRelativeRotation(Base.Info.StartRelativePosition.WaypointId, value);
				Base.NetworkInfo = new global::PlayerRoles.Ragdolls.RagdollData(Base.Info.OwnerHub, Base.Info.Handler, Base.Info.RoleType, Base.Info.StartRelativePosition, relativeRotation, Base.Info.Scale, Base.Info.Nickname, Base.Info.CreationTime, Base.Info.Serial);
			}
		}

		public global::UnityEngine.Vector3 Scale
		{
			get
			{
				return Base.transform.localScale;
			}
			set
			{
				Base.transform.localScale = value;
				Base.NetworkInfo = new global::PlayerRoles.Ragdolls.RagdollData(Base.Info.OwnerHub, Base.Info.Handler, Base.Info.RoleType, Base.Info.StartRelativePosition, Base.Info.StartRelativeRotation, global::UnityEngine.Vector3.Scale(value, global::PlayerRoles.Ragdolls.RagdollManager.GetDefaultScale(Role)), Base.Info.Nickname, Base.Info.CreationTime, Base.Info.Serial);
			}
		}

		public ushort Serial => Base.NetworkInfo.Serial;

		public bool IsConsumed
		{
			get
			{
				return global::PlayerRoles.PlayableScps.Scp049.Zombies.ZombieConsumeAbility.ConsumedRagdolls.Contains(Base);
			}
			set
			{
				if (value)
				{
					global::PlayerRoles.PlayableScps.Scp049.Zombies.ZombieConsumeAbility.ConsumedRagdolls.Add(Base);
				}
				else
				{
					global::PlayerRoles.PlayableScps.Scp049.Zombies.ZombieConsumeAbility.ConsumedRagdolls.Remove(Base);
				}
			}
		}

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

		public static global::LabApi.Features.Wrappers.Ragdoll? SpawnRagdoll(global::LabApi.Features.Wrappers.Player player, global::PlayerStatsSystem.DamageHandlerBase handler)
		{
			global::PlayerRoles.RoleTypeId role = player.Role;
			global::UnityEngine.Vector3 position = player.Position;
			global::UnityEngine.Quaternion rotation = player.Rotation;
			string displayName = player.DisplayName;
			ReferenceHub referenceHub = player.ReferenceHub;
			return SpawnRagdoll(role, position, rotation, handler, displayName, null, null, referenceHub);
		}

		public static global::LabApi.Features.Wrappers.Ragdoll? SpawnRagdoll(global::PlayerRoles.RoleTypeId role, global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::PlayerStatsSystem.DamageHandlerBase handler, string nickname, global::UnityEngine.Vector3? scale = null, ushort? serial = null, ReferenceHub? owner = null)
		{
			global::PlayerRoles.Ragdolls.BasicRagdoll basicRagdoll = global::PlayerRoles.Ragdolls.RagdollManager.ServerCreateRagdoll(role, position, rotation, handler, nickname, scale, serial, owner);
			if (!(basicRagdoll == null))
			{
				return Get(basicRagdoll);
			}
			return null;
		}

		public static global::LabApi.Features.Wrappers.Ragdoll Get(global::PlayerRoles.Ragdolls.BasicRagdoll ragdoll)
		{
			if (!Dictionary.TryGetValue(ragdoll, out global::LabApi.Features.Wrappers.Ragdoll value))
			{
				return new global::LabApi.Features.Wrappers.Ragdoll(ragdoll);
			}
			return value;
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void Initialize()
		{
			Dictionary.Clear();
			global::PlayerRoles.Ragdolls.RagdollManager.OnRagdollSpawned += RagdollSpawned;
			global::PlayerRoles.Ragdolls.RagdollManager.OnRagdollRemoved += RagdollRemoved;
		}

		private static void RagdollSpawned(global::PlayerRoles.Ragdolls.BasicRagdoll ragdoll)
		{
			_ = new global::LabApi.Features.Wrappers.Ragdoll(ragdoll).Base;
		}

		private static void RagdollRemoved(global::PlayerRoles.Ragdolls.BasicRagdoll ragdoll)
		{
			Dictionary.Remove(ragdoll);
		}

		private Ragdoll(global::PlayerRoles.Ragdolls.BasicRagdoll ragdoll)
		{
			Base = ragdoll;
			if (CanCache)
			{
				Dictionary.TryAdd(ragdoll, this);
			}
		}

		public bool IsRevivableBy(global::LabApi.Features.Wrappers.Player scp049)
		{
			if (!(scp049.RoleBase is global::PlayerRoles.PlayableScps.Scp049.Scp049Role scp049Role))
			{
				return false;
			}
			if (!scp049Role.SubroutineModule.TryGetSubroutine<global::PlayerRoles.PlayableScps.Scp049.Scp049ResurrectAbility>(out var subroutine))
			{
				return false;
			}
			return subroutine.CheckRagdoll(Base);
		}

		public void Destroy()
		{
			global::Mirror.NetworkServer.Destroy(Base.gameObject);
		}

		public void Freeze()
		{
			Base.ClientFreezeRpc();
		}

		public void UnFreeze()
		{
			global::PlayerRoles.Ragdolls.RagdollData networkInfo = Base.NetworkInfo;
			global::PlayerRoles.Ragdolls.RagdollManager.OnRagdollSpawned -= RagdollSpawned;
			global::PlayerRoles.Ragdolls.RagdollManager.OnRagdollRemoved -= RagdollRemoved;
			Destroy();
			Dictionary.Remove(Base);
			Base = global::PlayerRoles.Ragdolls.RagdollManager.ServerCreateRagdoll(networkInfo.RoleType, networkInfo.StartRelativePosition.Position, networkInfo.StartRelativeRotation, networkInfo.Handler, networkInfo.Nickname, networkInfo.Scale, networkInfo.Serial);
			Dictionary.TryAdd(Base, this);
			global::PlayerRoles.Ragdolls.RagdollManager.OnRagdollSpawned += RagdollSpawned;
			global::PlayerRoles.Ragdolls.RagdollManager.OnRagdollRemoved += RagdollRemoved;
		}

		public override string ToString()
		{
			return $"[Ragdoll: Nickname={Nickname}, Role={Role}, DamageHandler={DamageHandler}, Position={Position}, Rotation={Rotation}, Scale={Scale}, IsConsumed={IsConsumed}]";
		}
	}
}

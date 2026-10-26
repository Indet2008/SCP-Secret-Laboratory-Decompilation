using System;
using System.Diagnostics;
using GameObjectPools;
using Mirror;
using UnityEngine;

namespace PlayerRoles
{
	public abstract class PlayerRoleBase : PoolObject
	{
		private ReferenceHub _lastOwner;

		private RoleSpawnFlags _spawnFlags;

		private RoleChangeReason _spawnReason;

		private readonly Stopwatch _activeTime = Stopwatch.StartNew();

		private static int _lastAssignedLifeIdentifier;

		public Action<RoleTypeId> OnRoleDisabled;

		public abstract RoleTypeId RoleTypeId { get; }

		public abstract Team Team { get; }

		public abstract Color RoleColor { get; }

		[field: SerializeField]
		public virtual GameObject RoleHelpInfo { get; private set; }

		[field: SerializeField]
		public RoleVariantsModule VariantsModule { get; internal set; }

		public string RoleName
		{
			get
			{
				if (!(this is ICustomNameRole customNameRole))
				{
					return RoleTranslations.GetRoleName(RoleTypeId);
				}
				return customNameRole.CustomRoleName;
			}
		}

		public float ActiveTime => (float)_activeTime.Elapsed.TotalSeconds;

		public bool IsLocalPlayer
		{
			get
			{
				if (TryGetOwner(out var hub))
				{
					return hub.isLocalPlayer;
				}
				return false;
			}
		}

		public bool IsPOV
		{
			get
			{
				if (TryGetOwner(out var hub))
				{
					return hub.IsPOV;
				}
				return false;
			}
		}

		public bool IsEmulatedDummy
		{
			get
			{
				if (NetworkServer.active && TryGetOwner(out var hub))
				{
					return hub.IsDummy;
				}
				return false;
			}
		}

		public bool IsControllable
		{
			get
			{
				if (!IsLocalPlayer)
				{
					return IsEmulatedDummy;
				}
				return true;
			}
		}

		public int UniqueLifeIdentifier { get; private set; }

		public RoleChangeReason ServerSpawnReason
		{
			get
			{
				if (!NetworkServer.active)
				{
					UnityEngine.Debug.LogError("Server-only property ServerSpawnReason cannot be called on the client!");
				}
				return _spawnReason;
			}
			private set
			{
				_spawnReason = value;
			}
		}

		public RoleSpawnFlags ServerSpawnFlags
		{
			get
			{
				if (!NetworkServer.active)
				{
					UnityEngine.Debug.LogError("Server-only property ServerSpawnFlags cannot be called on the client!");
				}
				return _spawnFlags;
			}
			set
			{
				_spawnFlags = value;
			}
		}

		internal virtual void Init(ReferenceHub hub, RoleChangeReason spawnReason, RoleSpawnFlags spawnFlags)
		{
			_lastOwner = hub;
			_spawnFlags = spawnFlags;
			_spawnReason = spawnReason;
			_activeTime.Restart();
			UniqueLifeIdentifier = ++_lastAssignedLifeIdentifier;
		}

		public bool TryGetOwner(out ReferenceHub hub)
		{
			hub = _lastOwner;
			return !base.Pooled;
		}

		public virtual void DisableRole(RoleTypeId newRole)
		{
			try
			{
				OnRoleDisabled?.Invoke(newRole);
				ReturnToPool();
			}
			catch (Exception exception)
			{
				UnityEngine.Debug.Log($"Disabling {RoleTypeId} role has thrown an exception while switching to {newRole}.");
				UnityEngine.Debug.LogException(exception);
			}
		}

		public override string ToString()
		{
			return string.Format("{0} (RoleTypeId = '{1}', Owner = '{2}', ActiveTime = '{3}')", "PlayerRoleBase", RoleTypeId, _lastOwner, ActiveTime);
		}
	}
}

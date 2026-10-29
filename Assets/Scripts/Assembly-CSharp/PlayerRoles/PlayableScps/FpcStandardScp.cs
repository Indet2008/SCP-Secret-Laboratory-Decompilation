using Interactables.Interobjects.DoorUtils;
using PlayerRoles.Blood;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Spawnpoints;
using PlayerRoles.PlayableScps.HUDs;
using PlayerRoles.RoleAssign;
using UnityEngine;

namespace PlayerRoles.PlayableScps
{
	public class FpcStandardScp : FpcStandardRoleBase, IBleedableRole, IDoorPermissionProvider
	{
		[SerializeField]
		private RoleTypeId _roleTypeId;

		[SerializeField]
		private int _maxHealth;

		[SerializeField]
		private MonoBehaviour _spawnpointHandler;

		[field: SerializeField]
		public BloodSettings BloodSettings { get; private set; }

		public override RoleTypeId RoleTypeId => _roleTypeId;

		public override Team Team => Team.SCPs;

		public override Color RoleColor => Color.red;

		public override float MaxHealth
		{
			get
			{
				if (!RoleAssigner.ScpsOverflowing)
				{
					return _maxHealth;
				}
				return (float)_maxHealth * 1.1f;
			}
		}

		public override ISpawnpointHandler SpawnpointHandler => _spawnpointHandler as ISpawnpointHandler;

		public override float AmbientBoost
		{
			get
			{
				if (!InsufficientLight)
				{
					return base.AmbientBoost;
				}
				return 0.2f;
			}
		}

		public virtual PermissionUsed PermissionsUsedCallback => null;

		public virtual DoorPermissionFlags GetPermissions(IDoorPermissionRequester requester)
		{
			return DoorPermissionFlags.ScpOverride;
		}

		public override bool TryGetViewmodelFov(out float fov)
		{
			if (this is IHudScp && ScpHudController.CurInstance is IViewmodelRole viewmodelRole)
			{
				return viewmodelRole.TryGetViewmodelFov(out fov);
			}
			return base.TryGetViewmodelFov(out fov);
		}
	}
}

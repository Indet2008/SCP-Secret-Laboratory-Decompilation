using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.Spectating
{
	public class OverwatchRole : SpectatorRole, IObfuscatedRole, ISubroutinedRole
	{
		[SerializeField]
		private GameObject _hudPrefab;

		public override RoleTypeId RoleTypeId => RoleTypeId.Overwatch;

		public override Color RoleColor => Color.cyan;

		public override bool ReadyToRespawn => false;

		[field: SerializeField]
		public SubroutineManagerModule SubroutineModule { get; private set; }

		[field: SerializeField]
		public OverwatchPlayerInfoModule PlayerInfoModule { get; private set; }

		[field: SerializeField]
		public OverwatchHitRegModule HitRegModule { get; private set; }

		public bool ServerPlayerInfoEnabled { get; set; }

		public bool ServerHitRegEnabled { get; set; }

		public GameObject OverwatchHud { get; private set; }

		public RoleTypeId GetRoleForUser(ReferenceHub receiver)
		{
			TryGetOwner(out var hub);
			if (!(hub == receiver) && !PermissionsHandler.IsPermitted(receiver.serverRoles.Permissions, PlayerPermissions.GameplayData))
			{
				return base.RoleTypeId;
			}
			return RoleTypeId;
		}

		public override void DisableRole(RoleTypeId newRole)
		{
			base.DisableRole(newRole);
			ServerPlayerInfoEnabled = false;
			ServerHitRegEnabled = false;
		}

		protected override void ScheduleNextTarget(uint killerId)
		{
		}

		public bool SpawnHud()
		{
			if (OverwatchHud != null)
			{
				return false;
			}
			OverwatchHud = Object.Instantiate(_hudPrefab);
			OverwatchUIController.Instance.SetRootVisibility(visible: true);
			return true;
		}

		public bool DestroyHud()
		{
			if (OverwatchHud == null)
			{
				return false;
			}
			OverwatchUIController.Instance.SetRootVisibility(visible: false);
			Object.Destroy(OverwatchHud);
			OverwatchHud = null;
			return true;
		}
	}
}

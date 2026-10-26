using PlayerRoles;
using UnityEngine.Rendering;
using Utils.NonAllocLINQ;

namespace CustomPlayerEffects
{
	public class Traumatized : StatusEffectBase
	{
		public Volume PPVolume;

		public override bool AllowEnabling => !SpawnProtected.CheckPlayer(base.Hub);

		protected override void Start()
		{
			base.Start();
			PlayerRoleManager.OnServerRoleSet += OnServerRoleChanged;
		}

		private void OnDestroy()
		{
			PlayerRoleManager.OnServerRoleSet -= OnServerRoleChanged;
		}

		private void OnServerRoleChanged(ReferenceHub hub, RoleTypeId newRole, RoleChangeReason reason)
		{
			if (reason == RoleChangeReason.Died && newRole == RoleTypeId.Spectator && hub.GetRoleId() == RoleTypeId.Scp106 && !ReferenceHub.AllHubs.Any((ReferenceHub x) => x != hub && x.GetRoleId() == RoleTypeId.Scp106))
			{
				ServerSetState(0);
			}
		}

		protected override void Enabled()
		{
			base.Enabled();
			if (!ReferenceHub.AllHubs.Any((ReferenceHub x) => x.GetRoleId() == RoleTypeId.Scp106))
			{
				ServerSetState(0);
			}
		}
	}
}

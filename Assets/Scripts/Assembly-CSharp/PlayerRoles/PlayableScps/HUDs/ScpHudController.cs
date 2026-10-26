using PlayerRoles.Spectating;
using UnityEngine;

namespace PlayerRoles.PlayableScps.HUDs
{
	public static class ScpHudController
	{
		public static ScpHudBase CurInstance { get; private set; }

		[RuntimeInitializeOnLoadMethod]
		private static void InitOnLoad()
		{
			PlayerRoleManager.OnRoleChanged += RoleChanged;
			SpectatorTargetTracker.OnTargetChanged += TargetChanged;
		}

		private static bool ValidatePlayer(ReferenceHub hub)
		{
			if (hub.isLocalPlayer)
			{
				return true;
			}
			if (SpectatorTargetTracker.TryGetTrackedPlayer(out var hub2))
			{
				return hub2 == hub;
			}
			if (CurInstance == null)
			{
				return false;
			}
			return CurInstance.Hub == hub;
		}

		private static void RoleChanged(ReferenceHub hub, PlayerRoleBase prev, PlayerRoleBase cur)
		{
			if (!ValidatePlayer(hub))
			{
				return;
			}
			if (cur is IHudScp hudScp)
			{
				DestroyOld();
				SpawnNew(hudScp, hub);
			}
			else if (cur is SpectatorRole)
			{
				if (CurInstance != null)
				{
					CurInstance.OnDied();
				}
			}
			else
			{
				DestroyOld();
			}
		}

		private static void TargetChanged()
		{
			if (SpectatorTargetTracker.TryGetTrackedPlayer(out var hub))
			{
				DestroyOld();
				if (hub.roleManager.CurrentRole is IHudScp hudScp)
				{
					SpawnNew(hudScp, hub);
				}
			}
		}

		private static void DestroyOld()
		{
			if (!(CurInstance == null))
			{
				Object.Destroy(CurInstance.gameObject);
			}
		}

		private static void SpawnNew(IHudScp hudScp, ReferenceHub owner)
		{
			CurInstance = Object.Instantiate(hudScp.HudPrefab);
			CurInstance.Init(owner);
		}
	}
}

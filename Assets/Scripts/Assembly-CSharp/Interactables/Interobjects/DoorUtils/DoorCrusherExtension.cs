using GameCore;
using Mirror;
using PlayerRoles;
using PlayerStatsSystem;
using UnityEngine;

namespace Interactables.Interobjects.DoorUtils
{
	public class DoorCrusherExtension : DoorVariantExtension
	{
		private const string CrushSettingsKey = "crush_players";

		public float MaxCrushThreshold = 0.2f;

		public float MinCrushThreshold = 0.1f;

		public Collider DeathCollider;

		public float ScpCrushDamage = 200f;

		public bool IgnoreScps;

		private bool _enabled;

		private void Start()
		{
			if (!ConfigFile.ServerConfig.GetBool("crush_players", def: true))
			{
				Object.Destroy(this);
				return;
			}
			bool flag = (DeathCollider.enabled = false);
			_enabled = flag;
		}

		private void OnTriggerEnter(Collider other)
		{
			if (!NetworkServer.active || !ReferenceHub.TryGetHub(other.transform.root.gameObject, out var hub))
			{
				return;
			}
			PlayerRoleBase currentRole = hub.roleManager.CurrentRole;
			if (currentRole.RoleTypeId != RoleTypeId.Scp106)
			{
				bool flag = currentRole.Team == Team.SCPs;
				if (!(IgnoreScps & flag))
				{
					float damage = (flag ? ScpCrushDamage : (-1f));
					hub.playerStats.DealDamage(new UniversalDamageHandler(damage, DeathTranslations.Crushed));
				}
			}
		}

		private void Update()
		{
			if (NetworkServer.active)
			{
				bool flag = IsColliderEnabled();
				if (_enabled != flag)
				{
					DeathCollider.enabled = (_enabled = flag);
				}
			}
		}

		private bool IsColliderEnabled()
		{
			if (TargetDoor.TargetState)
			{
				return false;
			}
			if (TargetDoor is PryableDoor { IsBeingPried: not false })
			{
				return false;
			}
			float exactState = TargetDoor.GetExactState();
			if (exactState < MaxCrushThreshold)
			{
				return exactState > MinCrushThreshold;
			}
			return false;
		}
	}
}

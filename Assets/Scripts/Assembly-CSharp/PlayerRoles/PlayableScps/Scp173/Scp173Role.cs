using System;
using System.Collections.Generic;
using Mirror;
using PlayerRoles.PlayableScps.HUDs;
using PlayerRoles.PlayableScps.HumeShield;
using PlayerRoles.Subroutines;
using PlayerStatsSystem;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp173
{
	public class Scp173Role : FpcStandardScp, ISubroutinedRole, IArmoredRole, IHumeShieldedRole, IHudScp, ISpawnableScp
	{
		[SerializeField]
		private int _armorEfficacy;

		private ReferenceHub _owner;

		private Scp173AudioPlayer _audio;

		private bool _damagedEventAssigned;

		private bool DamagedEventActive
		{
			get
			{
				return _damagedEventAssigned;
			}
			set
			{
				if (value != DamagedEventActive && (!value || NetworkServer.active))
				{
					PlayerStats playerStats = _owner.playerStats;
					if (value)
					{
						playerStats.OnThisPlayerDamaged += OnDamaged;
					}
					else
					{
						playerStats.OnThisPlayerDamaged -= OnDamaged;
					}
					_damagedEventAssigned = value;
				}
			}
		}

		public ScpDamageHandler DamageHandler
		{
			get
			{
				if (!TryGetOwner(out var hub))
				{
					throw new InvalidOperationException("Damage handler could not be created for an inactive instance of SCP-173.");
				}
				return new ScpDamageHandler(hub, DeathTranslations.Scp173);
			}
		}

		[field: SerializeField]
		public HumeShieldModuleBase HumeShieldModule { get; private set; }

		[field: SerializeField]
		public SubroutineManagerModule SubroutineModule { get; private set; }

		[field: SerializeField]
		public ScpHudBase HudPrefab { get; private set; }

		private void OnDamaged(DamageHandlerBase obj)
		{
			if (obj is FirearmDamageHandler)
			{
				_audio.ServerSendSound(Scp173AudioPlayer.Scp173SoundId.Hit);
			}
		}

		private void Awake()
		{
			SubroutineModule.TryGetSubroutine<Scp173AudioPlayer>(out _audio);
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			TryGetOwner(out _owner);
			DamagedEventActive = true;
		}

		public override void DisableRole(RoleTypeId newRole)
		{
			base.DisableRole(newRole);
			DamagedEventActive = false;
		}

		public int GetArmorEfficacy(HitboxType hitbox)
		{
			return _armorEfficacy;
		}

		public float GetSpawnChance(List<RoleTypeId> alreadySpawned)
		{
			return 1f;
		}
	}
}

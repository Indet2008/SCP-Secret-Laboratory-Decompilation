using System;
using GameObjectPools;
using Mirror;
using PlayerStatsSystem;
using UnityEngine;

namespace PlayerRoles.PlayableScps.HumeShield
{
	public abstract class HumeShieldModuleBase : MonoBehaviour, IPoolSpawnable, IHumeShieldProvider
	{
		[SerializeField]
		private PlayerRoleBase _role;

		protected HumeShieldStat HsStat { get; private set; }

		protected ReferenceHub Owner { get; private set; }

		public PlayerRoleBase Role => _role;

		public float HsCurrent
		{
			get
			{
				return HsStat.CurValue;
			}
			set
			{
				if (!NetworkServer.active)
				{
					throw new InvalidOperationException("Hume Shield cannot be assigned by a client!");
				}
				HsStat.CurValue = value;
			}
		}

		public virtual bool ForceBarVisible => HsMax > 0f;

		public abstract float HsMax { get; }

		public abstract float HsRegeneration { get; }

		public abstract Color? HsWarningColor { get; }

		public abstract bool HideWhenEmpty { get; }

		public virtual void OnHsValueChanged(float prevValue, float newValue)
		{
		}

		public virtual void SpawnObject()
		{
			if (!Role.TryGetOwner(out var hub))
			{
				throw new InvalidOperationException("'" + base.name + "' Hume Shield Controller spawned without a role!");
			}
			Owner = hub;
			HsStat = hub.playerStats.GetModule<HumeShieldStat>();
		}
	}
}

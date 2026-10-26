using System;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Scp127
{
	public class Scp127ActionModule : AutomaticActionModule, IReloadUnloadValidatorModule
	{
		[Serializable]
		private struct FireRateTierPair
		{
			public Scp127Tier Tier;

			public float FireRate;
		}

		[SerializeField]
		private FireRateTierPair[] _fireRates;

		public IReloadUnloadValidatorModule.Authorization ReloadAuthorization
		{
			get
			{
				if (base.AmmoStored <= 0)
				{
					return IReloadUnloadValidatorModule.Authorization.Allowed;
				}
				return IReloadUnloadValidatorModule.Authorization.Vetoed;
			}
		}

		public IReloadUnloadValidatorModule.Authorization UnloadAuthorization => IReloadUnloadValidatorModule.Authorization.Idle;

		public override float BaseFireRate
		{
			get
			{
				Scp127Tier tierForItem = Scp127TierManagerModule.GetTierForItem(base.Item);
				FireRateTierPair[] fireRates = _fireRates;
				for (int i = 0; i < fireRates.Length; i++)
				{
					FireRateTierPair fireRateTierPair = fireRates[i];
					if (fireRateTierPair.Tier == tierForItem)
					{
						return fireRateTierPair.FireRate;
					}
				}
				return base.BaseFireRate;
			}
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			if (base.IsControllable && base.AmmoStored <= 0 && base.Firearm.TryGetSubcomponent<AnimatorReloaderModuleBase>(out var ret))
			{
				ret.ClientTryReload();
			}
		}
	}
}

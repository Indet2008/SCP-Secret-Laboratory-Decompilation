using System;
using System.Collections.Generic;
using InventorySystem.Items.Autosync;
using InventorySystem.Items.Pickups;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Scp127
{
	public class Scp127MagazineModule : MagazineModule
	{
		[Serializable]
		private struct RegenerationSettings
		{
			public Scp127Tier Tier;

			public float BulletsPerSecond;

			public float PostFireDelay;
		}

		private static readonly Dictionary<ushort, double> DropTimes = new Dictionary<ushort, double>();

		[SerializeField]
		private RegenerationSettings[] _regenerationPerTier;

		private float _remainingRegenPause;

		private float _regenProgress;

		[field: SerializeField]
		public int KillBonus { get; private set; }

		[field: SerializeField]
		public int RankUpBonus { get; private set; }

		public override IReloadUnloadValidatorModule.Authorization ReloadAuthorization
		{
			get
			{
				if (base.AmmoStored != 0)
				{
					return IReloadUnloadValidatorModule.Authorization.Idle;
				}
				return IReloadUnloadValidatorModule.Authorization.Vetoed;
			}
		}

		public override IReloadUnloadValidatorModule.Authorization UnloadAuthorization => IReloadUnloadValidatorModule.Authorization.Vetoed;

		private RegenerationSettings ActiveSettings
		{
			get
			{
				Scp127Tier tierForItem = Scp127TierManagerModule.GetTierForItem(base.Item);
				RegenerationSettings[] regenerationPerTier = _regenerationPerTier;
				for (int i = 0; i < regenerationPerTier.Length; i++)
				{
					RegenerationSettings result = regenerationPerTier[i];
					if (result.Tier == tierForItem)
					{
						return result;
					}
				}
				return default;
			}
		}

		private void ServerOnFired()
		{
			_remainingRegenPause = ActiveSettings.PostFireDelay;
		}

		private void ServerGrantRewardSafe(int maxReward)
		{
			int ammoStored = base.AmmoStored;
			int num = Mathf.Min(base.AmmoMax, ammoStored + maxReward) - ammoStored;
			if (num != 0)
			{
				ServerModifyAmmo(num);
			}
		}

		protected override void OnInit()
		{
			base.OnInit();
			base.Firearm.TryGetModule<IHitregModule>(out var module);
			module.ServerOnFired += ServerOnFired;
		}

		internal override void OnRemoved(ItemPickupBase pickup)
		{
			base.OnRemoved(pickup);
			if (NetworkServer.active && !(pickup == null))
			{
				DropTimes[base.ItemSerial] = NetworkTime.time + (double)Mathf.Max(0f, _remainingRegenPause);
			}
		}

		internal override void OnAdded()
		{
			base.OnAdded();
			if (NetworkServer.active && DropTimes.TryGetValue(base.ItemSerial, out var value))
			{
				float num = (float)(NetworkTime.time - value);
				if (num < 0f)
				{
					_remainingRegenPause = Mathf.Abs(num);
					return;
				}
				float bulletsPerSecond = ActiveSettings.BulletsPerSecond;
				int maxReward = Mathf.FloorToInt(num * bulletsPerSecond);
				ServerGrantRewardSafe(maxReward);
			}
		}

		internal override void AlwaysUpdate()
		{
			base.AlwaysUpdate();
			if (!NetworkServer.active)
			{
				return;
			}
			if (_remainingRegenPause > 0f)
			{
				_remainingRegenPause -= Time.deltaTime;
				return;
			}
			_regenProgress += Time.deltaTime * ActiveSettings.BulletsPerSecond;
			while (_regenProgress >= 1f)
			{
				_regenProgress--;
				ServerGrantRewardSafe(1);
			}
		}

		internal override void OnClientReady()
		{
			base.OnClientReady();
			DropTimes.Clear();
		}

		internal override void OnTemplateReloaded(ModularAutosyncItem template, bool wasEverLoaded)
		{
			base.OnTemplateReloaded(template, wasEverLoaded);
			if (!wasEverLoaded)
			{
				Scp127TierManagerModule.ServerOnKilled += OnPlayerKilled;
				Scp127TierManagerModule.ServerOnLevelledUp += OnLevelledUp;
			}
		}

		private void OnLevelledUp(Firearm scp127)
		{
			if (scp127.TryGetModule<Scp127MagazineModule>(out var module))
			{
				module.ServerGrantRewardSafe(module.RankUpBonus);
			}
		}

		private void OnPlayerKilled(Firearm scp127, ReferenceHub _)
		{
			if (scp127.TryGetModule<Scp127MagazineModule>(out var module))
			{
				module.ServerGrantRewardSafe(module.KillBonus);
			}
		}
	}
}

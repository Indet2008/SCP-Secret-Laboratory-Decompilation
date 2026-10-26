using System.Collections.Generic;
using InventorySystem.Items.Firearms.Modules.Misc;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class SubsequentShotsInaccuracyModule : ModuleBase, IInaccuracyProviderModule
	{
		private class InaccuracySettings
		{
			public float TargetDeviation;

			public int ShotsToReach;

			public int Offset;

			public InaccuracySettings(float targetDeviation, int shotsToReach, int offset)
			{
				TargetDeviation = targetDeviation;
				ShotsToReach = shotsToReach;
				Offset = offset;
			}
		}

		private static readonly InaccuracySettings DefaultSettings = new InaccuracySettings(1f, 10, 1);

		private static readonly Dictionary<FirearmCategory, InaccuracySettings> SettingsByCategory = new Dictionary<FirearmCategory, InaccuracySettings>
		{
			[FirearmCategory.Pistol] = new InaccuracySettings(0.4f, 5, 0),
			[FirearmCategory.Revolver] = new InaccuracySettings(0.4f, 2, 0),
			[FirearmCategory.SubmachineGun] = new InaccuracySettings(0.4f, 18, 5),
			[FirearmCategory.LightMachineGun] = new InaccuracySettings(0.56f, 12, 3),
			[FirearmCategory.Rifle] = new InaccuracySettings(0.35f, 15, 2)
		};

		private SubsequentShotsCounter _shotsCounter;

		private float _inaccuracyNextFrame;

		[SerializeField]
		private StatModifier _optionalModifier;

		public float Inaccuracy { get; private set; }

		private void Update()
		{
			if (_shotsCounter != null)
			{
				Inaccuracy = _optionalModifier.Process(_inaccuracyNextFrame);
				_shotsCounter.Update();
				InaccuracySettings orAdd = SettingsByCategory.GetOrAdd(base.Firearm.FirearmCategory, () => DefaultSettings);
				_inaccuracyNextFrame = Mathf.InverseLerp(orAdd.Offset, orAdd.ShotsToReach, _shotsCounter.SubsequentShots) * orAdd.TargetDeviation;
			}
		}

		private void OnDestroy()
		{
			_shotsCounter?.Destruct();
		}

		internal override void OnAdded()
		{
			base.OnAdded();
			_shotsCounter = new SubsequentShotsCounter(base.Firearm);
		}
	}
}

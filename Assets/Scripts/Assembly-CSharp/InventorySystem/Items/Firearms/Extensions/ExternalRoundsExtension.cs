using System;
using InventorySystem.Items.Firearms.Modules;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class ExternalRoundsExtension : MixedExtension
	{
		[SerializeField]
		private GameObject[] _rounds;

		[SerializeField]
		private bool _countChamberedRounds;

		[SerializeField]
		private bool _countMagazineRounds;

		private Func<DisplayAmmoValues> _fetcher;

		private int? _prevValue;

		private void Update()
		{
			DisplayAmmoValues displayAmmoValues = _fetcher?.Invoke() ?? default(DisplayAmmoValues);
			int num = 0;
			if (_countChamberedRounds)
			{
				num += displayAmmoValues.Chambered;
			}
			if (_countMagazineRounds)
			{
				num += displayAmmoValues.Magazines;
			}
			if (!_prevValue.HasValue || num != _prevValue)
			{
				_prevValue = num;
				for (int i = 0; i < _rounds.Length; i++)
				{
					_rounds[i].SetActive(i < num);
				}
			}
		}

		public override void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			base.InitViewmodel(viewmodel);
			_fetcher = () => IDisplayableAmmoProviderModule.GetCombinedDisplayAmmo(viewmodel.ParentFirearm);
		}

		public override void SetupWorldmodel(FirearmWorldmodel worldmodel)
		{
			base.SetupWorldmodel(worldmodel);
			_fetcher = () => IDisplayableAmmoProviderModule.GetCombinedDisplayAmmo(worldmodel.Identifier);
		}
	}
}

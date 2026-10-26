using System;
using InventorySystem.Items.Firearms.Modules;
using TMPro;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	[PresetPrefabExtension("Ammo Counter Canvas", true)]
	[PresetPrefabExtension("Ammo Counter Canvas", false)]
	public class AmmoCounterExtension : MixedExtension
	{
		[SerializeField]
		private TMP_Text _targetText;

		[SerializeField]
		private int _digits;

		private string _toStringFormat;

		private Func<DisplayAmmoValues> _fetcher;

		private int _lastTotal = -1;

		private void Start()
		{
			for (int i = 0; i < _digits; i++)
			{
				_toStringFormat += "0";
			}
		}

		private void LateUpdate()
		{
			int total = _fetcher().Total;
			if (total != _lastTotal)
			{
				_lastTotal = total;
				_targetText.text = total.ToString(_toStringFormat);
			}
		}

		public override void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			base.InitViewmodel(viewmodel);
			SetLayer(10);
			_fetcher = () => IDisplayableAmmoProviderModule.GetCombinedDisplayAmmo(viewmodel.ParentFirearm);
		}

		public override void SetupWorldmodel(FirearmWorldmodel worldmodel)
		{
			base.SetupWorldmodel(worldmodel);
			SetLayer(9);
			_fetcher = () => IDisplayableAmmoProviderModule.GetCombinedDisplayAmmo(worldmodel.Identifier);
		}
	}
}

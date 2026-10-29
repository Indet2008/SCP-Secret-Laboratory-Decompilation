using System;
using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin.Generic
{
	[Serializable]
	public abstract class ToggleableSetting : RaSetting<bool>
	{
		public override bool Value
		{
			get
			{
				return base.Value;
			}
			set
			{
				base.Value = value;
				SetButton(value);
			}
		}

		[field: SerializeField]
		public Button RepresentingButton { get; set; }

		public void Toggle()
		{
			Value = !Value;
			Save();
		}

		protected override void OnSave()
		{
			PlayerPrefsSl.Set(Path, Value);
		}

		protected override void OnLoad()
		{
			Value = PlayerPrefsSl.Get(Path, DefaultValue);
		}

		protected virtual void SetButton(bool value)
		{
			// RaSettings can load lazily before the RA controller wakes up; the original never hit that order.
			if (!(RepresentingButton == null) && !(RemoteAdminUIController.Singleton == null))
			{
				SubmenuSelector submenuSelector = RemoteAdminUIController.Singleton.SubmenuSelector;
				RepresentingButton.colors = (value ? submenuSelector.ToggleOn : submenuSelector.ToggleOff);
			}
		}
	}
}

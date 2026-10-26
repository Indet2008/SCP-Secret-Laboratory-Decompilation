using System;
using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin.Generic
{
	[Serializable]
	public abstract class ToggleableSetting : RaSetting<bool>
	{
		// Same green/red as the Round menu lock icons.
		private static readonly Color EnabledColor = new Color(0.2509804f, 1f, 0.39215687f, 1f);

		private static readonly Color DisabledColor = new Color(1f, 0.30588236f, 0.2509804f, 1f);

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
			if (RepresentingButton == null)
			{
				return;
			}
			Color color = (value ? EnabledColor : DisabledColor);
			Outline[] components = RepresentingButton.GetComponents<Outline>();
			foreach (Outline outline in components)
			{
				outline.effectColor = color;
			}
			if (components.Length == 0 && RepresentingButton.targetGraphic != null)
			{
				RepresentingButton.targetGraphic.color = color;
			}
			TMPro.TMP_Text componentInChildren = RepresentingButton.GetComponentInChildren<TMPro.TMP_Text>(includeInactive: true);
			if (componentInChildren != null)
			{
				componentInChildren.color = color;
			}
		}
	}
}

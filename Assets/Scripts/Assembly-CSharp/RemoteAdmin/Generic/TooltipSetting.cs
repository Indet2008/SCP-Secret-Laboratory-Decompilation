using System;
using Tooltips;
using UnityEngine;

namespace RemoteAdmin.Generic
{
	[Serializable]
	public abstract class TooltipSetting : CustomSliderSetting
	{
		public override float Value
		{
			get
			{
				return base.Value;
			}
			set
			{
				base.Value = value;
				ChangeTooltip(value);
			}
		}

		[field: SerializeField]
		public TooltipManager TooltipManager { get; set; }

		protected abstract void ChangeTooltip(float value);
	}
}

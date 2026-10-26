using Mirror;
using RemoteAdmin.Interfaces;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class Scp1576 : StatusEffectBase, ICustomDisplayName
	{
		public string DisplayName => "SCP-1576";

		public bool CanBeDisplayed => true;

		public override EffectClassification Classification => EffectClassification.Technical;

		protected override void OnEffectUpdate()
		{
			base.OnEffectUpdate();
			if (NetworkServer.active)
			{
				base.Intensity = (byte)Mathf.Clamp(base.TimeLeft, 0f, 255f);
			}
		}
	}
}

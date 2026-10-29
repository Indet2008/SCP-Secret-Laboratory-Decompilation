using System;
using CustomRendering;

namespace CustomPlayerEffects
{
	public class FogControl : StatusEffectBase
	{
		public override byte MaxIntensity { get; } = (byte)Enum.GetValues(typeof(FogType)).Length;

		public override EffectClassification Classification => EffectClassification.Technical;

		public void SetFogType(FogType fogType)
		{
			base.Intensity = (byte)(fogType + 1);
		}

		// Client half restored from the client build: forces the fog type for the local/spectated player.
		protected override void IntensityChanged(byte prevState, byte newState)
		{
			base.IntensityChanged(prevState, newState);
			if (newState != 0 && IsPOV && FogController.Singleton != null)
			{
				FogController.Singleton.ForcedFog = (FogType)(newState - 1);
			}
		}

		protected override void Disabled()
		{
			base.Disabled();
			if (IsPOV && FogController.Singleton != null)
			{
				FogController.Singleton.ForcedFog = null;
			}
		}
	}
}

using UnityEngine;

namespace CustomPlayerEffects
{
	public class RainbowTaste : StatusEffectBase, ISpectatorDataPlayerEffect
	{
		private static readonly float[] Multipliers = new float[4] { 1f, 0.6f, 0.4f, 0.35f };

		public override EffectClassification Classification => EffectClassification.Positive;

		public bool GetSpectatorText(out string s)
		{
			s = "Rainbow Taste";
			return base.IsEnabled;
		}

		public static float CurrentMultiplier(ReferenceHub ply)
		{
			byte intensity = ply.playerEffectsController.GetEffect<RainbowTaste>().Intensity;
			return Multipliers[Mathf.Clamp(intensity, 0, Multipliers.Length - 1)];
		}

		public static bool CheckPlayer(ReferenceHub ply)
		{
			return ply.playerEffectsController.GetEffect<RainbowTaste>().Intensity > 0;
		}
	}
}

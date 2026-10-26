namespace CustomPlayerEffects
{
	public class Vitality : StatusEffectBase, ISpectatorDataPlayerEffect
	{
		public override EffectClassification Classification => EffectClassification.Positive;

		public bool GetSpectatorText(out string s)
		{
			s = "Vitality";
			return true;
		}

		public static bool CheckPlayer(ReferenceHub ply)
		{
			if (ply != null)
			{
				return ply.playerEffectsController.GetEffect<Vitality>().IsEnabled;
			}
			return false;
		}
	}
}

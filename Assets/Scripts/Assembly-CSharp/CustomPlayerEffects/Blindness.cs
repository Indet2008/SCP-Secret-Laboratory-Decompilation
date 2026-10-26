using RemoteAdmin.Interfaces;

namespace CustomPlayerEffects
{
	public class Blindness : StatusEffectBase, ICustomDisplayName, ICustomHealableEffect, IHealableEffect, IConflictableEffect
	{
		private const float LerpingSpeed = 10f;

		private const byte MaxHealableIntensity = 100;

		private const byte MinIntensity = 15;

		public override EffectClassification Classification => EffectClassification.Negative;

		public override bool AllowEnabling => !SpawnProtected.CheckPlayer(base.Hub);

		public string DisplayName => "Blindness";

		public bool CanBeDisplayed => true;

		public bool IsHealable(ItemType item)
		{
			if (item == ItemType.SCP500)
			{
				byte intensity = base.Intensity;
				if (intensity <= 100)
				{
					return intensity > 15;
				}
				return false;
			}
			return false;
		}

		public void OnHeal(ItemType item)
		{
			base.Intensity = 15;
		}

		public bool CheckConflicts(StatusEffectBase other)
		{
			if (!(other is Flashed))
			{
				return false;
			}
			other.ServerDisable();
			return true;
		}
	}
}

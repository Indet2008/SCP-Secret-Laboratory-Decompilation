using System.Text;
using PlayerRoles.PlayableScps.Scp079.GUI;
using PlayerRoles.PlayableScps.Scp079.Map;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079
{
	public class Scp079ScannerMenuToggler : Scp079ToggleMenuAbilityBase<Scp079ScannerMenuToggler>, IScp079LevelUpNotifier
	{
		[SerializeField]
		private int _minimalTierIndex;

		public bool IsUnlocked => base.TierManager.AccessTierIndex >= _minimalTierIndex;

		public override ActionName ActivationKey => ActionName.Scp079BreachScanner;

		public override bool IsVisible
		{
			get
			{
				if (IsUnlocked)
				{
					return Scp079ToggleMenuAbilityBase<Scp079MapToggler>.IsOpen;
				}
				return false;
			}
		}

		protected override Scp079HudTranslation OpenTranslation => Scp079HudTranslation.OpenBreachScanner;

		protected override Scp079HudTranslation CloseTranslation => Scp079HudTranslation.CloseBreachScanner;

		public bool WriteLevelUpNotification(StringBuilder sb, int newLevel)
		{
			if (newLevel != _minimalTierIndex)
			{
				return false;
			}
			sb.Append(Translations.Get(Scp079HudTranslation.BreachScannerAvailable));
			return true;
		}

		protected override void Update()
		{
			base.Update();
			Scp079ToggleMenuAbilityBase<Scp079ScannerMenuToggler>.IsOpen &= IsVisible;
		}
	}
}

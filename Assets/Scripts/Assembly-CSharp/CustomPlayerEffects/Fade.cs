using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;

namespace CustomPlayerEffects
{
	public class Fade : StatusEffectBase
	{
		public override EffectClassification Classification => EffectClassification.Positive;

		protected override void Disabled()
		{
			base.Disabled();
			UpdateFade();
		}

		protected void LateUpdate()
		{
			if (base.IsEnabled)
			{
				UpdateFade();
			}
		}

		private void UpdateFade()
		{
			if (!base.IsLocalPlayer && base.Hub.roleManager.CurrentRole is IFpcRole fpcRole)
			{
				CharacterModel characterModelInstance = fpcRole.FpcModule.CharacterModelInstance;
				if (!(characterModelInstance == null))
				{
					characterModelInstance.Fade = 1f - (float)(int)base.Intensity / 255f;
				}
			}
		}
	}
}

using PlayerRoles.FirstPersonControl.Thirdperson;

namespace CustomPlayerEffects
{
	public interface IFootstepEffect
	{
		float ProcessFootstepOverrides(AnimatedCharacterModel model, float dis);
	}
}

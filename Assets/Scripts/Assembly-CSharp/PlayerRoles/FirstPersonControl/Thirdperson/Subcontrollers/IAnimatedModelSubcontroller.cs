namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers
{
	public interface IAnimatedModelSubcontroller
	{
		void Init(AnimatedCharacterModel model, int index);

		void OnReassigned()
		{
		}
	}
}

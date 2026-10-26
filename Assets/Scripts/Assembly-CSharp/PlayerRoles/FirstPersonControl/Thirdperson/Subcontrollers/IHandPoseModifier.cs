namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers
{
	public interface IHandPoseModifier
	{
		HandPoseData ProcessHandPose(HandPoseData data);
	}
}

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers
{
	public interface IRotationRetainer
	{
		float AngleDelta { get; }

		float AngleAbsDiff { get; }

		float RetentionWeight { get; }

		bool IsTurning { get; }
	}
}

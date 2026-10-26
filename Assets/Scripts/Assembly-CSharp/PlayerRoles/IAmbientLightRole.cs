namespace PlayerRoles
{
	public interface IAmbientLightRole
	{
		float AmbientBoost { get; }

		bool ForceBlackAmbient { get; }

		bool InsufficientLight { get; }
	}
}

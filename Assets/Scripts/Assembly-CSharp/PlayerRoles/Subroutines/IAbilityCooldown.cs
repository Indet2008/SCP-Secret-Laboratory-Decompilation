namespace PlayerRoles.Subroutines
{
	public interface IAbilityCooldown
	{
		double InitialTime { get; }

		double NextUse { get; }

		bool IsReady { get; }

		float Remaining { get; }

		float Readiness { get; }
	}
}

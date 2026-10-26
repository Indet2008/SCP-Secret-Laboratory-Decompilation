namespace PlayerRoles
{
	public interface ITeslaControllerRole
	{
		bool CanActivateShock { get; }

		bool IsInIdleRange(TeslaGate teslaGate);
	}
}

namespace PlayerRoles.PlayableScps.Scp096
{
	public static class Scp096StateExtensions
	{
		public static bool IsRageState(this Scp096Role scp096, Scp096RageState state)
		{
			return scp096.StateController.RageState == state;
		}

		public static bool IsAbilityState(this Scp096Role scp096, Scp096AbilityState state)
		{
			return scp096.StateController.AbilityState == state;
		}

		public static void ResetAbilityState(this Scp096Role scp096)
		{
			scp096.StateController.AbilityState = Scp096AbilityState.None;
		}
	}
}

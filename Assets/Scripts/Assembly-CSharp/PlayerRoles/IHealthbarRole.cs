using PlayerStatsSystem;

namespace PlayerRoles
{
	public interface IHealthbarRole
	{
		float MaxHealth { get; }

		PlayerStats TargetStats { get; }
	}
}

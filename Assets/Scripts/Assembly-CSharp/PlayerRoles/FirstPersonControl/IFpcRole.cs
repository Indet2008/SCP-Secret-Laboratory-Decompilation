using PlayerRoles.FirstPersonControl.Spawnpoints;

namespace PlayerRoles.FirstPersonControl
{
	public interface IFpcRole
	{
		FirstPersonMovementModule FpcModule { get; }

		ISpawnpointHandler SpawnpointHandler { get; }
	}
}

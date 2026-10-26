using PlayerRoles.PlayableScps.Scp079.Cameras;
using PlayerRoles.PlayableScps.Scp079.Rewards;
using PlayerRoles.Subroutines;

namespace PlayerRoles.PlayableScps.Scp079
{
	public abstract class Scp079AbilityBase : StandardSubroutine<Scp079Role>
	{
		protected Scp079TierManager TierManager { get; private set; }

		protected Scp079AuxManager AuxManager { get; private set; }

		protected Scp079CurrentCameraSync CurrentCamSync { get; private set; }

		protected Scp079LostSignalHandler LostSignalHandler { get; private set; }

		protected Scp079RewardManager RewardManager { get; private set; }

		protected override void Awake()
		{
			base.Awake();
			SubroutineBase[] allSubroutines = base.CastRole.SubroutineModule.AllSubroutines;
			foreach (SubroutineBase subroutineBase in allSubroutines)
			{
				if (subroutineBase is Scp079TierManager tierManager)
				{
					TierManager = tierManager;
				}
				else if (subroutineBase is Scp079AuxManager auxManager)
				{
					AuxManager = auxManager;
				}
				else if (subroutineBase is Scp079CurrentCameraSync currentCamSync)
				{
					CurrentCamSync = currentCamSync;
				}
				else if (subroutineBase is Scp079LostSignalHandler lostSignalHandler)
				{
					LostSignalHandler = lostSignalHandler;
				}
				else if (subroutineBase is Scp079RewardManager rewardManager)
				{
					RewardManager = rewardManager;
				}
			}
		}
	}
}

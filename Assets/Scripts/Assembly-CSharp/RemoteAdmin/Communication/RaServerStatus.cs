using CustomPlayerEffects;
using GameCore;

namespace RemoteAdmin.Communication
{
	public class RaServerStatus : RaClientDataRequest
	{
		public override int DataId => 7;

		protected override void GatherData()
		{
			AppendData(CastBool(RoundSummary.RoundLock));
			AppendData(CastBool(RoundStart.LobbyLock));
			AppendData(CastBool(AlphaWarheadController.Singleton != null && AlphaWarheadController.Singleton.IsLocked));
			AppendData(CastBool(ServerConsole.FriendlyFire));
			AppendData(CastBool(SpawnProtected.IsProtectionEnabled));
		}
	}
}

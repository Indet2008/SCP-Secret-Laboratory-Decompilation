using InventorySystem.Items.ThrowableProjectiles;
using MapGeneration;
using PlayerRoles.PlayableScps.Scp079.Cameras;

namespace Achievements.Handlers
{
	public class SignalLostHandler : AchievementHandlerBase
	{
		internal override void OnInitialize()
		{
			Scp2176Projectile.OnServerShattered += HandleSignalLostAchievment;
		}

		private void HandleSignalLostAchievment(Scp2176Projectile projectile, RoomIdentifier identifier)
		{
			if (!projectile.PreviousOwner.IsSet)
			{
				return;
			}
			ReferenceHub hub = projectile.PreviousOwner.Hub;
			bool flag = false;
			foreach (Scp079Camera roomCamera in Scp079Camera.GetRoomCameras(identifier))
			{
				if (roomCamera.IsActive)
				{
					flag = true;
					break;
				}
			}
			if (flag)
			{
				AchievementHandlerBase.ServerAchieve(hub.connectionToClient, AchievementName.SignalLost);
			}
		}
	}
}

using System.Text;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public interface IScp079LevelUpNotifier
	{
		bool WriteLevelUpNotification(StringBuilder sb, int newLevel);
	}
}

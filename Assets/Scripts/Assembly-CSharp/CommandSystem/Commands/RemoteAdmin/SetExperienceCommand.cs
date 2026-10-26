using PlayerRoles.PlayableScps.Scp079;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class SetExperienceCommand : Scp079CommandBase
	{
		public override string Command { get; } = "setexperience";

		public override string[] Aliases { get; } = new string[4] { "setexp", "set079exp", "setxp", "exp" };

		public override string Description { get; } = "Sets the experience of the player playing as SCP-079.";

		public override string[] Usage { get; } = new string[2] { "%player%", "New Experience" };

		public override void ApplyChanges(Scp079TierManager manager, int input)
		{
			manager.TotalExp = input;
		}
	}
}

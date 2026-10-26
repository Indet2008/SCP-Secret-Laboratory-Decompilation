using PlayerRoles.PlayableScps.Scp079;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class AddExperienceCommand : Scp079CommandBase
	{
		public override string Command { get; } = "addexperience";

		public override string[] Aliases { get; } = new string[3] { "addexp", "add079exp", "addxp" };

		public override string Description { get; } = "Adds the specified experience of the player playing as SCP-079.";

		public override string[] Usage { get; } = new string[2] { "%player%", "Experience" };

		public override void ApplyChanges(Scp079TierManager manager, int input)
		{
			manager.ServerGrantExperience(input, Scp079HudTranslation.ExpGainAdminCommand);
		}
	}
}

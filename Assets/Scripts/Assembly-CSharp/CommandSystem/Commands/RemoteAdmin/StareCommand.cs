using System;
using PlayerRoles;
using PlayerRoles.PlayableScps.Scp049.Zombies;
using PlayerRoles.PlayableScps.Scp096;
using PlayerRoles.PlayableScps.Scp173;
using RemoteAdmin;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class StareCommand : ICommand
	{
		public string Command { get; } = "stare";

		public string[] Aliases { get; }

		public string Description { get; } = "Forces yourself to be stared at as SCP-173, look at a fake human as 049-2 or enable rage cycle as 096.";

		public string[] Usage { get; } = new string[1] { "Time=Duration" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(new PlayerPermissions[2]
			{
				PlayerPermissions.ForceclassSelf,
				PlayerPermissions.ForceclassWithoutRestrictions
			}, out response))
			{
				return false;
			}
			if (!(sender is PlayerCommandSender playerCommandSender))
			{
				response = "Only players can run this command.";
				return false;
			}
			if (arguments.Count < 1)
			{
				response = "To execute this command provide at least 1 argument!\nUsage: " + arguments.Array[0] + " " + Usage[0];
				return false;
			}
			if (!float.TryParse(arguments.Array[1], out var result))
			{
				response = $"To execute this command provide the duration!\nUsage: {arguments.Array[0]} {Usage}";
				return false;
			}
			PlayerRoleBase currentRole = playerCommandSender.ReferenceHub.roleManager.CurrentRole;
			if (!(currentRole is Scp173Role scp))
			{
				if (!(currentRole is ZombieRole scp2))
				{
					if (currentRole is Scp096Role scp3)
					{
						return ShyStare(scp3, result, out response);
					}
					ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + "'s " + response, ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
					return true;
				}
				return ZombieStare(scp2, result, out response);
			}
			return PeanutStare(scp, result, out response);
		}

		private bool PeanutStare(Scp173Role scp173, float duration, out string response)
		{
			if (!scp173.SubroutineModule.TryGetSubroutine<Scp173ObserversTracker>(out var subroutine))
			{
				response = "SCP-173's observers tracker not found!";
				return false;
			}
			subroutine.SimulatedStare = duration;
			response = "SCP-173 stared at successfully!";
			return true;
		}

		private bool ZombieStare(ZombieRole scp0492, float duration, out string response)
		{
			if (!scp0492.SubroutineModule.TryGetSubroutine<ZombieBloodlustAbility>(out var subroutine))
			{
				response = "SCP-049-2's vision tracker not found!";
				return false;
			}
			subroutine.SimulatedStare = duration;
			response = "SCP-049-2 targeting a fake human successfully!";
			return true;
		}

		private bool ShyStare(Scp096Role scp096, float duration, out string response)
		{
			if (!scp096.SubroutineModule.TryGetSubroutine<Scp096RageCycleAbility>(out var subroutine))
			{
				response = "SCP-096's rage cycle ability not found!";
				return false;
			}
			subroutine.ServerTryEnableInput(duration);
			response = "SCP-096's rage cycle has begun, you can now ENRAGE!";
			return true;
		}
	}
}

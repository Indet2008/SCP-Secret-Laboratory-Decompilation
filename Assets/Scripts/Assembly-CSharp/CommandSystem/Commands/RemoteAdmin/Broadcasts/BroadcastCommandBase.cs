using System;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin.Broadcasts
{
	public abstract class BroadcastCommandBase : ICommand, IUsageProvider
	{
		public abstract string Command { get; }

		public abstract string[] Aliases { get; }

		public abstract string Description { get; }

		public abstract string[] Usage { get; }

		public virtual int MinimumArguments => 2;

		public virtual bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.Broadcasting, out response))
			{
				return false;
			}
			if (arguments.Count < MinimumArguments)
			{
				response = $"To execute this command provide at least {MinimumArguments} arguments!\nUsage: {arguments.Array[0]} {this.DisplayCommandUsage()}";
				return false;
			}
			return OnExecute(arguments, sender, out response);
		}

		public abstract bool OnExecute(ArraySegment<string> arguments, ICommandSender sender, out string response);

		protected bool HasInputFlag(string inputFlag, out Broadcast.BroadcastFlags broadcastFlag, int argumentCount = 0)
		{
			bool num = RAUtils.IsDigit.IsMatch(inputFlag);
			broadcastFlag = Broadcast.BroadcastFlags.Normal;
			if (!num && argumentCount >= MinimumArguments + 1)
			{
				return Enum.TryParse<Broadcast.BroadcastFlags>(inputFlag, ignoreCase: true, out broadcastFlag);
			}
			return false;
		}

		protected bool IsValidDuration(string inputDuration, out ushort time)
		{
			if (ushort.TryParse(inputDuration, out time))
			{
				return time > 0;
			}
			return false;
		}
	}
}

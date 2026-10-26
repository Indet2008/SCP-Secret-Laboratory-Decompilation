using System;
using System.Collections.Generic;
using NetworkManagerUtils.Dummies;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin.Dummies
{
	[CommandHandler(typeof(DummiesCommand))]
	public class ActionDummyCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "action";

		public string[] Aliases { get; }

		public string Description { get; } = "Executes an action on selected dummies.";

		public string[] Usage { get; } = new string[3] { "%player%", "Module", "Action" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.FacilityManagement, out response))
			{
				return false;
			}
			if (arguments.Count < 3)
			{
				response = "You must specify all arguments! (target, module, action)";
				return false;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(arguments, 0, out var _);
			if (list == null)
			{
				response = "An unexpected problem has occurred during PlayerId or name array processing.";
				return false;
			}
			string text = arguments.At(1);
			string text2 = arguments.At(2);
			int num = 0;
			foreach (ReferenceHub item in list)
			{
				if (item == null || !item.IsDummy)
				{
					continue;
				}
				List<DummyAction> list2 = DummyActionCollector.ServerGetActions(item);
				bool flag = false;
				foreach (DummyAction item2 in list2)
				{
					string text3 = item2.Name.Replace(' ', '_');
					if (item2.Action == null)
					{
						flag = text3 == text;
					}
					else if (flag && text3 == text2)
					{
						item2.Action();
						num++;
					}
				}
			}
			response = string.Format("Action requested on {0} dumm{1}", num, (num == 1) ? "y!" : "ies!");
			return true;
		}
	}
}

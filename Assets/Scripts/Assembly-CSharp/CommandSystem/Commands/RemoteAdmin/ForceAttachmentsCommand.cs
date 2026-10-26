using System;
using System.Text;
using InventorySystem.Items.Firearms;
using InventorySystem.Items.Firearms.Attachments;
using NorthwoodLib.Pools;
using RemoteAdmin;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class ForceAttachmentsCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "forceattachments";

		public string[] Aliases { get; } = new string[1] { "forceatt" };

		public string Description { get; } = "Forces certain attachments code on the currently equipped weapon.";

		public string[] Usage { get; } = new string[1] { "Attachments Code (Optional)" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.PlayersManagement, out response))
			{
				return false;
			}
			if (!(sender is PlayerCommandSender))
			{
				response = "Only players can run this command.";
				return false;
			}
			if (!(((PlayerCommandSender)sender).ReferenceHub.inventory.CurInstance is Firearm firearm))
			{
				response = "You are not holding any firearm.";
				return false;
			}
			if (arguments.Count == 0)
			{
				StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
				stringBuilder.Append("\nThe attachments combination ID of the currently held firearm is ");
				stringBuilder.Append(firearm.GetCurrentAttachmentsCode());
				stringBuilder.Append("\n\nAttachment codes, based on their order in different slots:\n");
				uint num = 1u;
				for (int i = 0; i < firearm.Attachments.Length; i++)
				{
					stringBuilder.Append(firearm.Attachments[i].Name);
					stringBuilder.Append(" (");
					if (firearm.Attachments[i].IsEnabled)
					{
						stringBuilder.Append("<color=red>");
						stringBuilder.Append(num);
						stringBuilder.Append("</color>");
					}
					else
					{
						stringBuilder.Append(num);
					}
					stringBuilder.Append(")");
					if (i < firearm.Attachments.Length - 1)
					{
						stringBuilder.Append(", ");
						num *= 2;
					}
				}
				stringBuilder.Append("\n\nRed color indicates currently installed attachments.");
				stringBuilder.Append("\n\nTo change the attachments, use <b><i>forceattachments x</i></b>, where <b><i>x</i></b> is a sum");
				stringBuilder.Append(" of selected attachment codes. The number is later validated, so feel free to experiment - you can't break anything. ");
				stringBuilder.Append("Tip: You can use the plus sign if you don't want to do the math (for example: <i>forceattachments 2+64+1024</i>).");
				response = stringBuilder.ToString();
				StringBuilderPool.Shared.Return(stringBuilder);
				return true;
			}
			string text = RAUtils.FormatArguments(arguments, 0);
			uint result = 0u;
			if (text.Contains('+'))
			{
				string[] array = text.Split('+');
				for (int j = 0; j < array.Length; j++)
				{
					if (uint.TryParse(array[j], out var result2))
					{
						result += result2;
					}
				}
			}
			if (result != 0 || uint.TryParse(text, out result))
			{
				uint num2 = firearm.ValidateAttachmentsCode(result);
				firearm.ApplyAttachmentsCode(num2, reValidate: false);
				firearm.ServerResendAttachmentCode();
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, string.Format("{0} forced attachments code {1} {2} for weapon {3}.", sender.LogName, result, (num2 == result) ? "" : $"(validated: {num2})", Enum.GetName(typeof(ItemType), firearm.ItemTypeId)), ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
				response = ((num2 == result) ? ("Successfully assigned code: " + result) : ("Successfully assigned code: " + result + " (validated: " + num2 + ")"));
				return true;
			}
			response = "Could not parse the code: '" + text + "'";
			return false;
		}
	}
}

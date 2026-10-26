using System;
using System.Linq;
using System.Text;
using Interactables.Interobjects.DoorUtils;
using NorthwoodLib.Pools;
using UnityEngine;

namespace CommandSystem.Commands.RemoteAdmin.Doors
{
	public abstract class BaseDoorCommand : ICommand, IUsageProvider
	{
		public abstract string Command { get; }

		public abstract string[] Aliases { get; }

		public abstract string Description { get; }

		public virtual string[] Usage { get; } = new string[1] { "%door%" };

		public virtual bool AllowNonDamageableTargets => true;

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.FacilityManagement, out response))
			{
				return false;
			}
			if (arguments.Count == 0)
			{
				response = "To execute this command provide at least 1 argument!\nUsage: " + arguments.Array[0] + " " + this.DisplayCommandUsage();
				return false;
			}
			if (string.IsNullOrEmpty(arguments.At(0)))
			{
				response = "Please specify a door first.";
				return false;
			}
			bool flag = false;
			string text = arguments.At(0).ToUpper();
			string[] source = text.Split('.');
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			switch (text)
			{
			case "*":
				stringBuilder.Append(", *");
				break;
			case "!*":
				stringBuilder.Append(", !*");
				break;
			case "**":
				stringBuilder.Append(", **");
				break;
			}
			foreach (DoorVariant allDoor in DoorVariant.AllDoors)
			{
				if (allDoor is INonInteractableDoor { IgnoreRemoteAdmin: not false })
				{
					continue;
				}
				string text2 = string.Empty;
				bool flag2 = allDoor.TryGetComponent<DoorNametagExtension>(out var nt);
				switch (text)
				{
				case "*":
					if (!flag2)
					{
						continue;
					}
					break;
				case "!*":
				{
					if (flag2)
					{
						continue;
					}
					Transform parent = allDoor.transform.parent;
					if (parent != null && parent.TryGetComponent<DoorNametagExtension>(out var _))
					{
						continue;
					}
					break;
				}
				default:
					if (!flag2 || !source.Any((string i) => string.Equals(nt.GetName, i, StringComparison.OrdinalIgnoreCase)))
					{
						continue;
					}
					text2 = nt.GetName;
					break;
				case "**":
					break;
				}
				if (AllowNonDamageableTargets || allDoor is IDamageableDoor)
				{
					OnTargetFound(allDoor);
					if (!string.IsNullOrEmpty(text2))
					{
						stringBuilder.Append(", " + text2);
					}
					flag = true;
				}
			}
			string text3 = StringBuilderPool.Shared.ToStringReturn(stringBuilder);
			if (flag)
			{
				text3 = text3.Substring(2);
				ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " ran " + Command + " on the following door(s): " + text3, ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			}
			response = (flag ? ("Affected the following door(s): " + text3) : ("Can't find any door(s) using \"" + text.Replace(".", ", ") + "\"."));
			return flag;
		}

		protected abstract void OnTargetFound(DoorVariant door);
	}
}

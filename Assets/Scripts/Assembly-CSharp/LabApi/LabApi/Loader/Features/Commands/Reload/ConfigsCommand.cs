namespace LabApi.Loader.Features.Commands.Reload
{
	[global::CommandSystem.CommandHandler(typeof(global::LabApi.Loader.Features.Commands.Reload.ReloadParentCommand))]
	public class ConfigsCommand : global::CommandSystem.ICommand
	{
		public string Command => "configs";

		public string[] Aliases => new string[2] { "c", "cfg" };

		public string Description => "Reloads configs for all LabAPI plugins.";

		public bool Execute(global::System.ArraySegment<string> arguments, global::CommandSystem.ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.ServerConfigs, out response))
			{
				return false;
			}
			int count = global::LabApi.Loader.PluginLoader.Plugins.Count;
			if (count == 0)
			{
				response = "No LabAPI plugins installed to reload configs for.";
				return false;
			}
			global::System.Text.StringBuilder stringBuilder = global::NorthwoodLib.Pools.StringBuilderPool.Shared.Rent();
			stringBuilder.AppendLine(string.Format("Reloading configs for {0} plugin{1}", count, (count == 1) ? string.Empty : "s"));
			int num = 0;
			bool result = true;
			foreach (global::LabApi.Loader.Features.Plugins.Plugin key in global::LabApi.Loader.PluginLoader.Plugins.Keys)
			{
				try
				{
					key.LoadConfigs();
					num++;
				}
				catch (global::System.Exception arg)
				{
					stringBuilder.AppendLine($"Failed to reload configs for plugin {key} with Exception:\n{arg}");
					result = false;
				}
			}
			stringBuilder.AppendLine("Successfully reloaded configs for " + ((num == global::LabApi.Loader.PluginLoader.Plugins.Count) ? "all" : $"{num}/{(global::LabApi.Loader.PluginLoader.Plugins.Count)}") + " plugins.");
			response = stringBuilder.ToString();
			global::NorthwoodLib.Pools.StringBuilderPool.Shared.Return(stringBuilder);
			return result;
		}
	}
}

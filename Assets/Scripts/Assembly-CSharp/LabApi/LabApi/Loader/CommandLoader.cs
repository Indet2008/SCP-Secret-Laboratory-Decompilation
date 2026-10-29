namespace LabApi.Loader
{
	public static class CommandLoader
	{
		private const string LoggerPrefix = "[COMMAND_LOADER]";

		public static global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Collections.Generic.List<global::CommandSystem.CommandHandler>> CommandHandlers { get; } = new global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Collections.Generic.List<global::CommandSystem.CommandHandler>>
		{
			[typeof(global::CommandSystem.GameConsoleCommandHandler)] = new global::System.Collections.Generic.List<global::CommandSystem.CommandHandler>(1) { global::GameCore.Console.ConsoleCommandHandler },
			[typeof(global::CommandSystem.RemoteAdminCommandHandler)] = new global::System.Collections.Generic.List<global::CommandSystem.CommandHandler>(1) { global::RemoteAdmin.CommandProcessor.RemoteAdminCommandHandler },
			[typeof(global::CommandSystem.ClientCommandHandler)] = new global::System.Collections.Generic.List<global::CommandSystem.CommandHandler>(1) { global::RemoteAdmin.QueryProcessor.DotCommandHandler }
		};

		public static global::System.Collections.Generic.Dictionary<global::LabApi.Loader.Features.Plugins.Plugin, global::System.Collections.Generic.IEnumerable<global::CommandSystem.ICommand>> RegisteredCommands { get; } = new global::System.Collections.Generic.Dictionary<global::LabApi.Loader.Features.Plugins.Plugin, global::System.Collections.Generic.IEnumerable<global::CommandSystem.ICommand>>();

		public static global::System.Collections.Generic.IEnumerable<global::CommandSystem.ICommand>? LabApiCommands { get; private set; }

		public static void RegisterCommands(this global::LabApi.Loader.Features.Plugins.Plugin plugin)
		{
			if (!global::LabApi.Loader.Features.Misc.AssemblyUtils.TryGetLoadedAssembly(plugin, out global::System.Reflection.Assembly assembly))
			{
				assembly = plugin.GetType().Assembly;
			}
			global::System.Collections.Generic.IEnumerable<global::CommandSystem.ICommand> value = global::System.Linq.Enumerable.ToArray(RegisterCommands(assembly, plugin.Name));
			RegisteredCommands.Add(plugin, value);
		}

		public static global::System.Collections.Generic.IEnumerable<global::CommandSystem.ICommand> RegisterCommands(global::System.Reflection.Assembly assembly, string logName = "")
		{
			global::System.Type[] types = assembly.GetTypes();
			global::System.Type[] array = types;
			foreach (global::System.Type type in array)
			{
				foreach (global::CommandSystem.ICommand item in RegisterCommands(type, logName))
				{
					yield return item;
				}
			}
		}

		public static global::System.Collections.Generic.IEnumerable<global::CommandSystem.ICommand> RegisterCommands(global::System.Type type, string logName = "")
		{
			if (!typeof(global::CommandSystem.ICommand).IsAssignableFrom(type))
			{
				yield break;
			}
			foreach (global::System.Reflection.CustomAttributeData customAttributesDatum in type.GetCustomAttributesData())
			{
				if (customAttributesDatum.AttributeType != typeof(global::CommandSystem.CommandHandlerAttribute))
				{
					continue;
				}
				global::System.Type commandHandlerType = (global::System.Type)customAttributesDatum.ConstructorArguments[0].Value;
				if (!CommandHandlers.ContainsKey(commandHandlerType) && typeof(ParentCommand).IsAssignableFrom(commandHandlerType))
				{
					foreach (global::CommandSystem.ICommand item in RegisterCommands(commandHandlerType))
					{
						yield return item;
					}
				}
				if (TryRegisterCommand(type, commandHandlerType, out global::CommandSystem.ICommand command, logName))
				{
					yield return command;
				}
			}
		}

		public static bool TryRegisterCommand(global::System.Type commandType, global::System.Type commandHandlerType, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::CommandSystem.ICommand? command, string logName)
		{
			command = null;
			if (!CommandHandlers.TryGetValue(commandHandlerType, out global::System.Collections.Generic.List<global::CommandSystem.CommandHandler> value))
			{
				global::LabApi.Features.Console.Logger.Error(string.Format("{0} Unable to register command '{1}' from '{2}'. CommandHandler '{3}' not found.", "[COMMAND_LOADER]", commandType.Name, logName, commandHandlerType));
				return false;
			}
			try
			{
				if (!(global::System.Activator.CreateInstance(commandType) is global::CommandSystem.ICommand command2))
				{
					global::LabApi.Features.Console.Logger.Error("[COMMAND_LOADER] Unable to register command '" + commandType.Name + "' from '" + logName + "'. Couldn't create an instance of the command.");
					return false;
				}
				command = command2;
			}
			catch (global::System.Exception message)
			{
				global::LabApi.Features.Console.Logger.Error("[COMMAND_LOADER] Unable to register command '" + commandType.Name + "' from '" + logName + "'. Couldn't create an instance of the command.");
				global::LabApi.Features.Console.Logger.Error(message);
				throw;
			}
			foreach (global::CommandSystem.CommandHandler item in value)
			{
				if (!TryRegisterCommand(command, item, logName))
				{
					return false;
				}
			}
			return true;
		}

		public static bool TryRegisterCommand(global::CommandSystem.ICommand command, global::CommandSystem.CommandHandler commandHandler, string logName)
		{
			try
			{
				if (global::System.Linq.Enumerable.Any(commandHandler.AllCommands, (global::CommandSystem.ICommand x) => string.Equals(x.Command, command.Command, global::System.StringComparison.OrdinalIgnoreCase)))
				{
					return true;
				}
				commandHandler.RegisterCommand(command);
				if (!(command is ParentCommand item))
				{
					return true;
				}
				global::System.Type type = command.GetType();
				if (!CommandHandlers.ContainsKey(type))
				{
					CommandHandlers[type] = new global::System.Collections.Generic.List<global::CommandSystem.CommandHandler>();
				}
				if (!CommandHandlers[type].Contains(item))
				{
					CommandHandlers[type].Add(item);
				}
				return true;
			}
			catch (global::System.Exception message)
			{
				if (!string.IsNullOrWhiteSpace(command.Command))
				{
					global::LabApi.Features.Console.Logger.Error("[COMMAND_LOADER] Unable to register command '" + command.Command + "' from '" + logName + "'. A command with the same name or aliases has already been registered!");
					return false;
				}
				global::LabApi.Features.Console.Logger.Error("[COMMAND_LOADER] Unable to register command '" + command.Command + "' from '" + logName + "'.");
				global::LabApi.Features.Console.Logger.Error(message);
				return false;
			}
		}

		public static void UnregisterCommands(this global::LabApi.Loader.Features.Plugins.Plugin plugin)
		{
			if (!RegisteredCommands.TryGetValue(plugin, out global::System.Collections.Generic.IEnumerable<global::CommandSystem.ICommand> value))
			{
				return;
			}
			foreach (global::CommandSystem.ICommand item in value)
			{
				UnregisterCommand(item);
			}
			RegisteredCommands.Remove(plugin);
		}

		public static void UnregisterCommand(global::CommandSystem.ICommand command)
		{
			foreach (global::System.Collections.Generic.List<global::CommandSystem.CommandHandler> value in CommandHandlers.Values)
			{
				foreach (global::CommandSystem.CommandHandler item in value)
				{
					if (global::System.Linq.Enumerable.Contains<global::CommandSystem.ICommand>(item.AllCommands, command))
					{
						item.UnregisterCommand(command);
					}
				}
			}
			if (command is ParentCommand parentCommand)
			{
				global::System.Type type = parentCommand.GetType();
				CommandHandlers.Remove(type);
			}
		}

		internal static void RegisterCommands()
		{
			LabApiCommands = global::System.Linq.Enumerable.ToArray(RegisterCommands(global::System.Reflection.Assembly.GetExecutingAssembly(), "LabApi"));
		}
	}
}

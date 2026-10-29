namespace LabApi.Events
{
	public static class EventManager
	{
		public static void InvokeEvent(this global::LabApi.Events.LabEventHandler? eventHandler)
		{
			if (eventHandler == null)
			{
				return;
			}
			global::System.Delegate[] invocationList = eventHandler.GetInvocationList();
			foreach (global::System.Delegate obj in invocationList)
			{
				try
				{
					if (obj is global::LabApi.Events.LabEventHandler labEventHandler)
					{
						labEventHandler();
					}
				}
				catch (global::System.Exception exception)
				{
					global::LabApi.Features.Console.Logger.Error(FormatErrorMessage(eventHandler, exception));
				}
			}
		}

		public static void InvokeEvent<TEventArgs>(this global::LabApi.Events.LabEventHandler<TEventArgs>? eventHandler, TEventArgs args) where TEventArgs : global::System.EventArgs
		{
			if (eventHandler == null)
			{
				return;
			}
			global::System.Delegate[] invocationList = eventHandler.GetInvocationList();
			foreach (global::System.Delegate obj in invocationList)
			{
				try
				{
					if (obj is global::LabApi.Events.LabEventHandler<TEventArgs> labEventHandler)
					{
						labEventHandler(args);
					}
				}
				catch (global::System.Exception exception)
				{
					global::LabApi.Features.Console.Logger.Error(FormatErrorMessage(eventHandler, exception));
				}
			}
		}

		public static string FormatToString(this global::LabApi.Events.LabEventHandler eventHandler)
		{
			return eventHandler.Method.Name;
		}

		public static string FormatToString<TEventArgs>(this global::LabApi.Events.LabEventHandler<TEventArgs> eventHandler, TEventArgs args) where TEventArgs : global::System.EventArgs
		{
			global::System.Text.StringBuilder stringBuilder = global::NorthwoodLib.Pools.StringBuilderPool.Shared.Rent(eventHandler.Method.Name + ":");
			global::System.Reflection.PropertyInfo[] properties = typeof(TEventArgs).GetProperties();
			if (properties.Length != 0)
			{
				stringBuilder.Append("\n");
			}
			global::System.Reflection.PropertyInfo[] array = properties;
			foreach (global::System.Reflection.PropertyInfo propertyInfo in array)
			{
				try
				{
					object value = propertyInfo.GetValue(args);
					stringBuilder.AppendLine("\t- " + propertyInfo.Name + ": " + value.ToString());
				}
				catch (global::System.NotSupportedException)
				{
					stringBuilder.AppendLine("\t- " + propertyInfo.Name + ": <Value get by reflection not supported>");
				}
				catch (global::System.Exception ex2)
				{
					stringBuilder.AppendLine("\t- " + propertyInfo.Name + ": <Exception: " + ex2.GetType().Name + ">");
				}
			}
			return global::NorthwoodLib.Pools.StringBuilderPool.Shared.ToStringReturn(stringBuilder);
		}

		public static string FormatErrorMessage(global::System.Delegate eventHandler, global::System.Exception exception)
		{
			if (eventHandler.Target == null)
			{
				return $"'{exception.GetType().Name}' occurred while invoking '{eventHandler.Method.Name}' on '{eventHandler.Method.DeclaringType}': '{exception.Message}', stack trace:\n{exception.StackTrace}";
			}
			return "'" + exception.GetType().Name + "' occurred while invoking '" + eventHandler.Method.Name + "' on '" + eventHandler.Target.GetType().FullName + "': '" + exception.Message + "', stack trace:\n" + exception.StackTrace;
		}
	}
}

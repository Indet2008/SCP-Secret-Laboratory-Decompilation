namespace CommandSystem
{
	[global::System.AttributeUsage(global::System.AttributeTargets.Class, AllowMultiple = true)]
	public class CommandHandlerAttribute : global::System.Attribute
	{
		public CommandHandlerAttribute(global::System.Type type)
		{
		}
	}
}

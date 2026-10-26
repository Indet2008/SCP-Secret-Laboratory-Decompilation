namespace Mirror
{
	[global::System.AttributeUsage(global::System.AttributeTargets.Method)]
	public class CommandAttribute : global::System.Attribute
	{
		public int channel;

		public bool requiresAuthority = true;
	}
}

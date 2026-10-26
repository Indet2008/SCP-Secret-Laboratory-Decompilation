namespace Mirror
{
	[global::System.AttributeUsage(global::System.AttributeTargets.Method)]
	public class TargetRpcAttribute : global::System.Attribute
	{
		public int channel;
	}
}

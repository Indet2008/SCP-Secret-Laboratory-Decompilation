namespace Mirror
{
	[global::System.AttributeUsage(global::System.AttributeTargets.Method)]
	public class ClientRpcAttribute : global::System.Attribute
	{
		public int channel;

		public bool includeOwner = true;
	}
}

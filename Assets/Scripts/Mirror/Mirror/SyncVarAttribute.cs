namespace Mirror
{
	[global::System.AttributeUsage(global::System.AttributeTargets.Field)]
	public class SyncVarAttribute : global::UnityEngine.PropertyAttribute
	{
		public string hook;
	}
}

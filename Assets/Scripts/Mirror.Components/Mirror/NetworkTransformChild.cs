namespace Mirror
{
	[global::UnityEngine.AddComponentMenu("")]
	[global::System.Obsolete("NetworkTransformChild is not needed anymore. The .target is now exposed in NetworkTransform itself. Note you can open the Inspector in debug view and replace the source script instead of reassigning everything.")]
	public class NetworkTransformChild : global::Mirror.NetworkTransform
	{
		public override bool Weaved()
		{
			return true;
		}
	}
}

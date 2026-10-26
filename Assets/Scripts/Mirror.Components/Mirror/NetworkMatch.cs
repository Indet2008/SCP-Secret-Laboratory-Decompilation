namespace Mirror
{
	[global::UnityEngine.DisallowMultipleComponent]
	[global::UnityEngine.AddComponentMenu("Network/ Interest Management/ Match/Network Match")]
	[global::UnityEngine.HelpURL("https://mirror-networking.gitbook.io/docs/guides/interest-management")]
	public class NetworkMatch : global::Mirror.NetworkBehaviour
	{
		public global::System.Guid matchId;

		public override bool Weaved()
		{
			return true;
		}
	}
}

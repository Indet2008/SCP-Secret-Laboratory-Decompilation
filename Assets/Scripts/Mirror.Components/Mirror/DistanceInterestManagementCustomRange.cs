namespace Mirror
{
	[global::UnityEngine.DisallowMultipleComponent]
	[global::UnityEngine.AddComponentMenu("Network/ Interest Management/ Distance/Distance Custom Range")]
	[global::UnityEngine.HelpURL("https://mirror-networking.gitbook.io/docs/guides/interest-management")]
	public class DistanceInterestManagementCustomRange : global::Mirror.NetworkBehaviour
	{
		[global::UnityEngine.Tooltip("The maximum range that objects will be visible at.")]
		public int visRange = 100;

		public override bool Weaved()
		{
			return true;
		}
	}
}

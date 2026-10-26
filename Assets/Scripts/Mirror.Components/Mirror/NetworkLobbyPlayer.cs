namespace Mirror
{
	[global::UnityEngine.DisallowMultipleComponent]
	[global::UnityEngine.AddComponentMenu("Network/Network Lobby Player")]
	[global::UnityEngine.HelpURL("https://mirror-networking.gitbook.io/docs/components/network-room-player")]
	[global::System.Obsolete("Use / inherit from NetworkRoomPlayer instead")]
	public class NetworkLobbyPlayer : global::Mirror.NetworkRoomPlayer
	{
		public override bool Weaved()
		{
			return true;
		}
	}
}

namespace Mirror
{
	[global::UnityEngine.DisallowMultipleComponent]
	[global::UnityEngine.AddComponentMenu("Network/Network Manager HUD")]
	[global::UnityEngine.RequireComponent(typeof(global::Mirror.NetworkManager))]
	[global::UnityEngine.HelpURL("https://mirror-networking.gitbook.io/docs/components/network-manager-hud")]
	public class NetworkManagerHUD : global::UnityEngine.MonoBehaviour
	{
		private global::Mirror.NetworkManager manager;

		public int offsetX;

		public int offsetY;

		private void Awake()
		{
			manager = GetComponent<global::Mirror.NetworkManager>();
		}
	}
}

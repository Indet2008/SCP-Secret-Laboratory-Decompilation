namespace Mirror
{
	[global::UnityEngine.DisallowMultipleComponent]
	[global::UnityEngine.AddComponentMenu("Network/Network Start Position")]
	[global::UnityEngine.HelpURL("https://mirror-networking.gitbook.io/docs/components/network-start-position")]
	public class NetworkStartPosition : global::UnityEngine.MonoBehaviour
	{
		public void Awake()
		{
			global::Mirror.NetworkManager.RegisterStartPosition(base.transform);
		}

		public void OnDestroy()
		{
			global::Mirror.NetworkManager.UnRegisterStartPosition(base.transform);
		}
	}
}

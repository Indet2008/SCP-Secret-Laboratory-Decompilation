using System.Collections;
using System.ComponentModel;
using System.Net;
using UnityEngine;

namespace Mirror.LiteNetLib4Mirror
{
	[RequireComponent(typeof(NetworkManager))]
	[RequireComponent(typeof(NetworkManagerHUD))]
	[RequireComponent(typeof(LiteNetLib4MirrorTransport))]
	[RequireComponent(typeof(LiteNetLib4MirrorDiscovery))]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public class NetworkDiscoveryHUD : MonoBehaviour
	{
		[SerializeField]
		public float discoveryInterval = 1f;

		private NetworkManagerHUD _managerHud;

		private bool _noDiscovering = true;

		private void Awake()
		{
			_managerHud = GetComponent<NetworkManagerHUD>();
		}

		private IEnumerator StartDiscovery()
		{
			_noDiscovering = false;
			LiteNetLib4MirrorDiscovery.InitializeFinder();
			LiteNetLib4MirrorDiscovery.Singleton.onDiscoveryResponse.AddListener(OnClientDiscoveryResponse);
			while (!_noDiscovering)
			{
				LiteNetLib4MirrorDiscovery.SendDiscoveryRequest("NetworkManagerHUD");
				yield return new WaitForSeconds(discoveryInterval);
			}
			LiteNetLib4MirrorDiscovery.Singleton.onDiscoveryResponse.RemoveListener(OnClientDiscoveryResponse);
			LiteNetLib4MirrorDiscovery.StopDiscovery();
		}

		private void OnClientDiscoveryResponse(IPEndPoint endpoint, string text)
		{
			string text2 = endpoint.Address.ToString();
			NetworkManager.singleton.networkAddress = text2;
			NetworkManager.singleton.maxConnections = 2;
			LiteNetLib4MirrorTransport.Singleton.clientAddress = text2;
			LiteNetLib4MirrorTransport.Singleton.port = (ushort)endpoint.Port;
			LiteNetLib4MirrorTransport.Singleton.maxConnections = 2;
			NetworkManager.singleton.StartClient();
			_noDiscovering = true;
		}
	}
}

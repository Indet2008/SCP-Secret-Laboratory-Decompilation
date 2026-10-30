using UnityEngine;
using UnityEngine.SceneManagement;

public class PlayButton : MonoBehaviour
{
	public global::UnityEngine.UI.Text Motd;

	public global::UnityEngine.UI.Text Players;

	public uint AccountID;

	public uint ServerID;

	public string Ip;

	public string Port;

	public string InfoType;

	public static int maxPlayers = 20;

	private void Start()
	{
		if (SceneManager.GetActiveScene().name == "Facility")
		{
			Object.Destroy(base.gameObject);
		}
	}

	private static void SetMaxPlayers(string s)
	{
		string[] array = s.Split('/');
		if (array.Length > 1 && int.TryParse(array[1], out var result))
		{
			maxPlayers = result;
		}
		else
		{
			maxPlayers = 20;
		}
	}

	public void Click()
	{
		if (CrashDetector.singleton != null && CrashDetector.singleton.Show())
		{
			return;
		}
		CustomNetworkManager customNetworkManager = Object.FindObjectOfType<CustomNetworkManager>();
		if (Mirror.NetworkClient.active)
		{
			customNetworkManager.StopClient();
		}
		customNetworkManager.networkAddress = Ip;
		if (ushort.TryParse(Port, out var result))
		{
			Mirror.LiteNetLib4Mirror.LiteNetLib4MirrorTransport.Singleton.port = result;
		}
		else
		{
			GameCore.Console.AddLog("Wrong server port, parsing to 7777!", new Color(1f, 0f, 0f, 1f));
			Mirror.LiteNetLib4Mirror.LiteNetLib4MirrorTransport.Singleton.port = 7777;
		}
		GameCore.Console.AddLog("Connecting to " + Ip + ":" + Port + "!", new Color(0f, 1f, 0f, 1f));
		Mirror.LiteNetLib4Mirror.LiteNetLib4MirrorTransport.Singleton.reconnectDelay = 600;
		Mirror.LiteNetLib4Mirror.LiteNetLib4MirrorTransport.Singleton.maxConnectAttempts = 3;
		customNetworkManager.StartClient();
		SetMaxPlayers(Players.text);
	}
}

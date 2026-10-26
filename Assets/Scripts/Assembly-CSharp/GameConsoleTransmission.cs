using System;
using GameCore;
using Mirror;
using Security;
using UnityEngine;

public class GameConsoleTransmission : NetworkBehaviour
{
	private ReferenceHub _hub;

	private RateLimit _cmdRateLimit;

	private void Start()
	{
		_hub = ReferenceHub.GetHub(this);
		_cmdRateLimit = _hub.playerRateLimitHandler.RateLimits[1];
		if (base.isLocalPlayer)
		{
			EncryptedChannelManager.ReplaceClientHandler(EncryptedChannelManager.EncryptedChannel.GameConsole, ClientHandleMessage);
			if (NetworkServer.active)
			{
				EncryptedChannelManager.ReplaceServerHandler(EncryptedChannelManager.EncryptedChannel.GameConsole, ServerHandleCommand);
			}
		}
	}

	[Server]
	public void SendToClient(string text, string color)
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void GameConsoleTransmission::SendToClient(System.String,System.String)' called when server was not active");
		}
		else
		{
			_hub?.encryptedChannelManager.TrySendMessageToClient(color + "#" + text, EncryptedChannelManager.EncryptedChannel.GameConsole);
		}
	}

	private static void ClientHandleMessage(EncryptedChannelManager.EncryptedMessage content, EncryptedChannelManager.SecurityLevel securityLevel)
	{
		string text = content.ToString();
		int num = text.IndexOf("#", StringComparison.Ordinal);
		string text2 = text.Remove(num);
		text = text.Remove(0, num + 1);
		GameCore.Console.AddLog(((securityLevel == EncryptedChannelManager.SecurityLevel.EncryptedAndAuthenticated) ? "[FROM SERVER] " : "[UNENCRYPTED FROM SERVER] ") + text, ProcessColor(text2));
	}

	[Client]
	internal void SendToServer(string command)
	{
		if (!NetworkClient.active)
		{
			Debug.LogWarning("[Client] function 'System.Void GameConsoleTransmission::SendToServer(System.String)' called when client was not active");
		}
		else
		{
			_hub.encryptedChannelManager.TrySendMessageToServer(command, EncryptedChannelManager.EncryptedChannel.GameConsole);
		}
	}

	private static void ServerHandleCommand(ReferenceHub hub, EncryptedChannelManager.EncryptedMessage content, EncryptedChannelManager.SecurityLevel securityLevel)
	{
		if (hub.gameConsoleTransmission._cmdRateLimit.CanExecute())
		{
			hub.queryProcessor.ProcessGameConsoleQuery(content.ToString());
		}
	}

	private static Color ProcessColor(string name)
	{
		return name switch
		{
			"red" => Color.red, 
			"cyan" => Color.cyan, 
			"blue" => Color.blue, 
			"magenta" => Color.magenta, 
			"white" => Color.white, 
			"green" => Color.green, 
			"yellow" => Color.yellow, 
			"black" => Color.black, 
			_ => Color.grey, 
		};
	}

	public override bool Weaved()
	{
		return true;
	}
}

using System;
using System.Buffers.Binary;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using Cryptography;
using GameCore;
using Mirror;
using Org.BouncyCastle.Crypto;
using Org.BouncyCastle.Crypto.Agreement;
using Org.BouncyCastle.Security;
using UnityEngine;

public class EncryptedChannelManager : NetworkBehaviour
{
	public delegate void EncryptedMessageClientHandler(EncryptedMessage message, SecurityLevel level);

	public delegate void EncryptedMessageServerHandler(ReferenceHub hub, EncryptedMessage message, SecurityLevel level);

	public enum EncryptedChannel : byte
	{
		RemoteAdmin = 0,
		GameConsole = 1,
		AdminChat = 2
	}

	public enum SecurityLevel : byte
	{
		Unsecured = 0,
		EncryptedAndAuthenticated = 1
	}

	public readonly struct EncryptedMessage
	{
		public readonly EncryptedChannel Channel;

		public readonly byte[] Content;

		internal readonly uint Counter;

		private const int HeaderSize = 5;

		public int GetLength => Content.Length + 5;

		public EncryptedMessage(EncryptedChannel channel, string content, uint counter)
		{
			Channel = channel;
			Content = Utf8.GetBytes(content);
			Counter = counter;
		}

		public EncryptedMessage(EncryptedChannel channel, byte[] content, uint counter)
		{
			Channel = channel;
			Content = content;
			Counter = counter;
		}

		public override string ToString()
		{
			return Utf8.GetString(Content);
		}

		internal void Serialize(byte[] array)
		{
			array[0] = (byte)Channel;
			BinaryPrimitives.WriteUInt32BigEndian(new Span<byte>(array, 1, 4), Counter);
			Array.Copy(Content, 0, array, 5, Content.Length);
		}

		internal static EncryptedMessage Deserialize(byte[] array)
		{
			byte[] array2 = new byte[array.Length - 5];
			Array.Copy(array, 5, array2, 0, array.Length - 5);
			return new EncryptedMessage((EncryptedChannel)array[0], array2, BinaryPrimitives.ReadUInt32BigEndian(new ReadOnlySpan<byte>(array, 1, 4)));
		}
	}

	internal readonly struct EncryptedMessageOutside : NetworkMessage
	{
		internal readonly SecurityLevel Level;

		internal readonly byte[] Data;

		internal EncryptedMessageOutside(SecurityLevel level, byte[] data)
		{
			Level = level;
			Data = data;
		}
	}

	internal byte[] EncryptionKey;

	internal static bool CryptographyDebug;

	[SyncVar(hook = "ReceivedSaltHook")]
	[SerializeField]
	[HideInInspector]
	internal string ServerRandom;

	private uint _txCounter;

	private uint _rxCounter;

	private ECDHBasicAgreement _exchange;

	private static readonly SecureRandom SecureRandom = new SecureRandom();

	private static readonly Dictionary<EncryptedChannel, EncryptedMessageClientHandler> ClientChannelHandlers = new Dictionary<EncryptedChannel, EncryptedMessageClientHandler>();

	private static readonly Dictionary<EncryptedChannel, EncryptedMessageServerHandler> ServerChannelHandlers = new Dictionary<EncryptedChannel, EncryptedMessageServerHandler>();

	private static readonly Dictionary<EncryptedChannel, SecurityLevel> RequiredSecurityLevels = new Dictionary<EncryptedChannel, SecurityLevel>
	{
		{
			EncryptedChannel.RemoteAdmin,
			SecurityLevel.EncryptedAndAuthenticated
		},
		{
			EncryptedChannel.GameConsole,
			SecurityLevel.Unsecured
		},
		{
			EncryptedChannel.AdminChat,
			SecurityLevel.EncryptedAndAuthenticated
		}
	};

	internal AsymmetricCipherKeyPair EcdhKeys { get; private set; }

	public string NetworkServerRandom
	{
		get
		{
			return ServerRandom;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref ServerRandom, 1uL, ReceivedSaltHook);
		}
	}

	internal void PrepareExchange()
	{
		if (_exchange == null)
		{
			EcdhKeys = ECDH.GenerateKeys();
			_exchange = ECDH.Init(EcdhKeys);
		}
	}

	internal void ServerProcessExchange(string publicKey)
	{
		if (EncryptionKey == null)
		{
			if (CryptographyDebug)
			{
				ServerConsole.AddLog("Received ECDH parameters from " + (ReferenceHub.TryGetHub(base.gameObject, out var hub) ? hub.LoggedNameFromRefHub() : "(unknown)") + ".");
			}
			EncryptionKey = ECDH.DeriveKey(_exchange, ECDSA.PublicKeyFromString(publicKey));
		}
	}

	public static void ReplaceServerHandler(EncryptedChannel channel, EncryptedMessageServerHandler handler)
	{
		ServerChannelHandlers[channel] = handler;
	}

	public static void ReplaceClientHandler(EncryptedChannel channel, EncryptedMessageClientHandler clientHandler)
	{
		ClientChannelHandlers[channel] = clientHandler;
	}

	private void Start()
	{
		if (!base.isLocalPlayer)
		{
			return;
		}
		if (NetworkServer.active)
		{
			if (string.IsNullOrEmpty(ServerRandom))
			{
				NetworkServerRandom = RandomGenerator.GetStringSecure(32);
				ServerConsole.AddLog("Generated random salt: " + ServerRandom);
			}
			NetworkServer.ReplaceHandler<EncryptedMessageOutside>(ServerReceivePackedMessage);
		}
		NetworkClient.ReplaceHandler<EncryptedMessageOutside>(ClientReceivePackedMessage);
	}

	private void ReceivedSaltHook(string p, string n)
	{
		if (!NetworkServer.active && n != null)
		{
			GameCore.Console.AddLog("Received random salt from game server: " + n, Color.gray);
		}
	}

	private static void ServerReceivePackedMessage(NetworkConnection conn, EncryptedMessageOutside packed)
	{
		if (!NetworkServer.active || !ReferenceHub.TryGetHub(conn, out var hub) || !hub.encryptedChannelManager.TryUnpack(packed, out var msg, out var level, NetworkServer.active && conn.identity.isLocalPlayer))
		{
			return;
		}
		if (!ServerChannelHandlers.TryGetValue(msg.Channel, out var value))
		{
			GameCore.Console.AddLog($"No handler is registered for encrypted channel {msg.Channel} (server).", Color.red);
			return;
		}
		try
		{
			value(hub, msg, level);
		}
		catch (Exception ex)
		{
			GameCore.Console.AddLog($"Exception while handling encrypted message on channel {msg.Channel} (server, running a handler). Exception: {ex.Message}", Color.red);
			GameCore.Console.AddLog(ex.StackTrace, Color.red);
		}
	}

	private static void ClientReceivePackedMessage(EncryptedMessageOutside packed)
	{
		if (!ReferenceHub.TryGetLocalHub(out var hub) || !hub.encryptedChannelManager.TryUnpack(packed, out var msg, out var level, NetworkServer.active))
		{
			return;
		}
		if (!ClientChannelHandlers.TryGetValue(msg.Channel, out var value))
		{
			GameCore.Console.AddLog($"No handler is registered for encrypted channel {msg.Channel} (client).", Color.red);
			return;
		}
		try
		{
			value(msg, level);
		}
		catch (Exception ex)
		{
			GameCore.Console.AddLog($"Exception while handling encrypted message on channel {msg.Channel} (client, running a handler). Exception: {ex.Message}", Color.red);
			GameCore.Console.AddLog(ex.StackTrace, Color.red);
		}
	}

	public bool TrySendMessageToServer(string content, EncryptedChannel channel)
	{
		if (_txCounter == uint.MaxValue)
		{
			_txCounter = 0u;
		}
		if (!TryPack(new EncryptedMessage(channel, content, ++_txCounter), out var packed, NetworkServer.active))
		{
			return false;
		}
		NetworkClient.Send(packed);
		return true;
	}

	public bool TrySendMessageToServer(byte[] content, EncryptedChannel channel)
	{
		if (_txCounter == uint.MaxValue)
		{
			_txCounter = 0u;
		}
		if (!TryPack(new EncryptedMessage(channel, content, ++_txCounter), out var packed, NetworkServer.active))
		{
			return false;
		}
		NetworkClient.Send(packed);
		return true;
	}

	public static bool TrySendMessageToClient(ReferenceHub hub, string content, EncryptedChannel channel)
	{
		return hub.encryptedChannelManager.TrySendMessageToClient(content, channel);
	}

	public static bool TrySendMessageToClient(ReferenceHub hub, byte[] content, EncryptedChannel channel)
	{
		return hub.encryptedChannelManager.TrySendMessageToClient(content, channel);
	}

	[Server]
	public bool TrySendMessageToClient(string content, EncryptedChannel channel)
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Boolean EncryptedChannelManager::TrySendMessageToClient(System.String,EncryptedChannelManager/EncryptedChannel)' called when server was not active");
			return default;
		}
		if (_txCounter == uint.MaxValue)
		{
			_txCounter = 0u;
		}
		if (!TryPack(new EncryptedMessage(channel, content, ++_txCounter), out var packed, base.isLocalPlayer))
		{
			return false;
		}
		base.connectionToClient.Send(packed);
		return true;
	}

	[Server]
	public bool TrySendMessageToClient(byte[] content, EncryptedChannel channel)
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Boolean EncryptedChannelManager::TrySendMessageToClient(System.Byte[],EncryptedChannelManager/EncryptedChannel)' called when server was not active");
			return default;
		}
		if (_txCounter == uint.MaxValue)
		{
			_txCounter = 0u;
		}
		if (!TryPack(new EncryptedMessage(channel, content, ++_txCounter), out var packed, base.isLocalPlayer))
		{
			return false;
		}
		base.connectionToClient.Send(packed);
		return true;
	}

	private bool TryPack(EncryptedMessage msg, out EncryptedMessageOutside packed, bool localClient = false)
	{
		bool flag = EncryptionKey != null && !localClient;
		if (!localClient && RequiredSecurityLevels[msg.Channel] == SecurityLevel.EncryptedAndAuthenticated && !flag)
		{
			GameCore.Console.AddLog($"Failed to send encrypted message to {msg.Channel} channel. Encryption key is not available.", Color.red);
			packed = default;
			return false;
		}
		byte[] array = new byte[msg.GetLength];
		msg.Serialize(array);
		if (!flag)
		{
			packed = new EncryptedMessageOutside(SecurityLevel.Unsecured, array);
			return true;
		}
		packed = new EncryptedMessageOutside(SecurityLevel.EncryptedAndAuthenticated, AES.AesGcmEncrypt(array, EncryptionKey, SecureRandom));
		return true;
	}

	private bool TryUnpack(EncryptedMessageOutside packed, out EncryptedMessage msg, out SecurityLevel level, bool localClient)
	{
		level = packed.Level;
		bool flag = packed.Level == SecurityLevel.EncryptedAndAuthenticated;
		if (flag && EncryptionKey == null)
		{
			GameCore.Console.AddLog("Failed to decrypt received message. Encryption key is not available.", Color.red);
			msg = default;
			return false;
		}
		if (!flag)
		{
			msg = EncryptedMessage.Deserialize(packed.Data);
			if (!localClient && RequiredSecurityLevels[msg.Channel] == SecurityLevel.EncryptedAndAuthenticated)
			{
				GameCore.Console.AddLog($"Message on channel {msg.Channel} was sent without encryption. Discarding message!", Color.red);
				msg = default;
				return false;
			}
			return true;
		}
		try
		{
			msg = EncryptedMessage.Deserialize(AES.AesGcmDecrypt(packed.Data, EncryptionKey));
		}
		catch (Exception ex)
		{
			GameCore.Console.AddLog("Failed to decrypt received message. Exception: " + ex.Message, Color.red);
			GameCore.Console.AddLog(ex.StackTrace, Color.red);
			msg = default;
			return false;
		}
		if (_rxCounter == uint.MaxValue)
		{
			_rxCounter = 0u;
		}
		if (msg.Counter <= _rxCounter)
		{
			GameCore.Console.AddLog($"Received message with counter {msg.Counter}, which is lower or equal to last received message counter {_rxCounter}. Discarding message!", Color.red);
			msg = default;
			return false;
		}
		_rxCounter = msg.Counter;
		return true;
	}

	public override bool Weaved()
	{
		return true;
	}

	protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
	{
		base.SerializeSyncVars(writer, forceAll);
		if (forceAll)
		{
			writer.WriteString(ServerRandom);
			return;
		}
		writer.WriteULong(base.syncVarDirtyBits);
		if ((base.syncVarDirtyBits & 1L) != 0L)
		{
			writer.WriteString(ServerRandom);
		}
	}

	protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
	{
		base.DeserializeSyncVars(reader, initialState);
		if (initialState)
		{
			GeneratedSyncVarDeserialize(ref ServerRandom, ReceivedSaltHook, reader.ReadString());
			return;
		}
		long num = (long)reader.ReadULong();
		if ((num & 1L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref ServerRandom, ReceivedSaltHook, reader.ReadString());
		}
	}
}

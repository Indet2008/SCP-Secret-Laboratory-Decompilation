using System;
using System.Buffers;
using System.Buffers.Binary;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using Cryptography;
using Org.BouncyCastle.Crypto.Modes;

namespace Query
{
	internal class QueryUser : IDisposable
	{
		private readonly IPEndPoint _remoteEndpoint;

		private readonly TcpClient _c;

		private readonly NetworkStream _s;

		private readonly QueryServer _server;

		private readonly Stopwatch _lastRx;

		private readonly QueryCommandSender _printer;

		private readonly ushort _timeoutThreshold;

		private readonly object _writeLock = new object();

		private bool _authenticated;

		private bool _disconnect;

		private ushort _lengthToRead;

		private ushort _clientMaxSize;

		private uint _rxCounter;

		private uint _txCounter;

		private byte[] _authChallenge = new byte[24];

		internal QueryHandshake.ClientFlags ClientFlags;

		internal ulong QueryPermissions;

		internal byte QueryKickPower;

		internal string SenderID;

		internal bool Connected
		{
			get
			{
				if (_c.Connected && _s.CanRead && _s.CanWrite)
				{
					return _lastRx.ElapsedMilliseconds < _timeoutThreshold;
				}
				return false;
			}
		}

		internal QueryUser(QueryServer s, TcpClient c)
		{
			_c = c;
			_server = s;
			_s = c.GetStream();
			c.NoDelay = true;
			_s.ReadTimeout = 150;
			_s.WriteTimeout = 150;
			_remoteEndpoint = (IPEndPoint)c.Client.RemoteEndPoint;
			_timeoutThreshold = QueryServer.TimeoutThreshold;
			SenderID = $"Query ({_remoteEndpoint})";
			_printer = new QueryCommandSender(this);
			_server.Random.NextBytes(_authChallenge);
			_lastRx = new Stopwatch();
			_lastRx.Start();
		}

		internal void Receive()
		{
			try
			{
				if (_disconnect)
				{
					Send("Closing connection...", QueryMessage.ClientReceivedContentType.QueryMessage);
					DisconnectInternal();
				}
				else if (!ReceiveInternal())
				{
					DisconnectInternal(serverShutdown: false, force: true);
				}
			}
			catch (Exception ex)
			{
				ServerConsole.AddLog($"An exception occured when processing query client {_remoteEndpoint}: {ex.Message}\n{ex.StackTrace}");
				try
				{
					DisconnectInternal(serverShutdown: false, force: true);
				}
				catch (Exception ex2)
				{
					ServerConsole.AddLog($"An exception occured when disconnecting query client {_remoteEndpoint}: {ex2.Message}\n{ex2.StackTrace}");
				}
			}
		}

		private bool ReceiveInternal()
		{
			if (!Connected)
			{
				return false;
			}
			if (_lengthToRead == 0)
			{
				if (_c.Available < 2)
				{
					return true;
				}
				if (_s.Read(_server.RxBuffer, 0, 2) != 2)
				{
					ServerConsole.AddLog($"Query connection from {_remoteEndpoint} disconnected (can't read length bytes).");
					return false;
				}
				_lengthToRead = BinaryPrimitives.ReadUInt16BigEndian(_server.RxBuffer);
				if (_lengthToRead > _server.RxBuffer.Length)
				{
					ServerConsole.AddLog($"Query connection from {_remoteEndpoint} disconnected (packet too large, limit set in gameplay config).");
					Send($"Query input can't exceed {_server.RxBuffer.Length} bytes (limit set in config).", QueryMessage.ClientReceivedContentType.QueryMessage);
					return false;
				}
			}
			if (_c.Available < _lengthToRead)
			{
				return true;
			}
			if (_s.Read(_server.RxBuffer, 0, _lengthToRead) != _lengthToRead)
			{
				ServerConsole.AddLog($"Query connection from {_remoteEndpoint} disconnected (can't read length bytes).");
				return false;
			}
			AES.ReadNonce(_server.RxNonceBuffer, _server.RxBuffer);
			GcmBlockCipher cipher = AES.AesGcmDecryptInit(_server.RxNonceBuffer, _server.PasswordHash, _lengthToRead, out var outputSize);
			if (_server.RxDecryptionBuffer.Length < outputSize)
			{
				ServerConsole.AddLog($"Query connection from {_remoteEndpoint} disconnected (data to decrypt too large, limit set in gameplay config).");
				Send($"Query decrypted data size can't exceed {_server.RxBuffer.Length} bytes (limit set in config).", QueryMessage.ClientReceivedContentType.QueryMessage);
				return false;
			}
			try
			{
				AES.AesGcmDecrypt(cipher, _server.RxBuffer, _server.RxDecryptionBuffer, 0, _lengthToRead);
			}
			catch (Exception ex)
			{
				if (_authenticated)
				{
					ServerConsole.AddLog($"Query connection from {_remoteEndpoint} disconnected (can't decrypt data): {ex.Message}");
					ServerLogs.AddLog(ServerLogs.Modules.Networking, $"Query message from {_remoteEndpoint} can't be decrypted", ServerLogs.ServerLogType.Query);
				}
				else
				{
					ServerConsole.AddLog($"Query connection from {_remoteEndpoint} disconnected (can't decrypt handshake, likely invalid password was used)): {ex.Message}");
					ServerLogs.AddLog(ServerLogs.Modules.Networking, $"Query handshake from {_remoteEndpoint} can't be decrypted (likely invalid password was used).", ServerLogs.ServerLogType.Query);
				}
				Send("Decryption failed!", QueryMessage.ClientReceivedContentType.QueryMessage);
				return false;
			}
			finally
			{
				_lengthToRead = 0;
				_lastRx.Restart();
			}
			if (_authenticated)
			{
				return HandleMessage(outputSize);
			}
			return HandleHandshake(outputSize);
		}

		private bool HandleMessage(int outputSize)
		{
			QueryMessage qm = QueryMessage.Deserialize(new ReadOnlySpan<byte>(_server.RxDecryptionBuffer, 0, outputSize));
			if (!qm.Validate(_rxCounter++, QueryServer.MaximumTimeDifference))
			{
				ServerConsole.AddLog($"Query message from {_remoteEndpoint} failed validation - invalid time, timezone (on server or client) or a reply attack.");
				ServerLogs.AddLog(ServerLogs.Modules.Networking, $"Query message from {_remoteEndpoint} failed validation (invalid timestamp).", ServerLogs.ServerLogType.Query);
				Send("Message failed validation!", QueryMessage.ClientReceivedContentType.QueryMessage);
				return false;
			}
			try
			{
				if (qm.QueryContentType == 0)
				{
					MainThreadDispatcher.Dispatch(() =>
					{
						ServerConsole.EnterCommand(qm.ToString(), _printer);
					}, MainThreadDispatcher.DispatchTime.FixedUpdate);
				}
				else
				{
					Send("Unknown query message content type!", QueryMessage.ClientReceivedContentType.CommandException);
				}
			}
			catch (Exception ex)
			{
				ServerConsole.AddLog($"Error during processing query command from {_remoteEndpoint}: {ex.Message}\n{ex.StackTrace}");
				Send("Error during processing your command. Check server console for more info.", QueryMessage.ClientReceivedContentType.CommandException);
			}
			return true;
		}

		private bool HandleHandshake(int outputSize)
		{
			QueryHandshake queryHandshake = QueryHandshake.Deserialize(new ReadOnlySpan<byte>(_server.RxDecryptionBuffer, 0, outputSize), toServer: false);
			if (!queryHandshake.Validate(QueryServer.MaximumTimeDifference))
			{
				ServerConsole.AddLog($"Query handshake from {_remoteEndpoint} failed validation - invalid time or timezone (on server or client).");
				ServerLogs.AddLog(ServerLogs.Modules.Networking, $"Query client {_remoteEndpoint} failed authentication (invalid timestamp).", ServerLogs.ServerLogType.Query);
				Send("Message failed validation - invalid timestamp!", QueryMessage.ClientReceivedContentType.QueryMessage);
				return false;
			}
			if (!queryHandshake.AuthChallenge.SequenceEqual(_authChallenge))
			{
				ServerConsole.AddLog($"Query handshake from {_remoteEndpoint} failed validation - invalid auth challenge.");
				ServerLogs.AddLog(ServerLogs.Modules.Networking, $"Query client {_remoteEndpoint} failed authentication (invalid auth challenge).", ServerLogs.ServerLogType.Query);
				Send("Message failed validation - invalid auth challenge!", QueryMessage.ClientReceivedContentType.QueryMessage);
				return false;
			}
			ServerConsole.AddLog($"Query client {_remoteEndpoint} has successfully authenticated.");
			ServerLogs.AddLog(ServerLogs.Modules.Networking, $"Query client {_remoteEndpoint} has successfully authenticated.", ServerLogs.ServerLogType.Query);
			_authenticated = true;
			_authChallenge = null;
			_clientMaxSize = queryHandshake.MaxPacketSize;
			QueryPermissions = QueryServer.QueryPermissions & queryHandshake.Permissions;
			QueryKickPower = ((QueryServer.QueryKickPower < queryHandshake.KickPower) ? QueryServer.QueryKickPower : queryHandshake.KickPower);
			if (queryHandshake.Username != null)
			{
				SenderID = $"{queryHandshake.Username} ({_remoteEndpoint})";
			}
			ClientFlags = queryHandshake.Flags;
			Send("Authentication successful!", QueryMessage.ClientReceivedContentType.QueryMessage);
			if (ClientFlags.HasFlagFast(QueryHandshake.ClientFlags.SubscribeServerConsole))
			{
				if (PermissionsHandler.IsPermitted(QueryPermissions, PlayerPermissions.ServerLogLiveFeed) && PermissionsHandler.IsPermitted(QueryPermissions, PlayerPermissions.ServerConsoleCommands))
				{
					ServerConsole.ConsoleOutputs.TryAdd(SenderID, _printer);
					Send("You have been subscribed to server console output.", QueryMessage.ClientReceivedContentType.QueryMessage);
				}
				else
				{
					Send("You don't have permissions to subscribe to server console output!", QueryMessage.ClientReceivedContentType.QueryMessage);
				}
			}
			if (ClientFlags.HasFlagFast(QueryHandshake.ClientFlags.SubscribeServerLogs))
			{
				if (PermissionsHandler.IsPermitted(QueryPermissions, PlayerPermissions.ServerLogLiveFeed))
				{
					ServerLogs.LiveLogOutput.TryAdd(SenderID, _printer);
					Send("You have been subscribed to live server logs.", QueryMessage.ClientReceivedContentType.QueryMessage);
				}
				else
				{
					Send("You don't have permissions to subscribe to live server logs!", QueryMessage.ClientReceivedContentType.QueryMessage);
				}
			}
			return true;
		}

		internal bool SendHandshake()
		{
			int num = new QueryHandshake(_server.BufferLength, _authChallenge, QueryHandshake.ClientFlags.None, ulong.MaxValue, byte.MaxValue, null, _timeoutThreshold).Serialize(new Span<byte>(_server.RxBuffer, 2, _server.BufferLength - 2), toServer: false);
			BinaryPrimitives.WriteUInt16BigEndian(_server.RxBuffer, (ushort)num);
			if (SendRaw(_server.RxBuffer, 0, num + 2, addLength: false))
			{
				return true;
			}
			DisconnectInternal(serverShutdown: false, force: true);
			return false;
		}

		internal void Send(string msg, QueryMessage.ClientReceivedContentType contentType)
		{
			if (!string.IsNullOrWhiteSpace(msg))
			{
				if (!_authenticated)
				{
					SendRaw(msg);
				}
				else
				{
					Send(new QueryMessage(msg, ++_txCounter, (byte)contentType));
				}
			}
		}

		internal void Send(byte[] msg, QueryMessage.ClientReceivedContentType contentType)
		{
			if (msg.Length != 0)
			{
				if (!_authenticated)
				{
					SendRaw(msg, addLength: true);
				}
				else
				{
					Send(new QueryMessage(msg, ++_txCounter, (byte)contentType));
				}
			}
		}

		private void Send(QueryMessage qm)
		{
			byte[] array = ArrayPool<byte>.Shared.Rent(qm.SerializedSize);
			byte[] array2 = null;
			byte[] array3 = ArrayPool<byte>.Shared.Rent(32);
			try
			{
				int dataLength = qm.Serialize(array);
				AES.GenerateNonce(array3, _server.Random);
				GcmBlockCipher cipher = AES.AesGcmEncryptInit(dataLength, _server.PasswordHash, array3, out var outputSize);
				int num = outputSize + 2;
				if (num > _clientMaxSize)
				{
					ServerConsole.AddLog($"Query message to {_remoteEndpoint} exceeds client's max size ({num} > {_clientMaxSize}).", ConsoleColor.Yellow);
					_txCounter--;
					return;
				}
				array2 = ArrayPool<byte>.Shared.Rent(num);
				BinaryPrimitives.WriteUInt16BigEndian(array2, (ushort)outputSize);
				AES.AesGcmEncrypt(cipher, array3, array, 0, dataLength, array2, 2);
				if (!SendRaw(array2, 0, num, addLength: false))
				{
					_txCounter--;
				}
			}
			catch (Exception ex)
			{
				_txCounter--;
				ServerConsole.AddLog($"Can't send query response (string) to {_remoteEndpoint}: {ex.Message}\n" + ex.StackTrace, ConsoleColor.Yellow);
			}
			finally
			{
				if (array2 != null)
				{
					ArrayPool<byte>.Shared.Return(array2);
				}
				ArrayPool<byte>.Shared.Return(array);
				ArrayPool<byte>.Shared.Return(array3);
			}
		}

		private bool SendRaw(string msg, bool addLength = true)
		{
			return SendRaw(Utf8.GetBytes(msg), addLength);
		}

		private bool SendRaw(byte[] msg, bool addLength)
		{
			return SendRaw(msg, 0, msg.Length, addLength);
		}

		private bool SendRaw(byte[] msg, int offset, int len, bool addLength)
		{
			try
			{
				if (addLength)
				{
					byte[] array = ArrayPool<byte>.Shared.Rent(len - offset + 2);
					try
					{
						BinaryPrimitives.WriteUInt16BigEndian(array, (ushort)(len - offset));
						Array.Copy(msg, offset, array, 2, len);
						lock (_writeLock)
						{
							_s.Write(msg, offset, len);
						}
					}
					finally
					{
						ArrayPool<byte>.Shared.Return(array);
					}
					return true;
				}
				lock (_writeLock)
				{
					_s.Write(msg, offset, len);
				}
				return true;
			}
			catch (Exception ex)
			{
				ServerConsole.AddLog($"Can't send query response (byte[]) to {_remoteEndpoint}: {ex.Message}\n" + ex.StackTrace);
				return false;
			}
		}

		public void Disconnect()
		{
			_disconnect = true;
		}

		internal void DisconnectInternal(bool serverShutdown = false, bool force = false)
		{
			try
			{
				if (force)
				{
					_c.Client.LingerState = new LingerOption(enable: true, 0);
				}
				if (serverShutdown)
				{
					Send("Server is shutting down...", QueryMessage.ClientReceivedContentType.QueryMessage);
				}
			}
			catch (Exception ex)
			{
				ServerConsole.AddLog($"Error closing query connection from {_remoteEndpoint}: {ex.Message}\n{ex.StackTrace}");
			}
			Dispose();
		}

		public override string ToString()
		{
			if (!_authenticated)
			{
				return SenderID + " [UNAUTHENTICATED]";
			}
			return SenderID;
		}

		public void Dispose()
		{
			try
			{
				_s?.Dispose();
			}
			catch (Exception ex)
			{
				ServerConsole.AddLog($"Error disposing query socket connection from {_remoteEndpoint}: {ex.Message}\n{ex.StackTrace}");
			}
			try
			{
				if (_server.Users.Contains(this))
				{
					_server.Users.Remove(this);
				}
			}
			catch (Exception ex2)
			{
				ServerConsole.AddLog("Error removing query user from list: " + ex2.Message + "\n" + ex2.StackTrace);
			}
			IOutput value;
			try
			{
				ServerConsole.ConsoleOutputs.TryRemove(SenderID, out value);
			}
			catch (Exception ex3)
			{
				ServerConsole.AddLog("Error removing query user from console outputs: " + ex3.Message + "\n" + ex3.StackTrace);
			}
			try
			{
				ServerLogs.LiveLogOutput.TryRemove(SenderID, out value);
			}
			catch (Exception ex4)
			{
				ServerConsole.AddLog("Error removing query user from live server log outputs: " + ex4.Message + "\n" + ex4.StackTrace);
			}
		}
	}
}

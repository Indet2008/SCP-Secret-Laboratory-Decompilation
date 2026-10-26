using System;
using System.Buffers;
using System.Collections.Concurrent;
using System.Net;
using System.Net.Sockets;
using System.Runtime.InteropServices;
using System.Threading;
using UnityEngine;

namespace ServerOutput
{
	public class TcpConsole : IServerOutput, IDisposable
	{
		public readonly int SpecifiedReceiveBufferSize;

		public readonly int SpecifiedSendBufferSize;

		public const int DefaultReceiveBufferSize = 25000;

		public const int DefaultSendBufferSize = 200000;

		private bool _disposing;

		private readonly ushort _port;

		private readonly int _maxTextLogSize;

		private readonly TcpClient _client;

		private NetworkStream _stream;

		private readonly Thread _receiveThread;

		private readonly Thread _queueThread;

		private readonly ConcurrentQueue<IOutputEntry> _prompterQueue = new ConcurrentQueue<IOutputEntry>();

		public int ReceiveBufferSize => _client.ReceiveBufferSize;

		public int SendBufferSize => _client.SendBufferSize;

		public TcpConsole(ushort port, int receiveBufferSize = 25000, int sendBufferSize = 200000)
		{
			_client = new TcpClient();
			_client.NoDelay = true;
			_receiveThread = new Thread(Receive)
			{
				Priority = System.Threading.ThreadPriority.Lowest,
				IsBackground = true,
				Name = "Dedicated server console input"
			};
			_queueThread = new Thread(Send)
			{
				Priority = System.Threading.ThreadPriority.Lowest,
				IsBackground = true,
				Name = "Dedicated server console output"
			};
			_port = port;
			if (receiveBufferSize <= 100)
			{
				receiveBufferSize = 25000;
			}
			if (sendBufferSize <= 350)
			{
				sendBufferSize = 200000;
			}
			SpecifiedReceiveBufferSize = receiveBufferSize;
			SpecifiedSendBufferSize = sendBufferSize;
			_client.ReceiveBufferSize = receiveBufferSize;
			_client.SendBufferSize = sendBufferSize;
			_maxTextLogSize = sendBufferSize - 5;
		}

		public void Start()
		{
			_client.Connect(new IPEndPoint(IPAddress.Loopback, _port));
			_stream = _client.GetStream();
			_queueThread.Start();
			_receiveThread.Start();
		}

		public void Dispose()
		{
			_disposing = true;
			try
			{
				if (_receiveThread.IsAlive)
				{
					_receiveThread.Abort();
				}
			}
			catch
			{
			}
			try
			{
				if (_queueThread.IsAlive)
				{
					_queueThread.Abort();
				}
			}
			catch
			{
			}
			_stream?.Dispose();
			_client.Dispose();
		}

		private void Receive()
		{
			byte[] array = new byte[4];
			while (!_disposing)
			{
				try
				{
					int num = _stream.Read(array, 0, 4);
					if (num != 4)
					{
						ServerConsole.AddLog($"[TcpConsole] Received header length is NOT {4}! Received data amount: {num}.", ConsoleColor.Red);
						continue;
					}
					int num2 = MemoryMarshal.Cast<byte, int>((Span<byte>)array)[0];
					while (_client.Available < num2)
					{
						Thread.Sleep(20);
					}
					byte[] array2 = ArrayPool<byte>.Shared.Rent(num2);
					num = _stream.Read(array2, 0, num2);
					if (num != num2)
					{
						ServerConsole.AddLog($"[TcpConsole] Received data length is NOT {num2}! Received data amount: {num}.", ConsoleColor.Red);
						continue;
					}
					string item = Utf8.GetString(array2, 0, num2);
					ArrayPool<byte>.Shared.Return(array2);
					ServerConsole.PrompterQueue.Enqueue(item);
				}
				catch (Exception ex)
				{
					AddLog("[TcpClient] Receive exception: " + ex.Message);
					AddLog("[TcpClient] " + ex.StackTrace);
					Debug.LogException(ex);
				}
			}
		}

		public void AddLog(string text, ConsoleColor color)
		{
			if (!string.IsNullOrWhiteSpace(text))
			{
				while (text.Length > _maxTextLogSize)
				{
					_prompterQueue.Enqueue(new TextOutputEntry(text.Substring(0, _maxTextLogSize), color));
					text = text.Substring(_maxTextLogSize);
				}
				_prompterQueue.Enqueue(new TextOutputEntry(text, color));
			}
		}

		public void AddLog(string text)
		{
			AddLog(text, ConsoleColor.Gray);
		}

		public void AddOutput(IOutputEntry entry)
		{
			if (entry.GetBytesLength() > SpecifiedSendBufferSize)
			{
				throw new Exception("Output size is greater than TCP Console Specified TX Buffer Size!");
			}
			_prompterQueue.Enqueue(entry);
		}

		private void Send()
		{
			while (!_disposing)
			{
				if (_prompterQueue.Count == 0)
				{
					Thread.Sleep(25);
					continue;
				}
				try
				{
					if (_prompterQueue.TryDequeue(out var result))
					{
						byte[] buffer = ArrayPool<byte>.Shared.Rent(result.GetBytesLength());
						result.GetBytes(ref buffer, out var length);
						_stream.Write(buffer, 0, length);
						ArrayPool<byte>.Shared.Return(buffer);
					}
				}
				catch (Exception ex)
				{
					AddLog("[TcpClient] Send exception: " + ex.Message);
					AddLog("[TcpClient] " + ex.StackTrace);
					Debug.LogException(ex);
				}
			}
		}
	}
}

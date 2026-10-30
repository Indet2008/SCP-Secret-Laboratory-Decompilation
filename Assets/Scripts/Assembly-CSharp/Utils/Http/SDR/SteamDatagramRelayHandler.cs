using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using MEC;
using Steamworks;
using Steamworks.Data;
using UnityEngine;

namespace Utils.Http.SDR
{
	public class SteamDatagramRelayHandler : MonoBehaviour, IConnectionManager
	{
		private const int MaxFragmentSize = 65536;

		private const int FragmentHeaderSize = 12;

		private const int FragmentTimeout = 1000;

		private const long CentralServerSteamId = 85568392935779951L;

		private const int CentralServerVirtualPort = 36547;

		private const int MaxFailures = 2;

		private static bool _sdrInUse;

		private static bool _sdrUnusable;

		private static readonly Queue<SDRHttpRequest> _pendingRequests = new Queue<SDRHttpRequest>();

		private FragmentedPacket _currentPacket;

		private ConcurrentQueue<byte[]> _sendQueue;

		private Stopwatch _sendTimer;

		private Action<int, string> _onMessage;

		private static readonly System.Random _random = new System.Random();

		private SDRHttpRequest _currentRequest;

		private IPAddress _clientAddress;

		private int _totalfails;

		internal ConnectionManager Manager;

		public static bool CanUseSDR
		{
			get
			{
				try
				{
					if (!SteamClient.IsLoggedOn || CentralAuth.CentralAuthManager.Platform != GameCore.DistributionPlatform.Steam)
					{
						return false;
					}
					return !_sdrUnusable;
				}
				catch
				{
					return false;
				}
			}
		}

		public static bool ShouldUseSDR(string url)
		{
			string value = string.Join(".", new Uri(url).Host.Split('.').TakeLast(2));
			if (!CanUseSDR || !_sdrInUse)
			{
				return false;
			}
			return CentralServer.AllowedDomains.Contains(value);
		}

		public void Start()
		{
			_sendQueue = new ConcurrentQueue<byte[]>();
			_sendTimer = Stopwatch.StartNew();
			SteamNetworkingSockets.OnConnectionStatusChanged += OnConnectionStatusChanged;
			HttpQuery.OnException += OnException;
		}

		public static void QueueRequest(string url, string method, string content = "", string contentType = "", Action<int, string> onComplete = null, bool log = true)
		{
			_pendingRequests.Enqueue(new SDRHttpRequest
			{
				Url = url,
				Method = method,
				Payload = content,
				ContentType = contentType,
				OnComplete = onComplete,
				Log = log,
				RequestId = _random.Next()
			});
		}

		public static void QueueRequest(string url, string method, byte[] content, string contentType = "", Action<int, string> onComplete = null, bool log = true)
		{
			_pendingRequests.Enqueue(new SDRHttpRequest
			{
				Url = url,
				Method = method,
				Payload = Convert.ToBase64String(content),
				Base64 = true,
				ContentType = contentType,
				OnComplete = onComplete,
				Log = log,
				RequestId = _random.Next()
			});
		}

		public void OnConnecting(ConnectionInfo info)
		{
		}

		public void OnConnected(ConnectionInfo info)
		{
		}

		public void OnDisconnected(ConnectionInfo info)
		{
		}

		public void Update()
		{
			if (_currentPacket != null && _currentPacket.LastReceived.AddMilliseconds(1000.0) < DateTime.UtcNow)
			{
				_currentRequest?.OnComplete?.Invoke(-1, "(Local) Fragment timeout.");
				_currentPacket = null;
				if (Manager != null && Manager.Connected)
				{
					Manager.Connection.Close(linger: false, 0, "Fragment timeout.");
				}
			}
			if (_currentRequest == null && _pendingRequests.Count > 0)
			{
				_currentRequest = _pendingRequests.Dequeue();
				Timing.RunCoroutine(PrepareRequest());
			}
			if (Manager == null || !Manager.Connected)
			{
				return;
			}
			if (_sendQueue.Count > 0 && _sendTimer.ElapsedMilliseconds > 200 && _sendQueue.TryDequeue(out var result))
			{
				_sendTimer.Restart();
				Result result2 = Manager.Connection.SendMessage(result, SendType.Reliable);
				DebugLog(string.Format("Sent fragment queue item ({0} bytes) with status {1}, {2} remaining.", result.Length, result2, _sendQueue.Count), UnityEngine.Color.gray);
			}
			Manager.Receive();
		}

		public void OnMessage(IntPtr data, int size, long messageNum, long recvTime, int channel)
		{
			byte[] array = new byte[size];
			Marshal.Copy(data, array, 0, size);
			if (array.Length < 12)
			{
				_currentRequest?.OnComplete?.Invoke(-1, "(Local) Invalid fragment header.");
				return;
			}
			int fragmentId = BitConverter.ToInt32(array, 0);
			int num = BitConverter.ToInt32(array, 4);
			int num2 = BitConverter.ToInt32(array, 8);
			if (num2 <= 0 || num < 0 || num >= num2)
			{
				_currentRequest?.OnComplete?.Invoke(-1, "(Local) Invalid fragment header.");
				return;
			}
			if (_currentPacket == null || _currentPacket.FragmentId != fragmentId)
			{
				_currentPacket = new FragmentedPacket
				{
					FragmentId = fragmentId,
					TotalFragments = num2,
					Data = new byte[num2][],
					Received = new bool[num2]
				};
			}
			if (_currentPacket.Received[num])
			{
				_currentRequest?.OnComplete?.Invoke(-1, "(Local) Duplicate fragment received.");
				return;
			}
			DebugLog(string.Format("Received fragment {0} of {1} ({2} bytes).", num + 1, num2, size), UnityEngine.Color.gray);
			_currentPacket.Data[num] = array.Skip(12).ToArray();
			_currentPacket.Received[num] = true;
			_currentPacket.FragmentCount++;
			_currentPacket.Size += size - 12;
			_currentPacket.LastReceived = DateTime.UtcNow;
			if (!_currentPacket.IsComplete)
			{
				return;
			}
			byte[] array2 = new byte[_currentPacket.Size];
			int num3 = 0;
			for (int i = 0; i < _currentPacket.TotalFragments; i++)
			{
				_currentPacket.Data[i].CopyTo(array2, num3);
				num3 += _currentPacket.Data[i].Length;
			}
			int offset = 0;
			int arg = ReadInt32(array2, ref offset);
			string arg2 = ReadString(array2, ref offset);
			_currentPacket = null;
			SDRHttpRequest currentRequest = _currentRequest;
			_currentRequest = null;
			if (Manager != null && Manager.Connected)
			{
				Manager.Connection.Close(linger: false, 0, "Request completed.");
			}
			currentRequest?.OnComplete?.Invoke(arg, arg2);
		}

		private void OnException(Exception obj)
		{
			if (!CanUseSDR || _sdrInUse || obj.Message.IndexOf("HTTP result", StringComparison.Ordinal) >= 0)
			{
				return;
			}
			DebugLog("Switching to SDR due to exception in normal HTTP.", UnityEngine.Color.yellow);
			_sdrInUse = true;
			new Thread(GameCore.Console.RefreshPublicKey)
			{
				Name = "Public key refreshing",
				IsBackground = true,
				Priority = System.Threading.ThreadPriority.BelowNormal
			}.Start();
			MainThreadDispatcher.Dispatch(delegate
			{
				CentralServer.UpdateUrl();
			});
		}

		private void OnConnectionStatusChanged(Connection connection, ConnectionInfo info)
		{
			DebugLog(string.Format("SDR Connection({0}) status changed to {1} - {2}", connection.Id, info.State, info.EndReason), UnityEngine.Color.gray);
		}

		private IEnumerator<float> TryResolveIpAddress()
		{
			bool done = false;
			ThreadPool.QueueUserWorkItem(delegate
			{
				try
				{
					SteamServer.Init(700330u, new SteamServerInit("SCP: Secret Laboratory", "SCP: Secret Laboratory")
					{
						GamePort = 0,
						QueryPort = 0
					}, asyncCallbacks: false);
					SteamServer.AdvertiseServer = false;
					Stopwatch stopwatch = Stopwatch.StartNew();
					while (SteamServer.PublicIp == null && stopwatch.Elapsed.TotalSeconds < 10.0)
					{
						Thread.Sleep(100);
					}
					_clientAddress = SteamServer.PublicIp;
					SteamServer.Shutdown();
				}
				catch (Exception value)
				{
					Console.WriteLine(value);
				}
				done = true;
			});
			while (!done)
			{
				yield return Timing.WaitForSeconds(0.1f);
			}
		}

		private IEnumerator<float> PrepareRequest()
		{
			if (_currentRequest == null)
			{
				yield break;
			}
			int requestId = _currentRequest.RequestId;
			if (_clientAddress == null)
			{
				yield return Timing.WaitUntilDone(Timing.RunCoroutine(TryResolveIpAddress()));
			}
			if (_currentRequest == null || _currentRequest.RequestId != requestId)
			{
				_currentRequest?.OnComplete?.Invoke(-1, "(Local) Connection closed prematurely.");
				yield break;
			}
			if (Manager != null && Manager.Connected)
			{
				Manager.Connection.Close(linger: false, 0, "New request started.");
			}
			Manager = SteamNetworkingSockets.ConnectRelay<ConnectionManager>(85568392935779951uL, 36547);
			Manager.Interface = this;
			Stopwatch stopwatch = Stopwatch.StartNew();
			while (!Manager.Connected && stopwatch.Elapsed.TotalSeconds < 10.0)
			{
				yield return Timing.WaitForSeconds(0.1f);
			}
			if (!Manager.Connected)
			{
				_currentRequest?.OnComplete?.Invoke(-1, "(Local) Failed to connect to central server through SDR.");
				_currentRequest = null;
				HandleFailure();
				yield break;
			}
			DebugLog("Connected to central server through SDR.", UnityEngine.Color.green);
			_totalfails = 0;
			_currentPacket = null;
			SDRHttpRequest currentRequest = _currentRequest;
			SendRequest(currentRequest.Url, currentRequest.Method, currentRequest.Base64, currentRequest.ContentType, currentRequest.Payload, currentRequest.OnComplete);
			stopwatch.Restart();
			while (_currentRequest == currentRequest && stopwatch.Elapsed.TotalSeconds < 30.0)
			{
				yield return Timing.WaitForSeconds(0.1f);
			}
			if (_currentRequest == currentRequest)
			{
				currentRequest.OnComplete?.Invoke(-1, "(Local) Request timed out.");
				_currentRequest = null;
				if (Manager != null && Manager.Connected)
				{
					Manager.Connection.Close(linger: false, 0, "Request timed out.");
				}
			}
		}

		private void SendRequest(string url, string method, bool isEncoded, string contentType = "", string content = "", Action<int, string> onMessage = null)
		{
			_onMessage = onMessage;
			byte[] array;
			using (MemoryStream memoryStream = new MemoryStream())
			{
				WriteString(memoryStream, url);
				WriteString(memoryStream, method);
				WriteString(memoryStream, contentType ?? string.Empty);
				WriteString(memoryStream, content ?? string.Empty);
				memoryStream.WriteByte((byte)(isEncoded ? 1u : 0u));
				WriteString(memoryStream, (_clientAddress == null) ? string.Empty : _clientAddress.ToString());
				array = memoryStream.ToArray();
			}
			int num = 65524;
			int num2 = Math.Max(1, (array.Length + num - 1) / num);
			int value = _random.Next();
			for (int i = 0; i < num2; i++)
			{
				int num3 = Math.Min(num, array.Length - i * num);
				using MemoryStream memoryStream2 = new MemoryStream(num3 + 12);
				WriteInt32(memoryStream2, value);
				WriteInt32(memoryStream2, i);
				WriteInt32(memoryStream2, num2);
				memoryStream2.Write(array, i * num, num3);
				_sendQueue.Enqueue(memoryStream2.ToArray());
			}
		}

		public void DebugLog(string text, UnityEngine.Color color)
		{
			if (_currentRequest == null || _currentRequest.Log)
			{
				GameCore.Console.AddLog("[SDR] " + text, color);
			}
		}

		private static string ReadString(byte[] buffer, ref int offset)
		{
			int num = ReadInt32(buffer, ref offset);
			if (num < 0 || offset + num > buffer.Length)
			{
				throw new Exception("Invalid string length.");
			}
			string result = Encoding.UTF8.GetString(buffer, offset, num);
			offset += num;
			return result;
		}

		private static int ReadInt32(byte[] buffer, ref int offset)
		{
			if (buffer.Length - offset < 4)
			{
				throw new Exception("Buffer too short.");
			}
			int result = buffer[offset] | (buffer[offset + 1] << 8) | (buffer[offset + 2] << 16) | (buffer[offset + 3] << 24);
			offset += 4;
			return result;
		}

		private void HandleFailure()
		{
			_totalfails++;
			if (_totalfails >= 2)
			{
				DebugLog("SDR was unable to establish a connection to the central server, aborting and falling back to normal HTTP.", UnityEngine.Color.red);
				_sdrUnusable = true;
				_sdrInUse = false;
				CancelAllRequests();
			}
		}

		private void CancelAllRequests()
		{
			SDRHttpRequest result;
			while (_pendingRequests.TryDequeue(out result))
			{
				result.OnComplete?.Invoke(-1, "(Local) Request cancelled due to SDR failure.");
			}
		}

		private static void WriteString(MemoryStream stream, string value)
		{
			byte[] bytes = Encoding.UTF8.GetBytes(value);
			WriteInt32(stream, bytes.Length);
			stream.Write(bytes, 0, bytes.Length);
		}

		private static void WriteInt32(MemoryStream stream, int value)
		{
			stream.WriteByte((byte)value);
			stream.WriteByte((byte)(value >> 8));
			stream.WriteByte((byte)(value >> 16));
			stream.WriteByte((byte)(value >> 24));
		}
	}
}

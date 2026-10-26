using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace LiteNetLib
{
	internal static class NativeSocket
	{
		private static class WinSock
		{
			private const string LibName = "ws2_32.dll";

			[DllImport("ws2_32.dll", SetLastError = true)]
			public static extern int recvfrom(IntPtr socketHandle, [In][Out] byte[] pinnedBuffer, [In] int len, [In] SocketFlags socketFlags, [Out] byte[] socketAddress, [In][Out] ref int socketAddressSize);

			[DllImport("ws2_32.dll", SetLastError = true)]
			internal unsafe static extern int sendto(IntPtr socketHandle, byte* pinnedBuffer, [In] int len, [In] SocketFlags socketFlags, [In] byte[] socketAddress, [In] int socketAddressSize);
		}

		private static class UnixSock
		{
			private const string LibName = "libc";

			[DllImport("libc", SetLastError = true)]
			public static extern int recvfrom(IntPtr socketHandle, [In][Out] byte[] pinnedBuffer, [In] int len, [In] SocketFlags socketFlags, [Out] byte[] socketAddress, [In][Out] ref int socketAddressSize);

			[DllImport("libc", SetLastError = true)]
			internal unsafe static extern int sendto(IntPtr socketHandle, byte* pinnedBuffer, [In] int len, [In] SocketFlags socketFlags, [In] byte[] socketAddress, [In] int socketAddressSize);
		}

		public static readonly bool IsSupported;

		public static readonly bool UnixMode;

		public const int IPv4AddrSize = 16;

		public const int IPv6AddrSize = 28;

		public const int AF_INET = 2;

		public const int AF_INET6 = 10;

		private static readonly Dictionary<int, SocketError> NativeErrorToSocketError;

		static NativeSocket()
		{
			IsSupported = false;
			UnixMode = false;
			NativeErrorToSocketError = new Dictionary<int, SocketError>
			{
				{
					13,
					SocketError.AccessDenied
				},
				{
					98,
					SocketError.AddressAlreadyInUse
				},
				{
					99,
					SocketError.AddressNotAvailable
				},
				{
					97,
					SocketError.AddressFamilyNotSupported
				},
				{
					11,
					SocketError.WouldBlock
				},
				{
					114,
					SocketError.AlreadyInProgress
				},
				{
					9,
					SocketError.OperationAborted
				},
				{
					125,
					SocketError.OperationAborted
				},
				{
					103,
					SocketError.ConnectionAborted
				},
				{
					111,
					SocketError.ConnectionRefused
				},
				{
					104,
					SocketError.ConnectionReset
				},
				{
					89,
					SocketError.DestinationAddressRequired
				},
				{
					14,
					SocketError.Fault
				},
				{
					112,
					SocketError.HostDown
				},
				{
					6,
					SocketError.HostNotFound
				},
				{
					113,
					SocketError.HostUnreachable
				},
				{
					115,
					SocketError.InProgress
				},
				{
					4,
					SocketError.Interrupted
				},
				{
					22,
					SocketError.InvalidArgument
				},
				{
					106,
					SocketError.IsConnected
				},
				{
					24,
					SocketError.TooManyOpenSockets
				},
				{
					90,
					SocketError.MessageSize
				},
				{
					100,
					SocketError.NetworkDown
				},
				{
					102,
					SocketError.NetworkReset
				},
				{
					101,
					SocketError.NetworkUnreachable
				},
				{
					23,
					SocketError.TooManyOpenSockets
				},
				{
					105,
					SocketError.NoBufferSpaceAvailable
				},
				{
					61,
					SocketError.NoData
				},
				{
					2,
					SocketError.AddressNotAvailable
				},
				{
					92,
					SocketError.ProtocolOption
				},
				{
					107,
					SocketError.NotConnected
				},
				{
					88,
					SocketError.NotSocket
				},
				{
					3440,
					SocketError.OperationNotSupported
				},
				{
					1,
					SocketError.AccessDenied
				},
				{
					32,
					SocketError.Shutdown
				},
				{
					96,
					SocketError.ProtocolFamilyNotSupported
				},
				{
					93,
					SocketError.ProtocolNotSupported
				},
				{
					91,
					SocketError.ProtocolType
				},
				{
					94,
					SocketError.SocketNotSupported
				},
				{
					108,
					SocketError.Disconnecting
				},
				{
					110,
					SocketError.TimedOut
				},
				{
					0,
					SocketError.Success
				}
			};
			if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
			{
				IsSupported = true;
				UnixMode = true;
			}
			else if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
			{
				IsSupported = true;
			}
		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public static int RecvFrom(IntPtr socketHandle, byte[] pinnedBuffer, int len, byte[] socketAddress, ref int socketAddressSize)
		{
			if (!UnixMode)
			{
				return WinSock.recvfrom(socketHandle, pinnedBuffer, len, SocketFlags.None, socketAddress, ref socketAddressSize);
			}
			return UnixSock.recvfrom(socketHandle, pinnedBuffer, len, SocketFlags.None, socketAddress, ref socketAddressSize);
		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public unsafe static int SendTo(IntPtr socketHandle, byte* pinnedBuffer, int len, byte[] socketAddress, int socketAddressSize)
		{
			if (!UnixMode)
			{
				return WinSock.sendto(socketHandle, pinnedBuffer, len, SocketFlags.None, socketAddress, socketAddressSize);
			}
			return UnixSock.sendto(socketHandle, pinnedBuffer, len, SocketFlags.None, socketAddress, socketAddressSize);
		}

		public static SocketError GetSocketError()
		{
			int lastWin32Error = Marshal.GetLastWin32Error();
			if (UnixMode)
			{
				if (!NativeErrorToSocketError.TryGetValue(lastWin32Error, out var value))
				{
					return SocketError.SocketError;
				}
				return value;
			}
			return (SocketError)lastWin32Error;
		}

		public static SocketException GetSocketException()
		{
			int lastWin32Error = Marshal.GetLastWin32Error();
			if (UnixMode)
			{
				if (!NativeErrorToSocketError.TryGetValue(lastWin32Error, out var value))
				{
					return new SocketException(-1);
				}
				return new SocketException((int)value);
			}
			return new SocketException(lastWin32Error);
		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public static short GetNativeAddressFamily(IPEndPoint remoteEndPoint)
		{
			if (!UnixMode)
			{
				return (short)remoteEndPoint.AddressFamily;
			}
			return (short)((remoteEndPoint.AddressFamily == AddressFamily.InterNetwork) ? 2 : 10);
		}
	}
}

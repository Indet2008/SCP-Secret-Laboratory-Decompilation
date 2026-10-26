using System;

namespace LiteNetLib.Utils
{
	public class NtpPacket
	{
		private static readonly DateTime Epoch = new DateTime(1900, 1, 1);

		public byte[] Bytes { get; }

		public NtpLeapIndicator LeapIndicator => (NtpLeapIndicator)((Bytes[0] & 0xC0) >> 6);

		public int VersionNumber
		{
			get
			{
				return (Bytes[0] & 0x38) >> 3;
			}
			private set
			{
				Bytes[0] = (byte)((Bytes[0] & -57) | (value << 3));
			}
		}

		public NtpMode Mode
		{
			get
			{
				return (NtpMode)(Bytes[0] & 7);
			}
			private set
			{
				Bytes[0] = (byte)((uint)(Bytes[0] & -8) | (uint)value);
			}
		}

		public int Stratum => Bytes[1];

		public int Poll => Bytes[2];

		public int Precision => (sbyte)Bytes[3];

		public TimeSpan RootDelay => GetTimeSpan32(4);

		public TimeSpan RootDispersion => GetTimeSpan32(8);

		public uint ReferenceId => GetUInt32BE(12);

		public DateTime? ReferenceTimestamp => GetDateTime64(16);

		public DateTime? OriginTimestamp => GetDateTime64(24);

		public DateTime? ReceiveTimestamp => GetDateTime64(32);

		public DateTime? TransmitTimestamp
		{
			get
			{
				return GetDateTime64(40);
			}
			private set
			{
				SetDateTime64(40, value);
			}
		}

		public DateTime? DestinationTimestamp { get; private set; }

		public TimeSpan RoundTripTime
		{
			get
			{
				CheckTimestamps();
				return ReceiveTimestamp.Value - OriginTimestamp.Value + (DestinationTimestamp.Value - TransmitTimestamp.Value);
			}
		}

		public TimeSpan CorrectionOffset
		{
			get
			{
				CheckTimestamps();
				return TimeSpan.FromTicks((ReceiveTimestamp.Value - OriginTimestamp.Value - (DestinationTimestamp.Value - TransmitTimestamp.Value)).Ticks / 2);
			}
		}

		public NtpPacket()
			: this(new byte[48])
		{
			Mode = NtpMode.Client;
			VersionNumber = 4;
			TransmitTimestamp = DateTime.UtcNow;
		}

		internal NtpPacket(byte[] bytes)
		{
			if (bytes.Length < 48)
			{
				throw new ArgumentException("SNTP reply packet must be at least 48 bytes long.", "bytes");
			}
			Bytes = bytes;
		}

		public static NtpPacket FromServerResponse(byte[] bytes, DateTime destinationTimestamp)
		{
			return new NtpPacket(bytes)
			{
				DestinationTimestamp = destinationTimestamp
			};
		}

		internal void ValidateRequest()
		{
			if (Mode != NtpMode.Client)
			{
				throw new InvalidOperationException("This is not a request SNTP packet.");
			}
			if (VersionNumber == 0)
			{
				throw new InvalidOperationException("Protocol version of the request is not specified.");
			}
			if (!TransmitTimestamp.HasValue)
			{
				throw new InvalidOperationException("TransmitTimestamp must be set in request packet.");
			}
		}

		internal void ValidateReply()
		{
			if (Mode != NtpMode.Server)
			{
				throw new InvalidOperationException("This is not a reply SNTP packet.");
			}
			if (VersionNumber == 0)
			{
				throw new InvalidOperationException("Protocol version of the reply is not specified.");
			}
			if (Stratum == 0)
			{
				throw new InvalidOperationException($"Received Kiss-o'-Death SNTP packet with code 0x{ReferenceId:x}.");
			}
			if (LeapIndicator == NtpLeapIndicator.AlarmCondition)
			{
				throw new InvalidOperationException("SNTP server has unsynchronized clock.");
			}
			CheckTimestamps();
		}

		private void CheckTimestamps()
		{
			if (!OriginTimestamp.HasValue)
			{
				throw new InvalidOperationException("Origin timestamp is missing.");
			}
			if (!ReceiveTimestamp.HasValue)
			{
				throw new InvalidOperationException("Receive timestamp is missing.");
			}
			if (!TransmitTimestamp.HasValue)
			{
				throw new InvalidOperationException("Transmit timestamp is missing.");
			}
			if (!DestinationTimestamp.HasValue)
			{
				throw new InvalidOperationException("Destination timestamp is missing.");
			}
		}

		private DateTime? GetDateTime64(int offset)
		{
			ulong uInt64BE = GetUInt64BE(offset);
			if (uInt64BE == 0L)
			{
				return null;
			}
			DateTime epoch = Epoch;
			return new DateTime(epoch.Ticks + Convert.ToInt64((double)uInt64BE * 0.0023283064365386963));
		}

		private void SetDateTime64(int offset, DateTime? value)
		{
			long value2;
			if (value.HasValue)
			{
				long ticks = value.Value.Ticks;
				DateTime epoch = Epoch;
				value2 = (long)Convert.ToUInt64((double)(ticks - epoch.Ticks) * 429.4967296);
			}
			else
			{
				value2 = 0L;
			}
			SetUInt64BE(offset, (ulong)value2);
		}

		private TimeSpan GetTimeSpan32(int offset)
		{
			return TimeSpan.FromSeconds((double)GetInt32BE(offset) / 65536.0);
		}

		private ulong GetUInt64BE(int offset)
		{
			return SwapEndianness(BitConverter.ToUInt64(Bytes, offset));
		}

		private void SetUInt64BE(int offset, ulong value)
		{
			FastBitConverter.GetBytes(Bytes, offset, SwapEndianness(value));
		}

		private int GetInt32BE(int offset)
		{
			return (int)GetUInt32BE(offset);
		}

		private uint GetUInt32BE(int offset)
		{
			return SwapEndianness(BitConverter.ToUInt32(Bytes, offset));
		}

		private static uint SwapEndianness(uint x)
		{
			return ((x & 0xFF) << 24) | ((x & 0xFF00) << 8) | ((x & 0xFF0000) >> 8) | ((x & 0xFF000000u) >> 24);
		}

		private static ulong SwapEndianness(ulong x)
		{
			return ((ulong)SwapEndianness((uint)x) << 32) | SwapEndianness((uint)(x >> 32));
		}
	}
}

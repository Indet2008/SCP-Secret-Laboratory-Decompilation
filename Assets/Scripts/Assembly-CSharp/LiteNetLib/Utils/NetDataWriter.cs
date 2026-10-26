using System;
using System.Net;
using System.Net.Sockets;
using System.Runtime.CompilerServices;
using System.Text;

namespace LiteNetLib.Utils
{
	public class NetDataWriter
	{
		protected byte[] _data;

		protected int _position;

		private const int InitialSize = 64;

		private readonly bool _autoResize;

		internal static readonly UTF8Encoding uTF8Encoding = new UTF8Encoding(encoderShouldEmitUTF8Identifier: false, throwOnInvalidBytes: true);

		public int Capacity
		{
			[MethodImpl(MethodImplOptions.AggressiveInlining)]
			get
			{
				return _data.Length;
			}
		}

		public byte[] Data
		{
			[MethodImpl(MethodImplOptions.AggressiveInlining)]
			get
			{
				return _data;
			}
		}

		public int Length
		{
			[MethodImpl(MethodImplOptions.AggressiveInlining)]
			get
			{
				return _position;
			}
		}

		public ReadOnlySpan<byte> AsReadOnlySpan()
		{
			return new ReadOnlySpan<byte>(_data, 0, _position);
		}

		public NetDataWriter()
			: this(autoResize: true, 64)
		{
		}

		public NetDataWriter(bool autoResize)
			: this(autoResize, 64)
		{
		}

		public NetDataWriter(bool autoResize, int initialSize)
		{
			_data = new byte[initialSize];
			_autoResize = autoResize;
		}

		public static NetDataWriter FromBytes(byte[] bytes, bool copy)
		{
			if (copy)
			{
				NetDataWriter netDataWriter = new NetDataWriter(autoResize: true, bytes.Length);
				netDataWriter.Put(bytes);
				return netDataWriter;
			}
			return new NetDataWriter(autoResize: true, 0)
			{
				_data = bytes,
				_position = bytes.Length
			};
		}

		public static NetDataWriter FromBytes(byte[] bytes, int offset, int length)
		{
			NetDataWriter netDataWriter = new NetDataWriter(autoResize: true, bytes.Length);
			netDataWriter.Put(bytes, offset, length);
			return netDataWriter;
		}

		public static NetDataWriter FromBytes(Span<byte> bytes)
		{
			NetDataWriter netDataWriter = new NetDataWriter(autoResize: true, bytes.Length);
			netDataWriter.Put((ReadOnlySpan<byte>)bytes);
			return netDataWriter;
		}

		public static NetDataWriter FromString(string value)
		{
			NetDataWriter netDataWriter = new NetDataWriter();
			netDataWriter.Put(value);
			return netDataWriter;
		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public void ResizeIfNeed(int newSize)
		{
			if (_data.Length < newSize)
			{
				Array.Resize(ref _data, Math.Max(newSize, _data.Length * 2));
			}
		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public void EnsureFit(int additionalSize)
		{
			if (_data.Length < _position + additionalSize)
			{
				Array.Resize(ref _data, Math.Max(_position + additionalSize, _data.Length * 2));
			}
		}

		public void Reset(int size)
		{
			ResizeIfNeed(size);
			_position = 0;
		}

		public void Reset()
		{
			_position = 0;
		}

		public byte[] CopyData()
		{
			byte[] array = new byte[_position];
			Buffer.BlockCopy(_data, 0, array, 0, _position);
			return array;
		}

		public int SetPosition(int position)
		{
			int position2 = _position;
			_position = position;
			return position2;
		}

		public void Put(float value)
		{
			if (_autoResize)
			{
				ResizeIfNeed(_position + 4);
			}
			FastBitConverter.GetBytes(_data, _position, value);
			_position += 4;
		}

		public void Put(double value)
		{
			if (_autoResize)
			{
				ResizeIfNeed(_position + 8);
			}
			FastBitConverter.GetBytes(_data, _position, value);
			_position += 8;
		}

		public void Put(long value)
		{
			if (_autoResize)
			{
				ResizeIfNeed(_position + 8);
			}
			FastBitConverter.GetBytes(_data, _position, value);
			_position += 8;
		}

		public void Put(ulong value)
		{
			if (_autoResize)
			{
				ResizeIfNeed(_position + 8);
			}
			FastBitConverter.GetBytes(_data, _position, value);
			_position += 8;
		}

		public void Put(int value)
		{
			if (_autoResize)
			{
				ResizeIfNeed(_position + 4);
			}
			FastBitConverter.GetBytes(_data, _position, value);
			_position += 4;
		}

		public void Put(uint value)
		{
			if (_autoResize)
			{
				ResizeIfNeed(_position + 4);
			}
			FastBitConverter.GetBytes(_data, _position, value);
			_position += 4;
		}

		public void Put(char value)
		{
			Put((ushort)value);
		}

		public void Put(ushort value)
		{
			if (_autoResize)
			{
				ResizeIfNeed(_position + 2);
			}
			FastBitConverter.GetBytes(_data, _position, value);
			_position += 2;
		}

		public void Put(short value)
		{
			if (_autoResize)
			{
				ResizeIfNeed(_position + 2);
			}
			FastBitConverter.GetBytes(_data, _position, value);
			_position += 2;
		}

		public void Put(sbyte value)
		{
			if (_autoResize)
			{
				ResizeIfNeed(_position + 1);
			}
			_data[_position] = (byte)value;
			_position++;
		}

		public void Put(byte value)
		{
			if (_autoResize)
			{
				ResizeIfNeed(_position + 1);
			}
			_data[_position] = value;
			_position++;
		}

		public void Put(Guid value)
		{
			if (_autoResize)
			{
				ResizeIfNeed(_position + 16);
			}
			value.TryWriteBytes(_data.AsSpan(_position));
			_position += 16;
		}

		public void Put(byte[] data, int offset, int length)
		{
			if (_autoResize)
			{
				ResizeIfNeed(_position + length);
			}
			Buffer.BlockCopy(data, offset, _data, _position, length);
			_position += length;
		}

		public void Put(byte[] data)
		{
			if (_autoResize)
			{
				ResizeIfNeed(_position + data.Length);
			}
			Buffer.BlockCopy(data, 0, _data, _position, data.Length);
			_position += data.Length;
		}

		public void Put(ReadOnlySpan<byte> data)
		{
			if (_autoResize)
			{
				ResizeIfNeed(_position + data.Length);
			}
			data.CopyTo(_data.AsSpan(_position));
			_position += data.Length;
		}

		public void PutSBytesWithLength(sbyte[] data, int offset, ushort length)
		{
			if (_autoResize)
			{
				ResizeIfNeed(_position + 2 + length);
			}
			FastBitConverter.GetBytes(_data, _position, length);
			Buffer.BlockCopy(data, offset, _data, _position + 2, length);
			_position += 2 + length;
		}

		public void PutSBytesWithLength(sbyte[] data)
		{
			PutArray(data, 1);
		}

		public void PutBytesWithLength(byte[] data, int offset, ushort length)
		{
			if (_autoResize)
			{
				ResizeIfNeed(_position + 2 + length);
			}
			FastBitConverter.GetBytes(_data, _position, length);
			Buffer.BlockCopy(data, offset, _data, _position + 2, length);
			_position += 2 + length;
		}

		public void PutBytesWithLength(byte[] data)
		{
			PutArray(data, 1);
		}

		public void Put(bool value)
		{
			Put((byte)(value ? 1u : 0u));
		}

		public void PutArray(Array arr, int sz)
		{
			ushort num = (ushort)((arr != null) ? ((ushort)arr.Length) : 0);
			sz *= num;
			if (_autoResize)
			{
				ResizeIfNeed(_position + sz + 2);
			}
			FastBitConverter.GetBytes(_data, _position, num);
			if (arr != null)
			{
				Buffer.BlockCopy(arr, 0, _data, _position + 2, sz);
			}
			_position += sz + 2;
		}

		public void PutArray(float[] value)
		{
			PutArray(value, 4);
		}

		public void PutArray(double[] value)
		{
			PutArray(value, 8);
		}

		public void PutArray(long[] value)
		{
			PutArray(value, 8);
		}

		public void PutArray(ulong[] value)
		{
			PutArray(value, 8);
		}

		public void PutArray(int[] value)
		{
			PutArray(value, 4);
		}

		public void PutArray(uint[] value)
		{
			PutArray(value, 4);
		}

		public void PutArray(ushort[] value)
		{
			PutArray(value, 2);
		}

		public void PutArray(short[] value)
		{
			PutArray(value, 2);
		}

		public void PutArray(bool[] value)
		{
			PutArray(value, 1);
		}

		public void PutArray(string[] value)
		{
			ushort num = (ushort)((value != null) ? ((ushort)value.Length) : 0);
			Put(num);
			for (int i = 0; i < num; i++)
			{
				Put(value[i]);
			}
		}

		public void PutArray(string[] value, int strMaxLength)
		{
			ushort num = (ushort)((value != null) ? ((ushort)value.Length) : 0);
			Put(num);
			for (int i = 0; i < num; i++)
			{
				Put(value[i], strMaxLength);
			}
		}

		public void PutArray<T>(T[] value) where T : INetSerializable, new()
		{
			ushort num = (ushort)((value != null) ? ((uint)value.Length) : 0u);
			Put(num);
			for (int i = 0; i < num; i++)
			{
				value[i].Serialize(this);
			}
		}

		public void Put(IPEndPoint endPoint)
		{
			if (endPoint.AddressFamily == AddressFamily.InterNetwork)
			{
				Put((byte)0);
			}
			else
			{
				if (endPoint.AddressFamily != AddressFamily.InterNetworkV6)
				{
					throw new ArgumentException("Unsupported address family: " + endPoint.AddressFamily);
				}
				Put((byte)1);
			}
			Put(endPoint.Address.GetAddressBytes());
			Put((ushort)endPoint.Port);
		}

		public void PutLargeString(string value)
		{
			if (string.IsNullOrEmpty(value))
			{
				Put(0);
				return;
			}
			int byteCount = uTF8Encoding.GetByteCount(value);
			if (byteCount == 0)
			{
				Put(0);
				return;
			}
			Put(byteCount);
			if (_autoResize)
			{
				ResizeIfNeed(_position + byteCount);
			}
			uTF8Encoding.GetBytes(value, 0, byteCount, _data, _position);
			_position += byteCount;
		}

		public void Put(string value, int maxLength = 0)
		{
			if (string.IsNullOrEmpty(value))
			{
				Put((ushort)0);
				return;
			}
			int charCount = ((maxLength > 0 && value.Length > maxLength) ? maxLength : value.Length);
			int maxByteCount = uTF8Encoding.GetMaxByteCount(charCount);
			if (_autoResize)
			{
				ResizeIfNeed(_position + maxByteCount + 2);
			}
			int bytes = uTF8Encoding.GetBytes(value, 0, charCount, _data, _position + 2);
			if (bytes == 0)
			{
				Put((ushort)0);
				return;
			}
			Put(checked((ushort)(bytes + 1)));
			_position += bytes;
		}

		public void Put<T>(T obj) where T : INetSerializable
		{
			obj.Serialize(this);
		}
	}
}

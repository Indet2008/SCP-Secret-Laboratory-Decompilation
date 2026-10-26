using System;
using System.Text;
using Utf8Json.Internal;
using Utf8Json.Internal.DoubleConversion;

namespace Utf8Json
{
	public struct JsonWriter
	{
		private static readonly byte[] emptyBytes = new byte[0];

		private byte[] buffer;

		private int offset;

		public int CurrentOffset => offset;

		public void AdvanceOffset(int offset)
		{
			this.offset += offset;
		}

		public static byte[] GetEncodedPropertyName(string propertyName)
		{
			JsonWriter jsonWriter = default;
			jsonWriter.WritePropertyName(propertyName);
			return jsonWriter.ToUtf8ByteArray();
		}

		public static byte[] GetEncodedPropertyNameWithPrefixValueSeparator(string propertyName)
		{
			JsonWriter jsonWriter = default;
			jsonWriter.WriteValueSeparator();
			jsonWriter.WritePropertyName(propertyName);
			return jsonWriter.ToUtf8ByteArray();
		}

		public static byte[] GetEncodedPropertyNameWithBeginObject(string propertyName)
		{
			JsonWriter jsonWriter = default;
			jsonWriter.WriteBeginObject();
			jsonWriter.WritePropertyName(propertyName);
			return jsonWriter.ToUtf8ByteArray();
		}

		public static byte[] GetEncodedPropertyNameWithoutQuotation(string propertyName)
		{
			JsonWriter jsonWriter = default;
			jsonWriter.WriteString(propertyName);
			ArraySegment<byte> arraySegment = jsonWriter.GetBuffer();
			byte[] array = new byte[arraySegment.Count - 2];
			Buffer.BlockCopy(arraySegment.Array, arraySegment.Offset + 1, array, 0, array.Length);
			return array;
		}

		public JsonWriter(byte[] initialBuffer)
		{
			buffer = initialBuffer;
			offset = 0;
		}

		public ArraySegment<byte> GetBuffer()
		{
			if (buffer == null)
			{
				return new ArraySegment<byte>(emptyBytes, 0, 0);
			}
			return new ArraySegment<byte>(buffer, 0, offset);
		}

		public byte[] ToUtf8ByteArray()
		{
			if (buffer == null)
			{
				return emptyBytes;
			}
			return BinaryUtil.FastCloneWithResize(buffer, offset);
		}

		public override string ToString()
		{
			if (buffer == null)
			{
				return null;
			}
			return Encoding.UTF8.GetString(buffer, 0, offset);
		}

		public void EnsureCapacity(int appendLength)
		{
			BinaryUtil.EnsureCapacity(ref buffer, offset, appendLength);
		}

		public void WriteRaw(byte rawValue)
		{
			BinaryUtil.EnsureCapacity(ref buffer, offset, 1);
			buffer[offset++] = rawValue;
		}

		public void WriteRaw(byte[] rawValue)
		{
			BinaryUtil.EnsureCapacity(ref buffer, offset, rawValue.Length);
			Buffer.BlockCopy(rawValue, 0, buffer, offset, rawValue.Length);
			offset += rawValue.Length;
		}

		public void WriteRawUnsafe(byte rawValue)
		{
			buffer[offset++] = rawValue;
		}

		public void WriteBeginArray()
		{
			BinaryUtil.EnsureCapacity(ref buffer, offset, 1);
			buffer[offset++] = 91;
		}

		public void WriteEndArray()
		{
			BinaryUtil.EnsureCapacity(ref buffer, offset, 1);
			buffer[offset++] = 93;
		}

		public void WriteBeginObject()
		{
			BinaryUtil.EnsureCapacity(ref buffer, offset, 1);
			buffer[offset++] = 123;
		}

		public void WriteEndObject()
		{
			BinaryUtil.EnsureCapacity(ref buffer, offset, 1);
			buffer[offset++] = 125;
		}

		public void WriteValueSeparator()
		{
			BinaryUtil.EnsureCapacity(ref buffer, offset, 1);
			buffer[offset++] = 44;
		}

		public void WriteNameSeparator()
		{
			BinaryUtil.EnsureCapacity(ref buffer, offset, 1);
			buffer[offset++] = 58;
		}

		public void WritePropertyName(string propertyName)
		{
			WriteString(propertyName);
			WriteNameSeparator();
		}

		public void WriteQuotation()
		{
			BinaryUtil.EnsureCapacity(ref buffer, offset, 1);
			buffer[offset++] = 34;
		}

		public void WriteNull()
		{
			BinaryUtil.EnsureCapacity(ref buffer, offset, 4);
			buffer[offset] = 110;
			buffer[offset + 1] = 117;
			buffer[offset + 2] = 108;
			buffer[offset + 3] = 108;
			offset += 4;
		}

		public void WriteBoolean(bool value)
		{
			if (value)
			{
				BinaryUtil.EnsureCapacity(ref buffer, offset, 4);
				buffer[offset] = 116;
				buffer[offset + 1] = 114;
				buffer[offset + 2] = 117;
				buffer[offset + 3] = 101;
				offset += 4;
			}
			else
			{
				BinaryUtil.EnsureCapacity(ref buffer, offset, 5);
				buffer[offset] = 102;
				buffer[offset + 1] = 97;
				buffer[offset + 2] = 108;
				buffer[offset + 3] = 115;
				buffer[offset + 4] = 101;
				offset += 5;
			}
		}

		public void WriteTrue()
		{
			BinaryUtil.EnsureCapacity(ref buffer, offset, 4);
			buffer[offset] = 116;
			buffer[offset + 1] = 114;
			buffer[offset + 2] = 117;
			buffer[offset + 3] = 101;
			offset += 4;
		}

		public void WriteFalse()
		{
			BinaryUtil.EnsureCapacity(ref buffer, offset, 5);
			buffer[offset] = 102;
			buffer[offset + 1] = 97;
			buffer[offset + 2] = 108;
			buffer[offset + 3] = 115;
			buffer[offset + 4] = 101;
			offset += 5;
		}

		public void WriteSingle(float value)
		{
			offset += DoubleToStringConverter.GetBytes(ref buffer, offset, value);
		}

		public void WriteDouble(double value)
		{
			offset += DoubleToStringConverter.GetBytes(ref buffer, offset, value);
		}

		public void WriteByte(byte value)
		{
			WriteUInt64(value);
		}

		public void WriteUInt16(ushort value)
		{
			WriteUInt64(value);
		}

		public void WriteUInt32(uint value)
		{
			WriteUInt64(value);
		}

		public void WriteUInt64(ulong value)
		{
			offset += NumberConverter.WriteUInt64(ref buffer, offset, value);
		}

		public void WriteSByte(sbyte value)
		{
			WriteInt64(value);
		}

		public void WriteInt16(short value)
		{
			WriteInt64(value);
		}

		public void WriteInt32(int value)
		{
			WriteInt64(value);
		}

		public void WriteInt64(long value)
		{
			offset += NumberConverter.WriteInt64(ref buffer, offset, value);
		}

		public void WriteString(string value)
		{
			if (value == null)
			{
				WriteNull();
				return;
			}
			int num = offset;
			int num2 = StringEncoding.UTF8.GetMaxByteCount(value.Length) + 2;
			BinaryUtil.EnsureCapacity(ref buffer, num, num2);
			int num3 = 0;
			_ = value.Length;
			buffer[offset++] = 34;
			for (int i = 0; i < value.Length; i++)
			{
				byte b = 0;
				switch (value[i])
				{
				case '"':
					b = 34;
					break;
				case '\\':
					b = 92;
					break;
				case '\b':
					b = 98;
					break;
				case '\f':
					b = 102;
					break;
				case '\n':
					b = 110;
					break;
				case '\r':
					b = 114;
					break;
				case '\t':
					b = 116;
					break;
				default:
					continue;
				}
				num2 += 2;
				BinaryUtil.EnsureCapacity(ref buffer, num, num2);
				offset += StringEncoding.UTF8.GetBytes(value, num3, i - num3, buffer, offset);
				num3 = i + 1;
				buffer[offset++] = 92;
				buffer[offset++] = b;
			}
			if (num3 != value.Length)
			{
				offset += StringEncoding.UTF8.GetBytes(value, num3, value.Length - num3, buffer, offset);
			}
			buffer[offset++] = 34;
		}
	}
}

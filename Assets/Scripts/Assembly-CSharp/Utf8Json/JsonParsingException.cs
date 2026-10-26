using System;
using Utf8Json.Internal;

namespace Utf8Json
{
	public class JsonParsingException : Exception
	{
		private WeakReference underyingBytes;

		private int limit;

		public int Offset { get; private set; }

		public string ActualChar { get; set; }

		public JsonParsingException(string message)
			: base(message)
		{
		}

		public JsonParsingException(string message, byte[] underlyingBytes, int offset, int limit, string actualChar)
			: base(message)
		{
			underyingBytes = new WeakReference(underlyingBytes);
			Offset = offset;
			ActualChar = actualChar;
			this.limit = limit;
		}

		public byte[] GetUnderlyingByteArrayUnsafe()
		{
			return underyingBytes.Target as byte[];
		}

		public string GetUnderlyingStringUnsafe()
		{
			if (underyingBytes.Target is byte[] bytes)
			{
				return StringEncoding.UTF8.GetString(bytes, 0, limit) + "...";
			}
			return null;
		}
	}
}

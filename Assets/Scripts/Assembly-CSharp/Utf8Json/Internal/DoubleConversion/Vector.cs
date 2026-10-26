namespace Utf8Json.Internal.DoubleConversion
{
	internal struct Vector
	{
		public readonly byte[] bytes;

		public readonly int start;

		public readonly int _length;

		public byte this[int i]
		{
			get
			{
				return bytes[start + i];
			}
			set
			{
				bytes[start + i] = value;
			}
		}

		public Vector(byte[] bytes, int start, int length)
		{
			this.bytes = bytes;
			this.start = start;
			_length = length;
		}

		public int length()
		{
			return _length;
		}

		public byte first()
		{
			return bytes[start];
		}

		public byte last()
		{
			return bytes[_length - 1];
		}

		public bool is_empty()
		{
			return _length == 0;
		}

		public Vector SubVector(int from, int to)
		{
			return new Vector(bytes, start + from, to - from);
		}
	}
}

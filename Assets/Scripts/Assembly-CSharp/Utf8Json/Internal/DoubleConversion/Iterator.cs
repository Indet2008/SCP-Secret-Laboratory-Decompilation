namespace Utf8Json.Internal.DoubleConversion
{
	internal struct Iterator
	{
		private byte[] buffer;

		private int offset;

		public byte Value => buffer[offset];

		public Iterator(byte[] buffer, int offset)
		{
			this.buffer = buffer;
			this.offset = offset;
		}

		public static Iterator operator ++(Iterator self)
		{
			self.offset++;
			return self;
		}

		public static Iterator operator +(Iterator self, int length)
		{
			return new Iterator
			{
				buffer = self.buffer,
				offset = self.offset + length
			};
		}

		public static int operator -(Iterator lhs, Iterator rhs)
		{
			return lhs.offset - rhs.offset;
		}

		public static bool operator ==(Iterator lhs, Iterator rhs)
		{
			return lhs.offset == rhs.offset;
		}

		public static bool operator !=(Iterator lhs, Iterator rhs)
		{
			return lhs.offset != rhs.offset;
		}

		public static bool operator ==(Iterator lhs, char rhs)
		{
			return lhs.buffer[lhs.offset] == (byte)rhs;
		}

		public static bool operator !=(Iterator lhs, char rhs)
		{
			return lhs.buffer[lhs.offset] != (byte)rhs;
		}

		public static bool operator ==(Iterator lhs, byte rhs)
		{
			return lhs.buffer[lhs.offset] == rhs;
		}

		public static bool operator !=(Iterator lhs, byte rhs)
		{
			return lhs.buffer[lhs.offset] != rhs;
		}

		public static bool operator >=(Iterator lhs, char rhs)
		{
			return lhs.buffer[lhs.offset] >= (byte)rhs;
		}

		public static bool operator <=(Iterator lhs, char rhs)
		{
			return lhs.buffer[lhs.offset] <= (byte)rhs;
		}

		public static bool operator >(Iterator lhs, char rhs)
		{
			return lhs.buffer[lhs.offset] > (byte)rhs;
		}

		public static bool operator <(Iterator lhs, char rhs)
		{
			return lhs.buffer[lhs.offset] < (byte)rhs;
		}
	}
}

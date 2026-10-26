namespace Utf8Json.Internal.DoubleConversion
{
	internal struct StringBuilder
	{
		public byte[] buffer;

		public int offset;

		public StringBuilder(byte[] buffer, int position)
		{
			this.buffer = buffer;
			offset = position;
		}

		public void AddCharacter(byte str)
		{
			BinaryUtil.EnsureCapacity(ref buffer, offset, 1);
			buffer[offset++] = str;
		}

		public void AddString(byte[] str)
		{
			BinaryUtil.EnsureCapacity(ref buffer, offset, str.Length);
			for (int i = 0; i < str.Length; i++)
			{
				buffer[offset + i] = str[i];
			}
			offset += str.Length;
		}

		public void AddSubstring(byte[] str, int length)
		{
			BinaryUtil.EnsureCapacity(ref buffer, offset, length);
			for (int i = 0; i < length; i++)
			{
				buffer[offset + i] = str[i];
			}
			offset += length;
		}

		public void AddSubstring(byte[] str, int start, int length)
		{
			BinaryUtil.EnsureCapacity(ref buffer, offset, length);
			for (int i = 0; i < length; i++)
			{
				buffer[offset + i] = str[start + i];
			}
			offset += length;
		}

		public void AddPadding(byte c, int count)
		{
			BinaryUtil.EnsureCapacity(ref buffer, offset, count);
			for (int i = 0; i < count; i++)
			{
				buffer[offset + i] = c;
			}
			offset += count;
		}

		public void AddStringSlow(string str)
		{
			BinaryUtil.EnsureCapacity(ref buffer, offset, StringEncoding.UTF8.GetMaxByteCount(str.Length));
			offset += StringEncoding.UTF8.GetBytes(str, 0, str.Length, buffer, offset);
		}
	}
}

using System;
using System.IO;
using System.Text;

namespace Steam
{
	public class CustomBinaryWriter : IDisposable
	{
		private MemoryStream stream;

		private BinaryWriter writer;

		public CustomBinaryWriter()
		{
			stream = new MemoryStream();
			writer = new BinaryWriter(stream);
		}

		public void WriteByte(byte val)
		{
			writer.Write(val);
		}

		public void WriteShort(short val)
		{
			writer.Write(val);
		}

		public void WriteInt(int val)
		{
			writer.Write(val);
		}

		public void WriteFloat(float val)
		{
			writer.Write(val);
		}

		public void WriteLong(long val)
		{
			writer.Write(val);
		}

		public void WriteString(string val)
		{
			writer.Write(Encoding.UTF8.GetBytes(val));
			writer.Write((byte)0);
		}

		public byte[] ToArray()
		{
			return stream.ToArray();
		}

		public void Dispose()
		{
			writer.Dispose();
			stream.Dispose();
		}
	}
}

using System.IO;
using System.Reflection;
using System.Reflection.Emit;

namespace Utf8Json.Internal
{
	internal class ILStreamReader : BinaryReader
	{
		private static readonly OpCode[] oneByteOpCodes;

		private static readonly OpCode[] twoByteOpCodes;

		private int endPosition;

		public int CurrentPosition => (int)BaseStream.Position;

		public bool EndOfStream => (int)BaseStream.Position >= endPosition;

		static ILStreamReader()
		{
			oneByteOpCodes = new OpCode[256];
			twoByteOpCodes = new OpCode[256];
			FieldInfo[] fields = typeof(OpCodes).GetFields(BindingFlags.Static | BindingFlags.Public);
			for (int i = 0; i < fields.Length; i++)
			{
				OpCode opCode = (OpCode)fields[i].GetValue(null);
				ushort num = (ushort)opCode.Value;
				if (num < 256)
				{
					oneByteOpCodes[num] = opCode;
				}
				else if ((num & 0xFF00) == 65024)
				{
					twoByteOpCodes[num & 0xFF] = opCode;
				}
			}
		}

		public ILStreamReader(byte[] ilByteArray)
			: base(new MemoryStream(ilByteArray))
		{
			endPosition = ilByteArray.Length;
		}

		public OpCode ReadOpCode()
		{
			byte b = ReadByte();
			if (b != 254)
			{
				return oneByteOpCodes[b];
			}
			b = ReadByte();
			return twoByteOpCodes[b];
		}

		public int ReadMetadataToken()
		{
			return ReadInt32();
		}
	}
}

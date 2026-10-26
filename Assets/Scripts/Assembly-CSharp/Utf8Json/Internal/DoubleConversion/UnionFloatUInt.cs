using System.Runtime.InteropServices;

namespace Utf8Json.Internal.DoubleConversion
{
	[StructLayout(LayoutKind.Explicit, Pack = 1)]
	internal struct UnionFloatUInt
	{
		[FieldOffset(0)]
		public float f;

		[FieldOffset(0)]
		public uint u32;
	}
}

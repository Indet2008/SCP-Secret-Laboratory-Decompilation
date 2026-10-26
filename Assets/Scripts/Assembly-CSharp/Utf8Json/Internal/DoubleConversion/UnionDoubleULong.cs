using System.Runtime.InteropServices;

namespace Utf8Json.Internal.DoubleConversion
{
	[StructLayout(LayoutKind.Explicit, Pack = 1)]
	internal struct UnionDoubleULong
	{
		[FieldOffset(0)]
		public double d;

		[FieldOffset(0)]
		public ulong u64;
	}
}

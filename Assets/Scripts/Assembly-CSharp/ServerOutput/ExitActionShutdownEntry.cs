using System.Runtime.InteropServices;

namespace ServerOutput
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	public struct ExitActionShutdownEntry : IOutputEntry
	{
		public string GetString()
		{
			return ((byte)18).ToString();
		}

		public int GetBytesLength()
		{
			return 1;
		}

		public void GetBytes(ref byte[] buffer, out int length)
		{
			length = 1;
			buffer[0] = 20;
		}
	}
}

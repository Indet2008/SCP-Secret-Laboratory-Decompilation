namespace VoiceChat.CaressNoiseReduction
{
	public struct CaressData : global::System.IDisposable
	{
		public global::System.IntPtr Ptr;

		public uint Length;

		public string StringValue()
		{
			if (Ptr == global::System.IntPtr.Zero)
			{
				return null;
			}
			byte[] bytes = ByteValue();
			return global::System.Text.Encoding.UTF8.GetString(bytes);
		}

		public byte[] ByteValue()
		{
			if (Ptr == global::System.IntPtr.Zero)
			{
				return null;
			}
			byte[] array = new byte[Length];
			global::System.Runtime.InteropServices.Marshal.Copy(Ptr, array, 0, array.Length);
			return array;
		}

		public CaressData(global::System.IntPtr ptr)
		{
			Ptr = ptr;
			Length = 0u;
		}

		public CaressData(string value)
		{
			byte[] bytes = global::System.Text.Encoding.UTF8.GetBytes(value);
			global::System.IntPtr intPtr = global::System.Runtime.InteropServices.Marshal.AllocHGlobal(bytes.Length);
			global::System.Runtime.InteropServices.Marshal.Copy(bytes, 0, intPtr, bytes.Length);
			Ptr = intPtr;
			Length = (uint)bytes.Length;
		}

		public CaressData(byte[] value)
		{
			global::System.IntPtr intPtr = global::System.Runtime.InteropServices.Marshal.AllocHGlobal(value.Length);
			global::System.Runtime.InteropServices.Marshal.Copy(value, 0, intPtr, value.Length);
			Ptr = intPtr;
			Length = (uint)value.Length;
		}

		public void Dispose()
		{
			global::System.IntPtr intPtr = global::System.Threading.Interlocked.Exchange(ref Ptr, global::System.IntPtr.Zero);
			if (!(intPtr == global::System.IntPtr.Zero))
			{
				global::System.Runtime.InteropServices.Marshal.FreeHGlobal(intPtr);
			}
		}
	}
}

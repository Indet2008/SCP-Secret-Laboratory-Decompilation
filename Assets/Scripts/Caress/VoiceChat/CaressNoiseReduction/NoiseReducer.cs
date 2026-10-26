namespace VoiceChat.CaressNoiseReduction
{
	public class NoiseReducer : global::System.IDisposable
	{
		private global::System.IntPtr _ptr;

		public NoiseReducer(global::VoiceChat.CaressNoiseReduction.NoiseReducerConfig config)
		{
			_ptr = global::System.IntPtr.Zero;
		}

		public void ReduceNoise(float[] pcm)
		{
			if (!(_ptr == global::System.IntPtr.Zero))
			{
				global::VoiceChat.CaressNoiseReduction.CaressWrapper.ReduceNoiseFloat(_ptr, pcm, pcm.Length, 0);
				global::System.GC.KeepAlive(this);
			}
		}

		public void Dispose()
		{
			global::System.IntPtr intPtr = global::System.Threading.Interlocked.Exchange(ref _ptr, global::System.IntPtr.Zero);
			if (!(intPtr == global::System.IntPtr.Zero))
			{
				global::VoiceChat.CaressNoiseReduction.CaressData data = new global::VoiceChat.CaressNoiseReduction.CaressData(intPtr);
				global::VoiceChat.CaressNoiseReduction.CaressWrapper.DestroyNoiseReducer(ref data);
				global::System.GC.SuppressFinalize(this);
				global::System.GC.KeepAlive(this);
			}
		}

		~NoiseReducer()
		{
			Dispose();
		}
	}
}

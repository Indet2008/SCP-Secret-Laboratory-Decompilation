namespace VoiceChat.CaressNoiseReduction
{
	internal static class CaressWrapper
	{
		private const string DllName = "libcaress";

		[global::System.Runtime.InteropServices.DllImport("libcaress", CallingConvention = global::System.Runtime.InteropServices.CallingConvention.Cdecl)]
		public static extern void CreateNoiseReducer(ref global::VoiceChat.CaressNoiseReduction.NoiseReducerConfig config, out global::VoiceChat.CaressNoiseReduction.PointerResult result);

		[global::System.Runtime.InteropServices.DllImport("libcaress", CallingConvention = global::System.Runtime.InteropServices.CallingConvention.Cdecl)]
		public static extern void ReduceNoise(global::System.IntPtr ptr, short[] pcm, int pcmLength, int channel);

		[global::System.Runtime.InteropServices.DllImport("libcaress", CallingConvention = global::System.Runtime.InteropServices.CallingConvention.Cdecl)]
		public static extern void ReduceNoiseFloat(global::System.IntPtr ptr, float[] pcm, int pcmLength, int channel);

		[global::System.Runtime.InteropServices.DllImport("libcaress", CallingConvention = global::System.Runtime.InteropServices.CallingConvention.Cdecl)]
		public static extern void SetMaxAttenuation(global::System.IntPtr ptr, double attenuation);

		[global::System.Runtime.InteropServices.DllImport("libcaress", CallingConvention = global::System.Runtime.InteropServices.CallingConvention.Cdecl)]
		public static extern void ChangeRnnModel(global::System.IntPtr ptr, global::VoiceChat.CaressNoiseReduction.RnNoiseModel model);

		[global::System.Runtime.InteropServices.DllImport("libcaress", CallingConvention = global::System.Runtime.InteropServices.CallingConvention.Cdecl)]
		public static extern void DestroyNoiseReducer(ref global::VoiceChat.CaressNoiseReduction.CaressData data);
	}
}

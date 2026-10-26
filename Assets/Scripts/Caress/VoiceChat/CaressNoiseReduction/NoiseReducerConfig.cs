namespace VoiceChat.CaressNoiseReduction
{
	public struct NoiseReducerConfig
	{
		public int NumChannels;

		public int SampleRate;

		public double Attenuation;

		public global::VoiceChat.CaressNoiseReduction.RnNoiseModel Model;
	}
}

namespace VoiceChat
{
	public class PitchShifter
	{
		private const int MaxFrameLength = 16000;

		private static readonly float[] GInFifo;

		private static readonly float[] GOutFifo;

		private static readonly float[] GFfTworksp;

		private static readonly float[] GLastPhase;

		private static readonly float[] GSumPhase;

		private static readonly float[] GOutputAccum;

		private static readonly float[] GAnaFreq;

		private static readonly float[] GAnaMagn;

		private static readonly float[] GSynFreq;

		private static readonly float[] GSynMagn;

		private static long _gRover;

		private static long _gInit;

		public static void PitchShift(float pitchShift, long numSampsToProcess, float sampleRate, float[] indata)
		{
		}

		private static void PitchShift(float pitchShift, long numSampsToProcess, long fftFrameSize, long osamp, float sampleRate, float[] indata)
		{
		}

		private static void ShortTimeFourierTransform(float[] fftBuffer, long fftFrameSize, long sign)
		{
		}

		public PitchShifter()
		{
		}
	}
}

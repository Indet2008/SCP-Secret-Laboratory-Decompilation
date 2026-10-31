using System;

namespace VoiceChat
{
	public class PitchShifter
	{
		private const int MaxFrameLength = 16000;

		private static readonly float[] GInFifo = new float[16000];

		private static readonly float[] GOutFifo = new float[16000];

		private static readonly float[] GFfTworksp = new float[32000];

		private static readonly float[] GLastPhase = new float[8001];

		private static readonly float[] GSumPhase = new float[8001];

		private static readonly float[] GOutputAccum = new float[32000];

		private static readonly float[] GAnaFreq = new float[16000];

		private static readonly float[] GAnaMagn = new float[16000];

		private static readonly float[] GSynFreq = new float[16000];

		private static readonly float[] GSynMagn = new float[16000];

		private static long _gRover;

		private static long _gInit;

		public static void PitchShift(float pitchShift, long numSampsToProcess, float sampleRate, float[] indata)
		{
			PitchShift(pitchShift, numSampsToProcess, 2048L, 10L, sampleRate, indata);
		}

		private static void PitchShift(float pitchShift, long numSampsToProcess, long fftFrameSize, long osamp, float sampleRate, float[] indata)
		{
			long num = fftFrameSize / 2;
			long num2 = fftFrameSize / osamp;
			double num3 = (double)sampleRate / (double)fftFrameSize;
			double num4 = Math.PI * 2.0 * (double)num2 / (double)fftFrameSize;
			long num5 = fftFrameSize - num2;
			if (_gRover == 0L)
			{
				_gRover = num5;
			}
			for (long i = 0L; i < numSampsToProcess; i++)
			{
				GInFifo[_gRover] = indata[i];
				indata[i] = GOutFifo[_gRover - num5];
				_gRover++;
				if (_gRover < fftFrameSize)
				{
					continue;
				}
				_gRover = num5;
				for (long j = 0L; j < fftFrameSize; j++)
				{
					double num6 = -0.5 * Math.Cos(Math.PI * 2.0 * (double)j / (double)fftFrameSize) + 0.5;
					GFfTworksp[2 * j] = (float)((double)GInFifo[j] * num6);
					GFfTworksp[2 * j + 1] = 0f;
				}
				ShortTimeFourierTransform(GFfTworksp, fftFrameSize, -1L);
				for (long j = 0L; j <= num; j++)
				{
					double num7 = GFfTworksp[2 * j];
					double num8 = GFfTworksp[2 * j + 1];
					double num9 = 2.0 * Math.Sqrt(num7 * num7 + num8 * num8);
					double num10 = Math.Atan2(num8, num7);
					double num11 = num10 - (double)GLastPhase[j];
					GLastPhase[j] = (float)num10;
					num11 -= (double)j * num4;
					long num12 = (long)(num11 / Math.PI);
					num12 = ((num12 < 0) ? (num12 - (num12 & 1)) : (num12 + (num12 & 1)));
					num11 -= Math.PI * (double)num12;
					num11 = (double)osamp * num11 / (Math.PI * 2.0);
					num11 = (double)j * num3 + num11 * num3;
					GAnaMagn[j] = (float)num9;
					GAnaFreq[j] = (float)num11;
				}
				for (int k = 0; k < fftFrameSize; k++)
				{
					GSynMagn[k] = 0f;
					GSynFreq[k] = 0f;
				}
				for (long j = 0L; j <= num; j++)
				{
					long num13 = (long)((float)j * pitchShift);
					if (num13 <= num)
					{
						GSynMagn[num13] += GAnaMagn[j];
						GSynFreq[num13] = GAnaFreq[j] * pitchShift;
					}
				}
				for (long j = 0L; j <= num; j++)
				{
					double num14 = GSynMagn[j];
					double num15 = GSynFreq[j];
					num15 -= (double)j * num3;
					num15 /= num3;
					num15 = Math.PI * 2.0 * num15 / (double)osamp;
					num15 += (double)j * num4;
					GSumPhase[j] += (float)num15;
					double num16 = GSumPhase[j];
					GFfTworksp[2 * j] = (float)(num14 * Math.Cos(num16));
					GFfTworksp[2 * j + 1] = (float)(num14 * Math.Sin(num16));
				}
				for (long j = fftFrameSize + 2; j < 2 * fftFrameSize; j++)
				{
					GFfTworksp[j] = 0f;
				}
				ShortTimeFourierTransform(GFfTworksp, fftFrameSize, 1L);
				for (long j = 0L; j < fftFrameSize; j++)
				{
					double num17 = -0.5 * Math.Cos(Math.PI * 2.0 * (double)j / (double)fftFrameSize) + 0.5;
					GOutputAccum[j] += (float)(2.0 * num17 * (double)GFfTworksp[2 * j] / (double)(num * osamp));
				}
				for (long j = 0L; j < num2; j++)
				{
					GOutFifo[j] = GOutputAccum[j];
				}
				for (long j = 0L; j < fftFrameSize; j++)
				{
					GOutputAccum[j] = GOutputAccum[j + num2];
				}
				for (long j = 0L; j < num5; j++)
				{
					GInFifo[j] = GInFifo[j + num2];
				}
			}
		}

		private static void ShortTimeFourierTransform(float[] fftBuffer, long fftFrameSize, long sign)
		{
			for (long i = 2L; i < 2 * fftFrameSize - 2; i += 2)
			{
				long num = 2L;
				long num2 = 0L;
				while (num < 2 * fftFrameSize)
				{
					if ((i & num) != 0L)
					{
						num2++;
					}
					num2 <<= 1;
					num <<= 1;
				}
				if (i < num2)
				{
					float num3 = fftBuffer[i];
					fftBuffer[i] = fftBuffer[num2];
					fftBuffer[num2] = num3;
					num3 = fftBuffer[i + 1];
					fftBuffer[i + 1] = fftBuffer[num2 + 1];
					fftBuffer[num2 + 1] = num3;
				}
			}
			long num4 = (long)(Math.Log(fftFrameSize) / Math.Log(2.0) + 0.5);
			long j = 0L;
			long num5 = 2L;
			for (; j < num4; j++)
			{
				num5 <<= 1;
				long num6 = num5 >> 1;
				float num7 = 1f;
				float num8 = 0f;
				float num9 = (float)Math.PI / (float)(num6 >> 1);
				float num10 = (float)Math.Cos(num9);
				float num11 = (float)((double)sign * Math.Sin(num9));
				for (long k = 0L; k < num6; k += 2)
				{
					float num12;
					for (long l = k; l < 2 * fftFrameSize; l += num5)
					{
						num12 = fftBuffer[l + num6] * num7 - fftBuffer[l + num6 + 1] * num8;
						float num13 = fftBuffer[l + num6] * num8 + fftBuffer[l + num6 + 1] * num7;
						fftBuffer[l + num6] = fftBuffer[l] - num12;
						fftBuffer[l + num6 + 1] = fftBuffer[l + 1] - num13;
						fftBuffer[l] += num12;
						fftBuffer[l + 1] += num13;
					}
					num12 = num7 * num10 - num8 * num11;
					num8 = num7 * num11 + num8 * num10;
					num7 = num12;
				}
			}
		}
	}
}

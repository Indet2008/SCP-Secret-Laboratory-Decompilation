using System;
using VoiceChat.Codec.Enums;

namespace VoiceChat.Codec
{
	public class OpusEncoder : IDisposable
	{
		private IntPtr _handle = IntPtr.Zero;

		public OpusEncoder(OpusApplicationType preset)
		{
			_handle = OpusWrapper.CreateEncoder(48000, 1, preset);
			OpusWrapper.SetEncoderSetting(_handle, OpusCtlSetRequest.Bitrate, 120000);
		}

		public int Encode(float[] pcmSamples, byte[] encoded, int frameSize = 480)
		{
			return OpusWrapper.Encode(_handle, pcmSamples, frameSize, encoded);
		}

		public void Dispose()
		{
			if (!(_handle == IntPtr.Zero))
			{
				OpusWrapper.Destroy(_handle);
				_handle = IntPtr.Zero;
			}
		}
	}
}

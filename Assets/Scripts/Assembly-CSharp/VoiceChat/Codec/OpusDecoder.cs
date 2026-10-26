using System;
using VoiceChat.Codec.Enums;

namespace VoiceChat.Codec
{
	public class OpusDecoder : IDisposable
	{
		private IntPtr _handle = IntPtr.Zero;

		private bool _previousPacketInvalid;

		public OpusDecoder()
		{
			_handle = OpusWrapper.CreateDecoder(48000, 1);
			if (_handle == IntPtr.Zero)
			{
				throw new OpusException(OpusStatusCode.AllocFail, "Memory was not allocated for the encoder");
			}
		}

		public int Decode(byte[] packetData, int dataLength, float[] samples)
		{
			if (OpusWrapper.GetBandwidth(packetData) < 0)
			{
				_previousPacketInvalid = true;
				return OpusWrapper.Decode(_handle, null, 0, samples, fec: false, 1);
			}
			_previousPacketInvalid = false;
			return OpusWrapper.Decode(_handle, packetData, dataLength, samples, _previousPacketInvalid, 1);
		}

		public void Dispose()
		{
			if (_handle != IntPtr.Zero)
			{
				OpusWrapper.Destroy(_handle);
				_handle = IntPtr.Zero;
			}
		}
	}
}

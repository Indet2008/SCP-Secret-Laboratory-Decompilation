using VoiceChat.Networking;

namespace VoiceChat.Playbacks
{
	public class SingleBufferPlayback : VoiceChatPlaybackBase
	{
		private PlaybackBuffer _buffer;

		private bool _bufferSet;

		protected PlaybackBuffer Buffer
		{
			get
			{
				if (!_bufferSet)
				{
					_buffer = new PlaybackBuffer();
					_bufferSet = true;
				}
				return _buffer;
			}
		}

		public override int MaxSamples
		{
			get
			{
				if (!_bufferSet)
				{
					return 0;
				}
				return Buffer.Length;
			}
		}

		private void OnDestroy()
		{
			if (_bufferSet)
			{
				Buffer.Dispose();
			}
		}

		protected override void OnDisable()
		{
			base.OnDisable();
			if (_bufferSet)
			{
				Buffer.Clear();
			}
		}

		protected override float ReadSample()
		{
			return Buffer.Read();
		}

		public void WriteBuffer(float[] samples, int len, int sourceIndex = 0)
		{
			RegisterInput();
			Buffer.Write(samples, len, sourceIndex);
		}

		public void ClearBuffer()
		{
			Buffer.Clear();
		}
	}
}

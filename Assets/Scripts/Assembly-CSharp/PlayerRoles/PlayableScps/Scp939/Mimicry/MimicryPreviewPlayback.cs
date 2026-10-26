using VoiceChat.Networking;
using VoiceChat.Playbacks;

namespace PlayerRoles.PlayableScps.Scp939.Mimicry
{
	public class MimicryPreviewPlayback : VoiceChatPlaybackBase
	{
		private PlaybackBuffer _playback;

		private bool _playbackSet;

		public override int MaxSamples
		{
			get
			{
				if (!_playbackSet)
				{
					return 0;
				}
				return _playback.Length;
			}
		}

		public bool IsEmpty
		{
			get
			{
				if (_playbackSet)
				{
					return _playback.ReadHead == _playback.WriteHead;
				}
				return true;
			}
		}

		protected override float ReadSample()
		{
			return _playback.Read();
		}

		public void StartPreview(PlaybackBuffer pb, int startIndex, int length)
		{
			if (_playbackSet)
			{
				_playback.Clear();
			}
			else
			{
				_playback = new PlaybackBuffer(pb.Buffer.Length, endlessTapeMode: true);
				_playbackSet = true;
			}
			RegisterInput();
			_playback.Write(pb.Buffer, length, startIndex);
		}

		public void StopPreview()
		{
			if (_playbackSet)
			{
				_playback.Clear();
			}
		}
	}
}

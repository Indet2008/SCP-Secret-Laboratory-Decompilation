using System.Text;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079SimpleNotification : IScp079Notification
	{
		private int _totalWritten;

		private int _prevPlayed;

		private int _lettersOffset;

		private readonly bool _mute;

		private readonly StringBuilder _writtenText;

		private readonly string _targetContent;

		private readonly int _length;

		private readonly float _totalHeight;

		private readonly float _startTime;

		private readonly float _endTime;

		private const float InitialSize = -5f;

		private const float LettersPerSecond = 100f;

		private const float SoundRateRatio = 0.2f;

		private const float FadeInTime = 0.08f;

		private const float AbsoluteDuration = 4.2f;

		private const float PerLetterDuration = 0.05f;

		protected const float FadeOutDuration = 0.18f;

		private float CurrentTime => Time.timeSinceLevelLoad;

		private float Elapsed => CurrentTime - _startTime;

		protected virtual StringBuilder WrittenText => _writtenText;

		public virtual float Opacity => Mathf.Min(1f, 1f - (CurrentTime - _endTime) / 0.18f);

		public float Height
		{
			get
			{
				float t = ((Opacity > 0f) ? (Elapsed / 0.08f) : (1f + Opacity));
				return Mathf.Lerp(-5f, _totalHeight, t);
			}
		}

		public string DisplayedText
		{
			get
			{
				WriteLetters();
				return WrittenText.ToString();
			}
		}

		public NotificationSound Sound
		{
			get
			{
				int num = Mathf.CeilToInt((float)(_totalWritten - _lettersOffset) * 0.2f);
				if (num <= _prevPlayed)
				{
					return NotificationSound.None;
				}
				_prevPlayed = num;
				if (!_mute)
				{
					return NotificationSound.Standard;
				}
				return NotificationSound.None;
			}
		}

		public virtual bool Delete => Opacity < -1f;

		public Scp079SimpleNotification(string targetContent, bool mute = false)
		{
			_mute = mute;
			_writtenText = new StringBuilder();
			_targetContent = targetContent;
			_length = _targetContent.Length;
			_startTime = CurrentTime;
			_endTime = _startTime + 4.2f + 0.05f * (float)_length;
			Scp079NotificationManager.TryGetTextHeight(targetContent, out _totalHeight);
		}

		private void WriteLetters()
		{
			int num = Mathf.RoundToInt((Elapsed - 0.08f) * 100f) + _lettersOffset;
			if (num <= 0)
			{
				return;
			}
			bool flag = false;
			while (_totalWritten < _length && ((_totalWritten < num) | flag))
			{
				char c = _targetContent[_totalWritten];
				switch (c)
				{
				case '<':
					flag = true;
					break;
				case '>':
					flag = false;
					break;
				}
				_writtenText.Append(c);
				_totalWritten++;
				if (flag)
				{
					_lettersOffset++;
				}
			}
		}
	}
}

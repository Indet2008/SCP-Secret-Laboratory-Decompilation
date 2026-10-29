using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

namespace Subtitles
{
	public class SubtitleCategory : MonoBehaviour
	{
		private class Message
		{
			public string Text { get; }

			public float Duration { get; }

			public Message(string text, float duration)
			{
				Text = text;
				Duration = duration;
			}
		}

		private static readonly string[] SplitSeperator = new string[1] { "<split>" };

		[SerializeField]
		protected string _speakerName;

		[SerializeField]
		private Color _speakerColor;

		public TextMeshProUGUI CategoryText;

		protected float _timer;

		private Queue<Message> _messages = new Queue<Message>();

		private Message _currentMessage;

		protected int _currentMessageSize;

		protected int _speakerStartStringSize;

		protected int _maxCharacters;

		protected bool IsPlayingMessage { get; set; }

		protected virtual int MaxVisibleCharacters => _maxCharacters;

		protected virtual string SpeakerPrefix => "<color=" + _speakerColor.ToHex() + ">" + _speakerName + "</color>";

		public void AddSubtitle(string message, float duration, float delay)
		{
			_messages.Enqueue(new Message(string.Empty, delay));
			int num = 0;
			string[] array = message.Split(SplitSeperator, StringSplitOptions.None);
			string[] array2 = array;
			foreach (string text in array2)
			{
				num += text.Length;
			}
			array2 = array;
			foreach (string text2 in array2)
			{
				_messages.Enqueue(new Message(text2, Mathf.Max(2f, duration * ((float)text2.Length / (float)num))));
			}
			_messages.Enqueue(new Message(string.Empty, delay));
		}

		public void ClearSubtitles()
		{
			_messages.Clear();
			IsPlayingMessage = false;
			CategoryText.text = string.Empty;
		}

		protected virtual void Awake()
		{
			_speakerStartStringSize = _speakerName.Length;
		}

		protected void CheckForMessageStart()
		{
			if (_messages.Count != 0)
			{
				_currentMessage = _messages.Dequeue();
				_timer = _currentMessage.Duration;
				IsPlayingMessage = true;
				if (!string.IsNullOrWhiteSpace(_currentMessage.Text))
				{
					CategoryText.text = SpeakerPrefix + " " + _currentMessage.Text;
					CategoryText.maxVisibleCharacters = _speakerStartStringSize;
					_maxCharacters = _speakerStartStringSize;
					_currentMessageSize = CategoryText.text.Length;
				}
			}
		}

		private void CheckForMessageEnd()
		{
			_timer -= Time.deltaTime;
			if (!(_timer > 0f))
			{
				IsPlayingMessage = false;
				CategoryText.text = string.Empty;
				CheckForMessageStart();
			}
		}

		protected virtual void FixedUpdate()
		{
			if (!IsPlayingMessage)
			{
				CheckForMessageStart();
				return;
			}
			CheckForMessageEnd();
			if (CategoryText.maxVisibleCharacters < _currentMessageSize)
			{
				_maxCharacters++;
				CategoryText.maxVisibleCharacters = MaxVisibleCharacters + _speakerStartStringSize;
			}
		}
	}
}

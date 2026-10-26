using System.Collections.Generic;
using UnityEngine;

namespace VoiceChat.Playbacks
{
	public class IntercomPlayback : SingleBufferPlayback, IGlobalPlayback
	{
		private bool _isTemplate;

		private ReferenceHub _lastSpeaker;

		private static bool _templateSet;

		private static IntercomPlayback _template;

		private static int _instancesCnt;

		private static readonly List<IntercomPlayback> Instances = new List<IntercomPlayback>();

		public bool GlobalChatActive => MaxSamples > 0;

		public Color GlobalChatColor { get; private set; }

		public string GlobalChatName { get; private set; }

		public float GlobalChatLoudness => base.Loudness;

		public GlobalChatIconType GlobalChatIcon => GlobalChatIconType.Intercom;

		protected override void Awake()
		{
			base.Awake();
			_instancesCnt++;
			Instances.Add(this);
			GlobalChatIndicatorManager.Subscribe(this, null);
			if (!_templateSet)
			{
				_template = this;
				_isTemplate = true;
				_templateSet = true;
			}
		}

		private void OnDestroy()
		{
			GlobalChatIndicatorManager.Unsubscribe(this);
			if (_isTemplate)
			{
				_templateSet = false;
				_instancesCnt = 0;
				Instances.Clear();
			}
		}

		private void SetSpeaker(ReferenceHub speaker)
		{
			_lastSpeaker = speaker;
			GlobalChatName = speaker.nicknameSync.DisplayName;
			GlobalChatColor = speaker.serverRoles.GetVoiceColor();
		}

		public static void ProcessSamples(ReferenceHub ply, float[] samples, int len)
		{
			if (!_templateSet)
			{
				return;
			}
			bool flag = false;
			IntercomPlayback intercomPlayback = null;
			for (int i = 0; i < _instancesCnt; i++)
			{
				IntercomPlayback intercomPlayback2 = Instances[i];
				if (intercomPlayback2._lastSpeaker == ply)
				{
					intercomPlayback2.WriteBuffer(samples, len);
					return;
				}
				if (!flag && intercomPlayback2.MaxSamples == 0)
				{
					intercomPlayback = intercomPlayback2;
					flag = true;
				}
			}
			if (!flag)
			{
				intercomPlayback = Object.Instantiate(_template);
				intercomPlayback.ClearBuffer();
			}
			intercomPlayback.SetSpeaker(ply);
			intercomPlayback.WriteBuffer(samples, len);
		}
	}
}

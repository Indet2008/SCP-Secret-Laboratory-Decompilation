using System.Diagnostics;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Scp127
{
	public class Scp127IdleChatterVoiceTrigger : Scp127VoiceTriggerBase
	{
		private readonly Stopwatch _idleTimer = new Stopwatch();

		private float _nextLineSeconds;

		[SerializeField]
		private float _minIdleTimeMinutes;

		[SerializeField]
		private float _maxIdleTimeMinutes;

		[SerializeField]
		private Scp127VoiceLineCollection _voiceLines;

		public override bool ContainsAudioClip(AudioClip clip)
		{
			return _voiceLines.Contains(clip);
		}

		private void ReRandomizeTimer()
		{
			_idleTimer.Restart();
			_nextLineSeconds = Random.Range(_minIdleTimeMinutes, _maxIdleTimeMinutes) * 60f;
		}

		private void ResetIdleTimer(Firearm firearm)
		{
			if (!(firearm != base.Firearm))
			{
				_idleTimer.Restart();
			}
		}

		protected override void RegisterEvents()
		{
			base.RegisterEvents();
			Scp127VoiceLineManagerModule.OnServerVoiceLineSent += ResetIdleTimer;
		}

		protected override void UnregisterEvents()
		{
			base.UnregisterEvents();
			Scp127VoiceLineManagerModule.OnServerVoiceLineSent -= ResetIdleTimer;
		}

		internal override void OnAdded()
		{
			base.OnAdded();
			if (base.HasFriendship)
			{
				ReRandomizeTimer();
			}
		}

		public override void OnFriendshipCreated()
		{
			base.OnFriendshipCreated();
			ReRandomizeTimer();
		}

		internal override void AlwaysUpdate()
		{
			base.AlwaysUpdate();
			if (!(_idleTimer.Elapsed.TotalSeconds < (double)_nextLineSeconds))
			{
				ReRandomizeTimer();
				ServerPlayVoiceLineFromCollection(_voiceLines);
			}
		}
	}
}

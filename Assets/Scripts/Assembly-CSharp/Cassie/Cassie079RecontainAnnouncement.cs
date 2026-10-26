using System;
using UnityEngine;

namespace Cassie
{
	public class Cassie079RecontainAnnouncement : CassieAnnouncement
	{
		private const float MinDelay = 3f;

		private readonly Action _callback;

		private float _remainingDelay;

		public override bool ReadyToPlay
		{
			get
			{
				if (base.ReadyToPlay)
				{
					return _remainingDelay <= 0f;
				}
				return false;
			}
		}

		public Cassie079RecontainAnnouncement(Action callback, bool delay, CassieTtsPayload payload)
			: base(payload)
		{
			_callback = callback;
			_remainingDelay = (delay ? 3f : 0f);
		}

		public override void UpdateQueued()
		{
			base.UpdateQueued();
			_remainingDelay -= Time.deltaTime;
		}

		public override void OnFinishedPlaying()
		{
			base.OnFinishedPlaying();
			_callback?.Invoke();
		}
	}
}

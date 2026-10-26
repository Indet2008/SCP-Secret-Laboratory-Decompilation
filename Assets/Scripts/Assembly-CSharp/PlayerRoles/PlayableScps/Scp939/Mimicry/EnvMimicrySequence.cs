using System;
using System.Collections.Generic;
using AudioPooling;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939.Mimicry
{
	public class EnvMimicrySequence : ScriptableObject
	{
		[Serializable]
		private class Sound
		{
			public float Range;

			public float Duration;

			public Vector2Int Repeat;

			public AudioClip[] Clips;

			public MixerChannel Channel;
		}

		[SerializeField]
		private Sound[] _sounds;

		private Sound _currentlyPlayed;

		private readonly Queue<Sound> _queuedSounds = new Queue<Sound>();

		public void EnqueueAll(int randomSeed)
		{
			UnityEngine.Random.State state = UnityEngine.Random.state;
			UnityEngine.Random.InitState(randomSeed);
			_sounds.ForEach(EnqueueSound);
			UnityEngine.Random.state = state;
		}

		public bool UpdateSequence(Transform mimicPoint)
		{
			if (_currentlyPlayed == null)
			{
				if (!_queuedSounds.TryDequeue(out var result))
				{
					return false;
				}
				AudioSourcePoolManager.PlayOnTransform(result.Clips.RandomItem(), mimicPoint, result.Range, 1f, FalloffType.Exponential, result.Channel);
				_currentlyPlayed = result;
			}
			_currentlyPlayed.Duration -= Time.deltaTime;
			if (_currentlyPlayed.Duration <= 0f)
			{
				_currentlyPlayed = null;
			}
			return true;
		}

		private void EnqueueSound(Sound s)
		{
			int num = UnityEngine.Random.Range(s.Repeat.x, s.Repeat.y + 1);
			while (num-- > 0)
			{
				Sound item = new Sound
				{
					Clips = s.Clips,
					Channel = s.Channel,
					Duration = s.Duration,
					Range = s.Range
				};
				_queuedSounds.Enqueue(item);
			}
		}
	}
}

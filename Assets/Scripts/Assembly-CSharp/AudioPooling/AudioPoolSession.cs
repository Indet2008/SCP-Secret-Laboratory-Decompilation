using System;
using UnityEngine;

namespace AudioPooling
{
	public readonly struct AudioPoolSession : IEquatable<AudioPoolSession>
	{
		private readonly ulong _sessionId;

		public readonly PooledAudioSource HandledInstance;

		public bool SameSession
		{
			get
			{
				if (HandledInstance != null && !HandledInstance.Pooled)
				{
					return HandledInstance.TotalRecycles == _sessionId;
				}
				return false;
			}
		}

		public bool IsPlaying
		{
			get
			{
				if (SameSession)
				{
					return Source.isPlaying;
				}
				return false;
			}
		}

		public AudioSource Source => HandledInstance.Source;

		public AudioPoolSession(PooledAudioSource subject)
		{
			HandledInstance = subject;
			_sessionId = subject.TotalRecycles;
		}

		public bool Equals(AudioPoolSession other)
		{
			if (HandledInstance == other.HandledInstance)
			{
				return _sessionId == other._sessionId;
			}
			return false;
		}

		public override int GetHashCode()
		{
			return HashCode.Combine(_sessionId, (!(HandledInstance == null)) ? HandledInstance.GetHashCode() : 0);
		}

		public override bool Equals(object obj)
		{
			if (obj is AudioPoolSession other)
			{
				return Equals(other);
			}
			return false;
		}

		public override string ToString()
		{
			return base.ToString();
		}

		public static bool operator ==(AudioPoolSession left, AudioPoolSession right)
		{
			return left.Equals(right);
		}

		public static bool operator !=(AudioPoolSession left, AudioPoolSession right)
		{
			return !left.Equals(right);
		}
	}
}

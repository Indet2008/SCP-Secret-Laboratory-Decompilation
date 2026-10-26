using UnityEngine;

namespace AudioPooling
{
	public class PooledAudioSource : MonoBehaviour
	{
		private AudioSource _audioSource;

		private bool _sourceCached;

		private Transform _transform;

		private bool _transformCached;

		public bool Locked { get; set; }

		public ulong TotalRecycles { get; private set; }

		public bool Pooled { get; private set; }

		public AudioSource Source
		{
			get
			{
				if (!_sourceCached)
				{
					_audioSource = GetComponent<AudioSource>();
					_sourceCached = true;
				}
				return _audioSource;
			}
		}

		public Transform FastTransform
		{
			get
			{
				if (!_transformCached)
				{
					_transform = base.transform;
					_transformCached = true;
				}
				return _transform;
			}
		}

		public bool AllowRecycling
		{
			get
			{
				if (!Locked)
				{
					return !Source.isPlaying;
				}
				return false;
			}
		}

		internal void OnRecycled()
		{
			Pooled = false;
			TotalRecycles++;
		}

		internal void OnPooled()
		{
			Pooled = true;
		}
	}
}

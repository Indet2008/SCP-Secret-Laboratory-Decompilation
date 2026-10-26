using System.Diagnostics;
using AudioPooling;
using RelativePositioning;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Misc
{
	public class BulletWhizzHandler : MonoBehaviour
	{
		private AudioSource _src;

		private RelativePosition _midpoint;

		private Vector3 _dir;

		private Transform _srcTr;

		private bool _wasPlaying;

		private readonly Stopwatch _sw = new Stopwatch();

		[field: SerializeField]
		public AudioClip[] Clips { get; private set; }

		[field: SerializeField]
		public float SourceRange { get; private set; } = 10f;

		[field: SerializeField]
		public float MidpointTime { get; private set; } = 0.07f;

		[field: SerializeField]
		public float TravelDistance { get; private set; } = 6f;

		public bool IsPlaying
		{
			get
			{
				if (!_wasPlaying)
				{
					return false;
				}
				if (Source.isPlaying)
				{
					return true;
				}
				_wasPlaying = false;
				return false;
			}
		}

		private AudioSource Source
		{
			get
			{
				if (_src != null)
				{
					return _src;
				}
				_src = AudioSourcePoolManager.CreateNewSource().Source;
				AudioSourcePoolManager.ApplyStandardSettings(_src, null, FalloffType.Exponential, MixerChannel.NoDucking, 1f, SourceRange);
				_srcTr = _src.transform;
				return _src;
			}
		}

		public void Play(Vector3 dir, Vector3 midpoint)
		{
			_midpoint = new RelativePosition(midpoint);
			_dir = dir;
			_sw.Restart();
			Source.PlayOneShot(Clips.RandomItem());
			_wasPlaying = true;
			Update();
		}

		private void Update()
		{
			if (IsPlaying)
			{
				Vector3 position = _midpoint.Position;
				Vector3 a = position - 0.5f * TravelDistance * _dir;
				Vector3 b = position + 0.5f * TravelDistance * _dir;
				_srcTr.position = Vector3.LerpUnclamped(a, b, (float)_sw.Elapsed.TotalSeconds / MidpointTime);
			}
		}
	}
}

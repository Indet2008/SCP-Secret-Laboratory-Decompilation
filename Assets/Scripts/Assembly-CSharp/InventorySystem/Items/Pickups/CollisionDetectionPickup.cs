using System;
using AudioPooling;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Pickups
{
	public class CollisionDetectionPickup : ItemPickupBase
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioSource _audioSrc;


		[Serializable]
		private struct SoundOverVelocity
		{
			[SerializeField]
			private float _minimalVelocity;

			[SerializeField]
			private AudioClip[] _randomClips;

			[Range(0f, 0.5f)]
			[SerializeField]
			private float _randomizePitch;

			[SerializeField]
			private float _maxRange;

			public bool TryPlaySound(float vel, AudioSource src)
			{
				if (vel < _minimalVelocity)
				{
					return false;
				}
				src.PlayOneShot(_randomClips[UnityEngine.Random.Range(0, _randomClips.Length)]);
				src.maxDistance = _maxRange;
				src.pitch = UnityEngine.Random.Range(1f - _randomizePitch, 1f / (1f - _randomizePitch));
				return true;
			}
		}

		private readonly System.Diagnostics.Stopwatch _stopwatch = System.Diagnostics.Stopwatch.StartNew();

		private const float MinimalJoulesToInduceDamage = 15f;

		private const float DamagePerJoule = 0.4f;

		private const float DefaultSoundCooldown = 0.1f;

		[SerializeField]
		private SoundOverVelocity[] _soundsOverVelocity;

		protected virtual float MinSoundCooldown => 0.1f;

		public event Action<Collision> OnCollided;

		private void OnCollisionEnter(Collision collision)
		{
			ProcessCollision(collision);
		}

		public float GetRangeOfCollisionVelocity(float sqrVel)
		{
			AudioSource source = AudioSourcePoolManager.GetFree().Source;
			for (int num = _soundsOverVelocity.Length - 1; num >= 0; num--)
			{
				if (_soundsOverVelocity[num].TryPlaySound(sqrVel, source))
				{
					source.Stop();
					return source.maxDistance;
				}
			}
			return 0f;
		}

		protected virtual void ProcessCollision(Collision collision)
		{
			OnCollided?.Invoke(collision);
			float sqrMagnitude = collision.relativeVelocity.sqrMagnitude;
			if (NetworkServer.active)
			{
				float num = Info.WeightKg * sqrMagnitude / 2f;
				if (num > 15f)
				{
					float damage = num * 0.4f;
					if (collision.collider.TryGetComponent<BreakableWindow>(out var component))
					{
						component.Damage(damage, null, Vector3.zero);
					}
				}
			}
			MakeCollisionSound(sqrMagnitude);
		}

		protected void MakeCollisionSound(float sqrtVelocity)
		{
			if (_stopwatch.Elapsed.TotalSeconds < (double)MinSoundCooldown || _audioSrc == null)
			{
				return;
			}
			for (int num = _soundsOverVelocity.Length - 1; num >= 0; num--)
			{
				if (_soundsOverVelocity[num].TryPlaySound(sqrtVelocity, _audioSrc))
				{
					break;
				}
			}
			_stopwatch.Restart();
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}

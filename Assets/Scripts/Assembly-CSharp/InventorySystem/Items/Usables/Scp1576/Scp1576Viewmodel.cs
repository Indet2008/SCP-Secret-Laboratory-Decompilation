using System.Collections.Generic;
using System.Diagnostics;
using AudioPooling;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace InventorySystem.Items.Usables.Scp1576
{
	public class Scp1576Viewmodel : UsableItemViewmodel
	{
		private const ItemType Scp1576Type = ItemType.SCP1576;

		private static readonly Dictionary<ushort, float> PrevWeights = new Dictionary<ushort, float>();

		private static readonly Dictionary<ushort, Stopwatch> TimersBySerial = new Dictionary<ushort, Stopwatch>();

		private static float _cachedUseTime;

		private static bool _useTimeCacheSet;

		private bool _wasCranking;

		[SerializeField]
		private int _posLayer;

		[SerializeField]
		private Material _beltMaterial;

		[SerializeField]
		private Vector2 _beltSpeed;

		[SerializeField]
		private ParticleSystem _particles;

		[SerializeField]
		private AudioSource _audioLoop;

		[SerializeField]
		private AudioClip _endRecordClip;

		[SerializeField]
		private AudioClip _rewindClip;

		[SerializeField]
		private AudioClip _startRecording;

		[SerializeField]
		private Scp1576Source _playbackSource;

		private static float UseTime
		{
			get
			{
				if (!_useTimeCacheSet)
				{
					_cachedUseTime = (InventoryItemLoader.AvailableItems[ItemType.SCP1576] as UsableItem).UseTime;
					_useTimeCacheSet = true;
				}
				return _cachedUseTime;
			}
		}

		protected override void LateUpdate()
		{
			base.LateUpdate();
			if (!PrevWeights.TryGetValue(base.ItemId.SerialNumber, out var value))
			{
				value = 0f;
			}
			if (!TimersBySerial.TryGetValue(base.ItemId.SerialNumber, out var value2) || !value2.IsRunning)
			{
				if (_particles.isPlaying)
				{
					_particles.Stop();
				}
				if (_audioLoop.volume > 0f)
				{
					AudioSourcePoolManager.Play2DWithParent(_endRecordClip, base.transform);
				}
				_audioLoop.volume = 0f;
				_playbackSource.enabled = false;
				AnimatorSetLayerWeight(_posLayer, value);
				return;
			}
			float num = (float)value2.Elapsed.TotalSeconds;
			if (num > UseTime)
			{
				if (_wasCranking)
				{
					_particles.Play();
					AudioSourcePoolManager.Play2DWithParent(_startRecording, base.transform);
					_wasCranking = false;
					_playbackSource.enabled |= base.IsLocal;
				}
				float num2 = num - UseTime;
				_audioLoop.volume = num2;
				value = num2 / 30f;
				_beltMaterial.mainTextureOffset += _beltSpeed * Time.deltaTime;
			}
			else if (num > 1.1f)
			{
				_wasCranking = true;
				float num3 = value;
				value -= Time.deltaTime * 0.4f;
				if (num3 > 0f && value <= 0f)
				{
					AudioSourcePoolManager.Play2DWithParent(_rewindClip, base.transform);
				}
			}
			value = Mathf.Clamp01(value);
			PrevWeights[base.ItemId.SerialNumber] = value;
			AnimatorSetLayerWeight(_posLayer, value);
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			UsableItemsController.OnClientStatusReceived += OnClientStatusReceived;
			Scp1576Pickup.OnHornPositionUpdated += (ushort serial, float pos) =>
			{
				PrevWeights[serial] = pos;
			};
		}

		private static void OnClientStatusReceived(StatusMessage msg)
		{
			switch (msg.Status)
			{
			case StatusMessage.StatusType.Start:
				if (ReferenceHub.AllHubs.Any((ReferenceHub x) => x.inventory.CurItem.SerialNumber == msg.ItemSerial && x.inventory.CurItem.TypeId == ItemType.SCP1576))
				{
					TimersBySerial.GetOrAdd(msg.ItemSerial, () => new Stopwatch()).Restart();
				}
				break;
			case StatusMessage.StatusType.Cancel:
			{
				if (TimersBySerial.TryGetValue(msg.ItemSerial, out var value))
				{
					value.Reset();
				}
				break;
			}
			}
		}
	}
}

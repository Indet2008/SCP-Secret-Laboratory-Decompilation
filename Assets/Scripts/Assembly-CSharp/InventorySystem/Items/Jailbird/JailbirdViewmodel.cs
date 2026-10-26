using System;
using System.Collections.Generic;
using Mirror;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace InventorySystem.Items.Jailbird
{
	public class JailbirdViewmodel : StandardAnimatedViemodel
	{
		[Serializable]
		private struct InspectPreset
		{
			public JailbirdWearState State;

			public AudioClip Sound;

			public float Speed;

			public int VariantId;
		}

		private static readonly Dictionary<ushort, double> LastUpdates = new Dictionary<ushort, double>();

		private static readonly Dictionary<ushort, JailbirdMessageType> LastRpcs = new Dictionary<ushort, JailbirdMessageType>();

		private static readonly HashSet<ushort> BrokenJailbirds = new HashSet<ushort>();

		private static readonly int BrokenHash = Animator.StringToHash("Broken");

		private static readonly int LeftHandHash = Animator.StringToHash("LeftHand");

		private static readonly int ChargeLoadHash = Animator.StringToHash("ChargeLoad");

		private static readonly int ChargingHash = Animator.StringToHash("Charging");

		private static readonly int SkipPickupHash = Animator.StringToHash("AlreadyPickedUp");

		private static readonly int AttackTriggerHash = Animator.StringToHash("Attack");

		private static readonly int InspectTriggerHash = Animator.StringToHash("Inspect");

		private static readonly int InspectSpeedHash = Animator.StringToHash("InspectSpeed");

		private static readonly int InspectVariantHash = Animator.StringToHash("InspectVariant");

		private static readonly int IdleTagHash = Animator.StringToHash("Idle");

		private static Dictionary<JailbirdWearState, InspectPreset> _presetsByWear;

		private static bool _alreadyPickedUp;

		private static bool _anyCollectionModified;

		private static bool _wasLeftHand;

		private const float FastModeThreshold = 1.5f;

		private const float InspectCooldown = 0.5f;

		[SerializeField]
		private JailbirdMaterialController _materialController;

		[SerializeField]
		private GameObject _particlesSmall;

		[SerializeField]
		private GameObject _particlesLarge;

		[SerializeField]
		private GameObject _particlesTrail;

		[SerializeField]
		private GameObject _particlesBroken;

		[SerializeField]
		private InspectPreset[] _inspectPresets;

		[SerializeField]
		private AudioClip _firstEquipSound;

		[SerializeField]
		private AudioClip _normalEquipSound;

		[SerializeField]
		private AudioClip _chargeLoadSound;

		[SerializeField]
		private AudioClip _chargingSound;

		[SerializeField]
		private AudioClip _swipeSoundLeft;

		[SerializeField]
		private AudioClip _swipeSoundRight;

		[SerializeField]
		private AudioClip _chargeHitSound;

		[SerializeField]
		private AudioClip _brokenSound;

		[SerializeField]
		private AudioSource _targetAudioSource;

		[SerializeField]
		private GameObject _inspectParticlesRoot;

		private double _nextInspect;

		private bool _wasCharging;

		public override void InitAny()
		{
			base.InitAny();
			JailbirdItem.OnRpcReceived += RpcReceived;
			_materialController.SetSerial(base.ItemId.SerialNumber);
		}

		internal override void OnEquipped()
		{
			base.OnEquipped();
			AnimatorSetBool(SkipPickupHash, _alreadyPickedUp);
			PlaySound(_alreadyPickedUp ? _normalEquipSound : _firstEquipSound, base.SkipEquipTime);
			_alreadyPickedUp = true;
		}

		public override void InitSpectator(ReferenceHub ply, ItemIdentifier id, bool wasEquipped)
		{
			base.InitSpectator(ply, id, wasEquipped);
			if (BrokenJailbirds.Contains(id.SerialNumber))
			{
				SetBroken();
			}
			AnimatorForceUpdate(base.SkipEquipTime);
			if (LastRpcs.TryGetValue(id.SerialNumber, out var value) && LastUpdates.TryGetValue(id.SerialNumber, out var value2))
			{
				float num = (float)(NetworkTime.time - value2);
				ProcessRpc(value, num);
				if (num > 1.5f)
				{
					AnimatorForceUpdate(1.5f, fastMode: false);
					AnimatorForceUpdate(num - 1.5f);
				}
				else
				{
					AnimatorForceUpdate(num, fastMode: false);
				}
			}
		}

		public override void InitLocal(ItemBase ib)
		{
			base.InitLocal(ib);
			(base.ParentItem as JailbirdItem).OnCmdSent += OnCmdSent;
		}

		private void OnDestroy()
		{
			JailbirdItem.OnRpcReceived -= RpcReceived;
		}

		private void Update()
		{
			int tagHash = AnimatorStateInfo(0).tagHash;
			_particlesSmall.SetActive(tagHash == AttackTriggerHash);
			_particlesTrail.SetActive(tagHash == ChargingHash);
			_particlesLarge.SetActive(tagHash == ChargeLoadHash || tagHash == ChargingHash);
			_inspectParticlesRoot.SetActive(tagHash == InspectTriggerHash);
		}

		private void RpcReceived(ushort serial, JailbirdMessageType rpc)
		{
			if (serial == base.ItemId.SerialNumber)
			{
				ProcessRpc(rpc, 0f);
			}
		}

		private void ProcessRpc(JailbirdMessageType rpc, float delay)
		{
			bool flag = rpc == JailbirdMessageType.ChargeStarted;
			bool val = rpc == JailbirdMessageType.ChargeLoadTriggered;
			AnimatorSetBool(ChargingHash, flag);
			AnimatorSetBool(ChargeLoadHash, val);
			if (_wasCharging && !flag)
			{
				PlaySound(_chargeHitSound, delay);
			}
			switch (rpc)
			{
			case JailbirdMessageType.AttackTriggered:
				if (base.IsSpectator)
				{
					PlayAttackAnim(delay);
				}
				break;
			case JailbirdMessageType.ChargeLoadTriggered:
				PlaySound(_chargeLoadSound, delay);
				break;
			case JailbirdMessageType.ChargeStarted:
				PlaySound(_chargingSound, delay);
				break;
			case JailbirdMessageType.ChargeFailed:
				PlaySound(null, delay);
				break;
			case JailbirdMessageType.Broken:
				SetBroken();
				PlaySound(_brokenSound, delay, stopPrev: false);
				break;
			case JailbirdMessageType.Inspect:
			{
				if (AnimatorStateInfo(0).tagHash != IdleTagHash || _nextInspect > NetworkTime.time)
				{
					break;
				}
				JailbirdDeteriorationTracker.ReceivedStates.TryGetValue(base.ItemId.SerialNumber, out var value);
				if (_presetsByWear == null)
				{
					_presetsByWear = new Dictionary<JailbirdWearState, InspectPreset>();
					_presetsByWear.FromArray(_inspectPresets, (InspectPreset x) => x.State);
				}
				if (_presetsByWear.TryGetValue(value, out var value2))
				{
					PlaySound(value2.Sound, delay);
					AnimatorSetTrigger(InspectTriggerHash);
					AnimatorSetFloat(InspectSpeedHash, value2.Speed);
					AnimatorSetFloat(InspectVariantHash, value2.VariantId);
					_nextInspect = NetworkTime.time + 0.5;
				}
				break;
			}
			}
			_wasCharging = flag;
		}

		private void PlaySound(AudioClip clip, float delay, bool stopPrev = true, float pitchRandom = 0f)
		{
			int num = 0;
			if (stopPrev)
			{
				_targetAudioSource.Stop();
			}
			if (delay > 0f)
			{
				num = Mathf.RoundToInt(delay * (float)AudioSettings.outputSampleRate);
				if (num > clip.samples)
				{
					return;
				}
			}
			_targetAudioSource.PlayOneShot(clip);
			_targetAudioSource.pitch = 1f + UnityEngine.Random.Range(0f - pitchRandom, pitchRandom);
			if (num != 0)
			{
				_targetAudioSource.timeSamples = num;
			}
		}

		private void SetBroken()
		{
			AnimatorSetBool(BrokenHash, val: true);
			_particlesBroken.SetActive(value: true);
		}

		private void OnCmdSent(JailbirdMessageType cmd)
		{
			if (cmd == JailbirdMessageType.AttackTriggered)
			{
				PlayAttackAnim(0f);
			}
		}

		private void PlayAttackAnim(float delay)
		{
			_wasLeftHand = !_wasLeftHand;
			AnimatorSetBool(LeftHandHash, _wasLeftHand);
			AnimatorSetTrigger(AttackTriggerHash);
			PlaySound(_wasLeftHand ? _swipeSoundLeft : _swipeSoundRight, delay, stopPrev: true, 0.1f);
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				_alreadyPickedUp = false;
				if (_anyCollectionModified)
				{
					LastRpcs.Clear();
					LastUpdates.Clear();
					BrokenJailbirds.Clear();
					_anyCollectionModified = false;
				}
			};
			JailbirdItem.OnRpcReceived += (ushort serial, JailbirdMessageType rpc) =>
			{
				_anyCollectionModified = true;
				LastRpcs[serial] = rpc;
				LastUpdates[serial] = NetworkTime.time;
				if (rpc == JailbirdMessageType.Broken)
				{
					BrokenJailbirds.Add(serial);
				}
			};
		}
	}
}

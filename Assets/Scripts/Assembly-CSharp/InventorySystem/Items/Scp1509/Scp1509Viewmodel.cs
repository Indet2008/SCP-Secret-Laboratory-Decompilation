using System;
using System.Collections.Generic;
using AudioPooling;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Scp1509
{
	public class Scp1509Viewmodel : StandardAnimatedViemodel
	{
		[Serializable]
		private struct InspectPreset
		{
			public AudioClip Sound;

			public float Speed;

			public int VariantId;
		}

		private const float FakeDistanceModifier = 0.95f;

		private const float ResurrectSmokeAudioPan = 0.35f;

		private const float FastModeThreshold = 1.5f;

		private const float InspectCooldown = 0.5f;

		private const int FakeMaxDetections = 128;

		private const float FakeMaxDotProduct = 0.05f;

		private static readonly Dictionary<ushort, double> LastUpdates = new Dictionary<ushort, double>();

		private static readonly Dictionary<ushort, Scp1509MessageType> LastRpcs = new Dictionary<ushort, Scp1509MessageType>();

		private static readonly CachedLayerMask FakeHitMask = new CachedLayerMask("Hitbox");

		private static readonly CachedLayerMask FakeWallHitMask = new CachedLayerMask("Default", "Glass", "Door", "InvisibleCollider", "Fence");

		private static readonly Collider[] FakeDetectedColliders = new Collider[128];

		private static readonly int LeftHandHash = Animator.StringToHash("LeftHand");

		private static readonly int KillAttackHash = Animator.StringToHash("KillAttack");

		private static readonly int HitWallHash = Animator.StringToHash("HitWall");

		private static readonly int AttackTriggerHash = Animator.StringToHash("Attack");

		private static readonly int InspectTriggerHash = Animator.StringToHash("Inspect");

		private static readonly int InspectSpeedHash = Animator.StringToHash("InspectSpeed");

		private static readonly int IdleTagHash = Animator.StringToHash("Idle");

		private static bool _anyCollectionModified;

		private static bool _wasLeftHand;

		[SerializeField]
		private AudioClip _equipSound;

		[SerializeField]
		private AudioClip _inspectSound;

		[SerializeField]
		private AudioClip _hitSound;

		[SerializeField]
		private AudioClip _hitClothSound;

		[SerializeField]
		private AudioClip[] _hitFleshSound;

		[SerializeField]
		private AudioClip[] _missSounds;

		[SerializeField]
		private AudioClip[] _hitMetalSounds;

		[SerializeField]
		private AudioSource _targetAudioSource;

		[SerializeField]
		private ParticleSystem[] _resurrectParticles;

		[SerializeField]
		private AudioClip _resurrectSmokeSound;

		[SerializeField]
		private Material _bloodyMaterial;

		[SerializeField]
		private Material _regularMaterial;

		[SerializeField]
		private MeshRenderer _scp1509Mesh;

		private double _nextInspect;

		private PooledAudioSource _resurrectPooledAudio;

		private bool ReceivedStatus
		{
			get
			{
				bool value;
				return Scp1509Item.ResurrectStatuses.TryGetValue(base.ItemId.SerialNumber, out value) & value;
			}
		}

		public override void InitAny()
		{
			base.InitAny();
			_scp1509Mesh.sharedMaterial = _regularMaterial;
			SetResurrectState(ReceivedStatus);
			Scp1509Item.OnRpcReceived += RpcReceived;
		}

		internal override void OnEquipped()
		{
			base.OnEquipped();
			PlaySound(_equipSound, base.SkipEquipTime);
		}

		public override void InitSpectator(ReferenceHub ply, ItemIdentifier id, bool wasEquipped)
		{
			base.InitSpectator(ply, id, wasEquipped);
			AnimatorForceUpdate(base.SkipEquipTime);
			SetResurrectState(ReceivedStatus);
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
			(base.ParentItem as Scp1509Item).OnCmdSent += OnCmdSent;
		}

		private void OnDestroy()
		{
			Scp1509Item.OnRpcReceived -= RpcReceived;
		}

		private void RpcReceived(ushort serial, Scp1509MessageType rpc)
		{
			if (serial == base.ItemId.SerialNumber)
			{
				ProcessRpc(rpc, 0f);
			}
		}

		private void ProcessRpc(Scp1509MessageType rpc, float delay)
		{
			switch (rpc)
			{
			case Scp1509MessageType.AttackPreformedHitFlesh:
				if (base.IsSpectator)
				{
					PlayAttackAnim(delay, hitWall: false, hitFlesh: true);
				}
				break;
			case Scp1509MessageType.AttackPreformedHitWall:
				if (base.IsSpectator)
				{
					PlayAttackAnim(delay, hitWall: true);
				}
				break;
			case Scp1509MessageType.AttackPreformedHitMissed:
			case Scp1509MessageType.AttackPerformed:
				if (base.IsSpectator)
				{
					PlayAttackAnim(delay);
				}
				break;
			case Scp1509MessageType.Inspect:
				if (AnimatorStateInfo(0).tagHash == IdleTagHash && !(_nextInspect > NetworkTime.time))
				{
					PlaySound(_inspectSound, delay);
					AnimatorSetTrigger(InspectTriggerHash);
					AnimatorSetFloat(InspectSpeedHash, 1f);
					_nextInspect = NetworkTime.time + 0.5;
				}
				break;
			case Scp1509MessageType.CanResurrect:
				SetResurrectState(active: true);
				break;
			case Scp1509MessageType.CanNotResurrect:
				SetResurrectState(active: false);
				break;
			case Scp1509MessageType.KilledPlayer:
				_scp1509Mesh.sharedMaterial = _bloodyMaterial;
				break;
			case Scp1509MessageType.SpawnResurrectParticles:
				break;
			}
		}

		private void SetResurrectState(bool active)
		{
			if (active)
			{
				if (_resurrectPooledAudio == null)
				{
					_resurrectPooledAudio = AudioSourcePoolManager.Play2DWithParent(_resurrectSmokeSound, base.gameObject.transform);
					_resurrectPooledAudio.Locked = true;
					_resurrectPooledAudio.Source.loop = true;
					_resurrectPooledAudio.Source.playOnAwake = true;
					_resurrectPooledAudio.Source.panStereo = 0.35f;
				}
				_resurrectPooledAudio.Source.Play();
			}
			else if (_resurrectPooledAudio != null)
			{
				_resurrectPooledAudio.Source.Stop();
			}
			ParticleSystem[] resurrectParticles = _resurrectParticles;
			foreach (ParticleSystem particleSystem in resurrectParticles)
			{
				ParticleSystem.MainModule main = particleSystem.main;
				main.loop = active;
				main.playOnAwake = active;
				if (active)
				{
					particleSystem.Play();
				}
				else
				{
					particleSystem.Stop();
				}
			}
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

		private void OnCmdSent(Scp1509MessageType cmd)
		{
			if (cmd != Scp1509MessageType.AttackTriggered || !(base.ParentItem is Scp1509Item scp1509Item))
			{
				return;
			}
			Transform playerCameraReference = base.Hub.PlayerCameraReference;
			int num = Physics.OverlapSphereNonAlloc(playerCameraReference.position + playerCameraReference.forward * scp1509Item.HitregOffset, scp1509Item.HitregRadius * 0.95f, FakeDetectedColliders, FakeHitMask);
			bool flag = false;
			for (int i = 0; i < num; i++)
			{
				if (FakeDetectedColliders[i].TryGetComponent<IDestructible>(out var component) && component.NetworkId != base.Hub.netId)
				{
					Vector3 vector = component.CenterOfMass - playerCameraReference.position;
					float sqrMagnitude = vector.sqrMagnitude;
					Vector3 forward = playerCameraReference.forward;
					if (!(Vector3.Dot(vector / Mathf.Sqrt(sqrMagnitude), forward) <= 0.05f) && (!Physics.Linecast(playerCameraReference.position, component.CenterOfMass, out var hitInfo, FakeWallHitMask) || !(hitInfo.collider != FakeDetectedColliders[i])) && ReferenceHub.TryGetHubNetID(component.NetworkId, out var hub) && HitboxIdentity.IsDamageable(base.Hub, hub))
					{
						flag = true;
						break;
					}
				}
			}
			if (flag)
			{
				PlayAttackAnim(0f, hitWall: false, hitFlesh: true);
			}
			else if (!Physics.Raycast(base.Hub.PlayerCameraReference.position, base.Hub.PlayerCameraReference.forward, scp1509Item.HitregRadius, FakeWallHitMask))
			{
				PlayAttackAnim(0f);
			}
			else
			{
				PlayAttackAnim(0f, hitWall: true);
			}
		}

		private void PlayAttackAnim(float delay, bool hitWall = false, bool hitFlesh = false)
		{
			_wasLeftHand = !_wasLeftHand;
			AnimatorSetBool(LeftHandHash, _wasLeftHand);
			AnimatorSetBool(HitWallHash, hitWall);
			AnimatorSetTrigger(AttackTriggerHash);
			AudioClip clip = _missSounds[UnityEngine.Random.Range(0, _missSounds.Length)];
			if (hitWall)
			{
				clip = _hitMetalSounds[UnityEngine.Random.Range(0, _hitMetalSounds.Length)];
			}
			if (hitFlesh)
			{
				clip = _hitFleshSound[UnityEngine.Random.Range(0, _hitFleshSound.Length)];
			}
			PlaySound(clip, delay, stopPrev: true, 0.1f);
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				if (_anyCollectionModified)
				{
					LastRpcs.Clear();
					LastUpdates.Clear();
					_anyCollectionModified = false;
				}
			};
			Scp1509Item.OnRpcReceived += (ushort serial, Scp1509MessageType rpc) =>
			{
				_anyCollectionModified = true;
				LastRpcs[serial] = rpc;
				LastUpdates[serial] = NetworkTime.time;
			};
		}
	}
}

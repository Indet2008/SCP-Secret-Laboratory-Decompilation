using System;
using System.Collections.Generic;
using System.Diagnostics;
using Interactables.Interobjects.DoorButtons;
using Interactables.Interobjects.DoorUtils;
using InventorySystem;
using InventorySystem.Items.Pickups;
using Mirror;
using UnityEngine;

namespace MapGeneration.Distributors
{
	public class LockerChamber : MonoBehaviour, IDoorPermissionRequester
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioSource _audioSource;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioClip _openClip;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioClip _closeClip;


		public ItemType[] AcceptableItems;

		public bool IsOpen;

		public DoorPermissionFlags RequiredPermissions;

		public readonly List<ItemPickupBase> Content = new List<ItemPickupBase>();

		public Transform Spawnpoint;

		public bool SpawnOnFirstChamberOpening;

		[NonSerialized]
		public readonly List<ItemPickupBase> ToBeSpawned = new List<ItemPickupBase>();

		[NonSerialized]
		public float TargetCooldown;

		[NonSerialized]
		public bool WasEverOpened;

		[SerializeField]
		private Animator _animator;

		[SerializeField]
		private bool _useMultipleSpawnpoints;

		[SerializeField]
		private Transform[] _spawnpoints;

		[SerializeField]
		private float _animationTime = 1f;

		[SerializeField]
		private KeycardScannerNfcIcon _nfcScanner;

		[SerializeField]
		private KeycardScannerPermsIndicator[] _permsIndicators;

		private static readonly int DoorHash = Animator.StringToHash("isOpen");

		private static readonly int DeniedHash = Animator.StringToHash("accessDenied");

		private static readonly int GrantedHash = Animator.StringToHash("accessGranted");

		private const float MinimalTimeSinceMapGeneration = 5f;

		private readonly Stopwatch _stopwatch = new Stopwatch();

		private byte _animatorStatusCode;

		private bool _prevDoor;

		public bool CanInteract
		{
			get
			{
				if (!AnimatorSet)
				{
					return false;
				}
				if (!_stopwatch.IsRunning)
				{
					return true;
				}
				if (_stopwatch.Elapsed.TotalSeconds >= (double)TargetCooldown)
				{
					_stopwatch.Stop();
					return true;
				}
				return false;
			}
		}

		public bool AnimatorSet
		{
			get
			{
				if (_animatorStatusCode == 0)
				{
					_animatorStatusCode = (byte)((_animator == null) ? 1u : 2u);
				}
				return _animatorStatusCode == 2;
			}
		}

		public DoorPermissionsPolicy PermissionsPolicy => new DoorPermissionsPolicy(RequiredPermissions, requireAll: true);

		[field: SerializeField]
		public string RequesterLogSignature { get; set; }

		public event Action OnDoorStatusSet;

		protected virtual void Start()
		{
			KeycardScannerPermsIndicator[] permsIndicators = _permsIndicators;
			for (int i = 0; i < permsIndicators.Length; i++)
			{
				permsIndicators[i].Register(this);
			}
		}

		public virtual void SpawnItem(ItemType id, int amount)
		{
			if (id == ItemType.None || !InventoryItemLoader.AvailableItems.TryGetValue(id, out var value))
			{
				return;
			}
			for (int i = 0; i < amount; i++)
			{
				GetSpawnpoint(id, i, out var worldPosition, out var worldRotation, out var parent);
				ItemPickupBase itemPickupBase = UnityEngine.Object.Instantiate(value.PickupDropModel, worldPosition, worldRotation);
				itemPickupBase.transform.SetParent(parent);
				itemPickupBase.NetworkInfo = new PickupSyncInfo(id, value.Weight, 0, locked: true);
				Content.Add(itemPickupBase);
				(itemPickupBase as IPickupDistributorTrigger)?.OnDistributed();
				if (itemPickupBase.TryGetComponent<Rigidbody>(out var component))
				{
					component.isKinematic = true;
					component.transform.ResetLocalPose();
					SpawnablesDistributorBase.BodiesToUnfreeze.Add(component);
				}
				if (SpawnOnFirstChamberOpening)
				{
					ToBeSpawned.Add(itemPickupBase);
				}
				else
				{
					ItemDistributor.SpawnPickup(itemPickupBase);
				}
			}
		}

		protected virtual void GetSpawnpoint(ItemType itemType, int index, out Vector3 worldPosition, out Quaternion worldRotation, out Transform parent)
		{
			Transform transform;
			if (_useMultipleSpawnpoints && _spawnpoints.Length != 0)
			{
				int num = index % _spawnpoints.Length;
				transform = _spawnpoints[num];
			}
			else
			{
				transform = Spawnpoint;
			}
			parent = transform;
			worldPosition = transform.position;
			worldRotation = transform.rotation;
		}

		public void SetDoor(bool doorStatus, AudioClip beepClip)
		{
			if (doorStatus != _prevDoor)
			{
				IsOpen = doorStatus;
				_prevDoor = doorStatus;
				if (AnimatorSet)
				{
					_animator.SetBool(DoorHash, doorStatus);
					TargetCooldown = _animationTime;
					_stopwatch.Restart();
				}
				if (_nfcScanner != null)
				{
					_nfcScanner.SetTemporaryGranted(_animationTime);
				}
				KeycardScannerPermsIndicator[] permsIndicators = _permsIndicators;
				for (int i = 0; i < permsIndicators.Length; i++)
				{
					permsIndicators[i].PlayAccepted(_animationTime);
				}
				if (_audioSource != null && SeedSynchronizer.TimeSinceMapGeneration > MinimalTimeSinceMapGeneration)
				{
					AudioClip audioClip = (doorStatus ? _openClip : _closeClip);
					if (audioClip != null)
					{
						_audioSource.PlayOneShot(audioClip);
					}
					if (beepClip != null)
					{
						_audioSource.PlayOneShot(beepClip);
					}
				}
				if (IsOpen && !WasEverOpened)
				{
					OnFirstTimeOpen();
					WasEverOpened = true;
				}
				OnDoorStatusSet?.Invoke();
			}
		}

		public void PlayDenied(AudioClip deniedClip, DoorPermissionFlags flags, float cooldown)
		{
			if (AnimatorSet)
			{
				_animator.SetTrigger(DeniedHash);
			}
			TargetCooldown = cooldown;
			_stopwatch.Restart();
			if (_nfcScanner != null)
			{
				_nfcScanner.SetTemporaryDenied(cooldown);
			}
			KeycardScannerPermsIndicator[] permsIndicators = _permsIndicators;
			for (int i = 0; i < permsIndicators.Length; i++)
			{
				permsIndicators[i].PlayDenied(flags, cooldown);
			}
			if (_audioSource != null && deniedClip != null)
			{
				_audioSource.PlayOneShot(deniedClip);
			}
		}

		protected virtual void OnFirstTimeOpen()
		{
			if (!NetworkServer.active)
			{
				return;
			}
			foreach (ItemPickupBase item in Content)
			{
				if (!(item == null))
				{
					PickupSyncInfo info = item.Info;
					info.Locked = false;
					item.NetworkInfo = info;
				}
			}
			if (!SpawnOnFirstChamberOpening)
			{
				return;
			}
			foreach (ItemPickupBase item2 in ToBeSpawned)
			{
				if (!(item2 == null))
				{
					ItemDistributor.SpawnPickup(item2);
				}
			}
		}
	}
}

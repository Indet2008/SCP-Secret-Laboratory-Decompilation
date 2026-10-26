using System;
using System.Diagnostics;
using AudioPooling;
using CustomPlayerEffects;
using Footprinting;
using InventorySystem.Drawers;
using InventorySystem.GUI;
using InventorySystem.Items.Pickups;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using MapGeneration.Holidays;
using Mirror;
using PlayerRoles.FirstPersonControl;
using UnityEngine;
using Utils.Networking;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public class ThrowableItem : ItemBase, IItemDescription, IItemNametag, IItemNickname, IItemAlertDrawer, IItemDrawer, IHolidayItem
	{
		[Serializable]
		public struct ProjectileSettings
		{
			public float StartVelocity;

			public float UpwardsFactor;

			public float TriggerTime;

			public Vector3 StartTorque;

			public Vector3 RelativePosition;
		}

		public ThrownProjectile Projectile;

		public PhantomProjectile Phantom;

		public ProjectileSettings WeakThrowSettings;

		public ProjectileSettings FullThrowSettings;

		public float ThrowingAnimTime;

		public float CancelAnimTime;

		public AudioClip ThrowClip;

		public AudioClip BeginClip;

		public AudioClip CancelClip;

		public readonly Stopwatch ThrowStopwatch = new Stopwatch();

		public readonly Stopwatch CancelStopwatch = new Stopwatch();

		[SerializeField]
		private float _weight;

		[SerializeField]
		private float _pinPullTime;

		[SerializeField]
		private float _postThrownAnimationTime;

		[SerializeField]
		private bool _repickupable;

		private float _destroyTime;

		private bool _tryFire;

		private bool _alreadyFired;

		private bool _fireWeak;

		private bool _phantomPropelled;

		private bool _messageSent;

		private KeyCode _primaryKey;

		private KeyCode _secondaryKey;

		private PhantomProjectile _phantom;

		private Vector3 _releaseSpeed;

		private Scp1853 _scp1853;

		private const float ServerTimeTolerance = 0.8f;

		private const float MaxTraceTime = 0.1f;

		private const float MaxAheadTime = 0.2f;

		private const float HintBlinkRate = 9f;

		private const float HintBlinkStartTime = 1f;

		private const float HintBlinkTotalTime = 0.7f;

		private const ActionName CancelAction = ActionName.Reload;

		private static readonly Stopwatch TriggerDelay = new Stopwatch();

		public override float Weight => _weight;

		public override bool AllowHolster
		{
			get
			{
				if (!ThrowStopwatch.IsRunning)
				{
					if (CancelStopwatch.IsRunning)
					{
						return ReadyToCancel;
					}
					return true;
				}
				return false;
			}
		}

		public AlertContent Alert
		{
			get
			{
				if (!ReadyToThrow || _alreadyFired)
				{
					return default;
				}
				float num = (float)ThrowStopwatch.Elapsed.TotalSeconds;
				float num2 = 1f + ThrowingAnimTime;
				float num3 = num2 + 0.7f;
				bool flag = Mathf.Round(num * 9f) % 2f == 0f;
				if (num < num2 || ((num < num3) & flag))
				{
					return default;
				}
				string obj = "$" + new ReadableKeyCode(CancelKey).NormalVersion + "$";
				return new AlertContent(TranslationReader.GetFormatted("Facility", 41, "Press {0} to cancel the throw.", obj));
			}
		}

		public string Name => ItemTypeId.GetName();

		public string Nickname => ItemTypeId.GetNickname();

		public string Description => ItemTypeId.GetDescription();

		[field: SerializeField]
		public HolidayType[] TargetHolidays { get; set; }

		public RateLimiter BeginThrowRateLimiter { get; private set; }

		public float ScaledThrowElapsed => (float)(ThrowStopwatch.Elapsed.TotalSeconds * (double)SpeedMultiplier);

		public float ScaledCancelElapsed => (float)(CancelStopwatch.Elapsed.TotalSeconds * (double)SpeedMultiplier);

		public bool PendingRemoval => _destroyTime != 0f;

		private float CurrentTimeTolerance
		{
			get
			{
				if (!IsLocalPlayer)
				{
					return 0.8f;
				}
				return 1f;
			}
		}

		private bool ReadyToThrow => ScaledThrowElapsed >= CurrentTimeTolerance * ThrowingAnimTime;

		private bool ReadyToCancel => ScaledCancelElapsed >= CurrentTimeTolerance * CancelAnimTime;

		private KeyCode CancelKey => NewInput.GetKey(ActionName.Reload);

		private float SpeedMultiplier
		{
			get
			{
				if (!_scp1853.IsEnabled)
				{
					return 1f;
				}
				return _scp1853.ItemUsageSpeedMultiplier;
			}
		}

		public event Action<ThrowableNetworkHandler.RequestType> OnRequestSent;

		public override void OnAdded(ItemPickupBase pickup)
		{
			_primaryKey = NewInput.GetKey(ActionName.Shoot);
			_secondaryKey = NewInput.GetKey(ActionName.Zoom);
			_scp1853 = base.Owner.playerEffectsController.GetEffect<Scp1853>();
			BeginThrowRateLimiter = new RateLimiter(0.1f, 1, 0.1f);
		}

		public override void EquipUpdate()
		{
			if (NetworkServer.active)
			{
				UpdateServer();
			}
			if (!IsLocalPlayer)
			{
				return;
			}
			if (!AllowHolster)
			{
				if (_tryFire)
				{
					ClientUpdateTryFire();
				}
				else
				{
					ClientUpdateAiming();
				}
			}
			else
			{
				ClientUpdateIdle();
			}
		}

		public override void OnRemoved(ItemPickupBase pickup)
		{
			if (!NetworkServer.active || pickup == null || _alreadyFired)
			{
				return;
			}
			Vector3 velocity = base.Owner.GetVelocity();
			if (ScaledThrowElapsed < _pinPullTime)
			{
				if (pickup is ThrownProjectile && pickup.TryGetComponent<Rigidbody>(out var component))
				{
					component.linearVelocity = velocity;
				}
			}
			else
			{
				ServerThrow(0f, 0f, velocity, Vector3.zero);
				pickup.Info.Locked = true;
				pickup.DestroySelf();
			}
		}

		public override void OnHolstered()
		{
			if (IsLocalPlayer && !NetworkServer.active)
			{
				_tryFire = false;
				_messageSent = false;
				_alreadyFired = false;
				_phantomPropelled = false;
				ThrowStopwatch.Reset();
			}
		}

		private void ClientUpdatePostFire()
		{
			ProjectileSettings projectileSettings = (_fireWeak ? WeakThrowSettings : FullThrowSettings);
			double totalSeconds = TriggerDelay.Elapsed.TotalSeconds;
			if (!_messageSent && totalSeconds > (double)projectileSettings.TriggerTime - NetworkTime.rtt)
			{
				ThrowableNetworkHandler.RequestType type = (_fireWeak ? ThrowableNetworkHandler.RequestType.ConfirmThrowWeak : ThrowableNetworkHandler.RequestType.ConfirmThrowFullForce);
				_phantom = UnityEngine.Object.Instantiate(Phantom);
				_phantom.Init(base.ItemSerial);
				NetworkClient.Send(new ThrowableNetworkHandler.ThrowableItemRequestMessage(this, type, _releaseSpeed));
				_messageSent = true;
			}
			if (!_phantomPropelled && totalSeconds > (double)projectileSettings.TriggerTime && _phantom != null)
			{
				_phantom.Activate(base.Owner.PlayerCameraReference, projectileSettings.RelativePosition);
				Vector3 velocityVector = GetCameraVector(projectileSettings.UpwardsFactor) * projectileSettings.StartVelocity + _releaseSpeed;
				PropelBody(_phantom.Rigidbody, projectileSettings.StartTorque, velocityVector);
				_phantomPropelled = true;
			}
		}

		private void ClientUpdateTryFire()
		{
			if (_alreadyFired)
			{
				ClientUpdatePostFire();
				return;
			}
			_alreadyFired = true;
			TriggerDelay.Restart();
			PlaySound(BeginClip);
			OnRequestSent?.Invoke(_fireWeak ? ThrowableNetworkHandler.RequestType.ConfirmThrowWeak : ThrowableNetworkHandler.RequestType.ConfirmThrowFullForce);
			if (base.Owner.roleManager.CurrentRole is IFpcRole fpcRole)
			{
				_releaseSpeed = fpcRole.FpcModule.Motor.MoveDirection;
				_releaseSpeed.y = Mathf.Max(_releaseSpeed.y, 0f);
				if (_releaseSpeed.y > 1f)
				{
					_releaseSpeed.y = fpcRole.FpcModule.JumpSpeed;
				}
				_releaseSpeed = ThrowableNetworkHandler.GetLimitedVelocity(_releaseSpeed);
			}
		}

		private void ClientUpdateAiming()
		{
			bool key = Input.GetKey(_primaryKey);
			bool key2 = Input.GetKey(_secondaryKey);
			bool flag = key | key2;
			if (ReadyToThrow)
			{
				if (ClientTryCancel())
				{
					return;
				}
				if (!flag)
				{
					_tryFire = true;
					return;
				}
			}
			if (flag)
			{
				_fireWeak = key2 && !key;
			}
		}

		private void ClientUpdateIdle()
		{
			if (InventoryGuiController.ItemsSafeForInteraction && (Input.GetKeyDown(_primaryKey) || Input.GetKeyDown(_secondaryKey)) && !base.Owner.HasBlock(BlockedInteraction.ItemPrimaryAction))
			{
				ThrowStopwatch.Start();
				CancelStopwatch.Reset();
				PlaySound(BeginClip);
				NetworkClient.Send(new ThrowableNetworkHandler.ThrowableItemRequestMessage(this, ThrowableNetworkHandler.RequestType.BeginThrow));
				OnRequestSent?.Invoke(ThrowableNetworkHandler.RequestType.BeginThrow);
			}
		}

		private bool ClientTryCancel()
		{
			if (!Input.GetKey(CancelKey))
			{
				return false;
			}
			if (CancelAnimTime <= 0f || !ReadyToThrow)
			{
				return false;
			}
			ClientCancel();
			return true;
		}

		private void ClientCancel()
		{
			CancelStopwatch.Start();
			ThrowStopwatch.Reset();
			PlaySound(CancelClip);
			OnRequestSent?.Invoke(ThrowableNetworkHandler.RequestType.CancelThrow);
			NetworkClient.Send(new ThrowableNetworkHandler.ThrowableItemRequestMessage(this, ThrowableNetworkHandler.RequestType.CancelThrow));
		}

		internal void ClientDenyThrow()
		{
			if (_phantom != null)
			{
				UnityEngine.Object.Destroy(_phantom.gameObject);
				_phantom = null;
			}
			_messageSent = false;
			_alreadyFired = false;
			_tryFire = false;
			_phantomPropelled = false;
			ClientCancel();
		}

		private void PlaySound(AudioClip clip)
		{
			AudioSourcePoolManager.Play2D(clip, 1f, MixerChannel.DefaultSfx, SpeedMultiplier);
		}

		private void UpdateServer()
		{
			if (PendingRemoval && Time.timeSinceLevelLoad >= _destroyTime)
			{
				base.OwnerInventory.ServerRemoveItem(base.ItemSerial, null);
			}
		}

		private Vector3 GetCameraVector(float upwardFactor)
		{
			float num = 1f - Mathf.Abs(Vector3.Dot(base.Owner.PlayerCameraReference.forward, Vector3.up));
			Vector3 forward = base.Owner.PlayerCameraReference.forward;
			Vector3 vector = base.Owner.PlayerCameraReference.up * upwardFactor;
			return forward + vector * num;
		}

		private void PropelBody(Rigidbody rb, Vector3 torque, Vector3 velocityVector)
		{
			rb.centerOfMass = Vector3.zero;
			rb.angularVelocity = torque;
			rb.linearVelocity = velocityVector;
		}

		private ThrownProjectile ServerThrow(float forceAmount, float upwardFactor, Vector3 torque, Vector3 startVel)
		{
			if (_alreadyFired && !IsLocalPlayer)
			{
				return null;
			}
			_destroyTime = Time.timeSinceLevelLoad + _postThrownAnimationTime;
			_alreadyFired = true;
			ThrownProjectile thrownProjectile = UnityEngine.Object.Instantiate(Projectile, base.Owner.PlayerCameraReference.position, base.Owner.PlayerCameraReference.rotation);
			PickupSyncInfo networkInfo = new PickupSyncInfo(ItemTypeId, Weight, base.ItemSerial)
			{
				Locked = !_repickupable
			};
			thrownProjectile.NetworkInfo = networkInfo;
			thrownProjectile.PreviousOwner = new Footprint(base.Owner);
			NetworkServer.Spawn(thrownProjectile.gameObject);
			Vector3 vector = GetCameraVector(upwardFactor) * forceAmount + startVel;
			if (thrownProjectile.TryGetComponent<Rigidbody>(out var component))
			{
				PropelBody(component, torque, vector);
			}
			thrownProjectile.ServerOnThrown(torque, vector);
			thrownProjectile.ServerActivate();
			return thrownProjectile;
		}

		public void ServerProcessThrowConfirmation(bool fullForce, Vector3 startPos, Quaternion startRot, Vector3 startVel)
		{
			if (ReadyToThrow && (!_alreadyFired || IsLocalPlayer))
			{
				Transform playerCameraReference = base.Owner.PlayerCameraReference;
				Vector3 position = playerCameraReference.position;
				Quaternion rotation = playerCameraReference.rotation;
				Bounds bounds = base.Owner.GenerateTracerBounds(0.1f, ignoreTeleports: false);
				bounds.Encapsulate(playerCameraReference.position + base.Owner.GetVelocity() * 0.2f);
				playerCameraReference.SetPositionAndRotation(bounds.ClosestPoint(startPos), startRot);
				ProjectileSettings projectileSettings = (fullForce ? FullThrowSettings : WeakThrowSettings);
				startVel = ThrowableNetworkHandler.GetLimitedVelocity(startVel);
				PlayerThrowingProjectileEventArgs e = new PlayerThrowingProjectileEventArgs(base.Owner, this, projectileSettings, fullForce);
				PlayerEvents.OnThrowingProjectile(e);
				if (!e.IsAllowed)
				{
					base.Owner.connectionToClient.Send(new ThrowableNetworkHandler.ThrowableItemCancellationMessage(base.ItemSerial));
					return;
				}
				projectileSettings = e.ProjectileSettings;
				fullForce = e.FullForce;
				ServerLogs.AddLog(ServerLogs.Modules.Throwable, $"{base.Owner.LoggedNameFromRefHub()} threw {ItemTypeId}.", ServerLogs.ServerLogType.GameEvent);
				ThrownProjectile projectile = ServerThrow(projectileSettings.StartVelocity, projectileSettings.UpwardsFactor, projectileSettings.StartTorque, startVel);
				new ThrowableNetworkHandler.ThrowableItemAudioMessage(base.ItemSerial, (!fullForce) ? ThrowableNetworkHandler.RequestType.ConfirmThrowWeak : ThrowableNetworkHandler.RequestType.ConfirmThrowFullForce).SendToAuthenticated();
				playerCameraReference.SetPositionAndRotation(position, rotation);
				PlayerEvents.OnThrewProjectile(new PlayerThrewProjectileEventArgs(base.Owner, this, projectile, projectileSettings, fullForce));
			}
		}

		public void ServerProcessInitiation()
		{
			if (BeginThrowRateLimiter.RateReady && AllowHolster && !base.Owner.HasBlock(BlockedInteraction.ItemPrimaryAction) && (!ItemTypeId.TryGetSpeedMultiplier(base.Owner, out var multiplier) || !(multiplier <= 0f)))
			{
				BeginThrowRateLimiter.RegisterInput();
				ThrowStopwatch.Start();
				CancelStopwatch.Reset();
				new ThrowableNetworkHandler.ThrowableItemAudioMessage(base.ItemSerial, ThrowableNetworkHandler.RequestType.BeginThrow).SendToAuthenticated();
			}
		}

		public void ServerProcessCancellation()
		{
			if (ReadyToThrow && !_alreadyFired && !CancelStopwatch.IsRunning && !(CancelAnimTime <= 0f))
			{
				CancelStopwatch.Start();
				ThrowStopwatch.Reset();
				new ThrowableNetworkHandler.ThrowableItemAudioMessage(base.ItemSerial, ThrowableNetworkHandler.RequestType.CancelThrow).SendToAuthenticated();
			}
		}
	}
}

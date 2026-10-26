using CustomPlayerEffects;
using GameObjectPools;
using InventorySystem.Items;
using Mirror;
using PlayerRoles.FirstPersonControl.Spawnpoints;
using PlayerRoles.Ragdolls;
using PlayerRoles.SpawnData;
using PlayerRoles.Spectating;
using PlayerRoles.Visibility;
using PlayerRoles.Voice;
using PlayerStatsSystem;
using RelativePositioning;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl
{
	public abstract class FpcStandardRoleBase : PlayerRoleBase, ISpawnDataReader, IPrivateSpawnDataWriter, IPublicSpawnDataWriter, IHealthbarRole, IRagdollRole, IFpcRole, IPoolSpawnable, ICameraController, IAvatarRole, ISpectatableRole, IVoiceRole, ICustomVisibilityRole, IViewmodelRole, IAmbientLightRole, IAFKRole
	{
		private Vector3 _lastPos;

		private const float PositionalTolerance = 1.25f;

		private Transform _hubTransform;

		private Transform _cameraTransform;

		private InsufficientLighting _noLightFx;

		public virtual Vector3 CameraPosition => _cameraTransform.position;

		public virtual float VerticalRotation => _cameraTransform.eulerAngles.x;

		public virtual float HorizontalRotation => _cameraTransform.eulerAngles.y;

		public virtual PlayerStats TargetStats
		{
			get
			{
				if (!TryGetOwner(out var hub))
				{
					return null;
				}
				return hub.playerStats;
			}
		}

		public abstract float MaxHealth { get; }

		public abstract ISpawnpointHandler SpawnpointHandler { get; }

		public virtual float AmbientBoost
		{
			get
			{
				float num = (ForceBlackAmbient ? 0f : InsufficientLighting.DefaultIntensity);
				if (!TryGetOwner(out var hub))
				{
					return num;
				}
				StatusEffectBase[] allEffects = hub.playerEffectsController.AllEffects;
				for (int i = 0; i < allEffects.Length; i++)
				{
					if (allEffects[i] is IAmbientBoostingEffect ambientBoostingEffect)
					{
						num += ambientBoostingEffect.AmbientBoostAddition;
					}
				}
				return num;
			}
		}

		public virtual bool ForceBlackAmbient
		{
			get
			{
				if (!InsufficientLight)
				{
					return InDarkness;
				}
				return true;
			}
		}

		public virtual bool InsufficientLight
		{
			get
			{
				if (!NetworkServer.active)
				{
					return _noLightFx.IsEnabled;
				}
				if (InDarkness)
				{
					return !HasFlashlight;
				}
				return false;
			}
		}

		[field: SerializeField]
		public FirstPersonMovementModule FpcModule { get; private set; }

		[field: SerializeField]
		public SpectatableModuleBase SpectatorModule { get; private set; }

		[field: SerializeField]
		public VoiceModuleBase VoiceModule { get; private set; }

		[field: SerializeField]
		public VisibilityController VisibilityController { get; private set; }

		[field: SerializeField]
		public BasicRagdoll Ragdoll { get; private set; }

		[field: SerializeField]
		public Texture RoleAvatar { get; private set; }

		private bool InDarkness => RoomLightController.IsInDarkenedRoom(FpcModule.Position);

		private bool HasFlashlight
		{
			get
			{
				if (!TryGetOwner(out var hub))
				{
					return false;
				}
				if (hub.inventory.CurInstance is ILightEmittingItem lightEmittingItem && lightEmittingItem != null)
				{
					return lightEmittingItem.IsEmittingLight;
				}
				return false;
			}
		}

		public bool IsAFK
		{
			get
			{
				if (_lastPos == Vector3.zero)
				{
					_lastPos = _hubTransform.position;
					return true;
				}
				if ((_lastPos - _hubTransform.position).sqrMagnitude < 1.25f)
				{
					return true;
				}
				_lastPos = _hubTransform.position;
				return false;
			}
		}

		protected virtual void ShowStartScreen()
		{
			if (base.IsLocalPlayer)
			{
				StartScreen.Show(this);
			}
		}

		internal override void Init(ReferenceHub hub, RoleChangeReason spawnReason, RoleSpawnFlags spawnFlags)
		{
			base.Init(hub, spawnReason, spawnFlags);
			_noLightFx = hub.playerEffectsController.GetEffect<InsufficientLighting>();
			_lastPos = Vector3.zero;
		}

		public virtual void ReadSpawnData(NetworkReader reader)
		{
			RelativePosition receivedPosition = reader.ReadRelativePosition();
			FpcModule.MouseLook.ApplySyncValues(reader.ReadUShort(), 32767);
			if (receivedPosition.WaypointId == 0)
			{
				return;
			}
			if (!base.IsLocalPlayer)
			{
				FpcMotor motor = FpcModule.Motor;
				if (motor.ReceivedPosition.WaypointId != 0)
				{
					return;
				}
				motor.ReceivedPosition = receivedPosition;
			}
			FpcModule.Position = receivedPosition.Position;
		}

		public virtual void WritePublicSpawnData(NetworkWriter writer)
		{
			FpcModule.MouseLook.GetSyncValues(0, out var syncH, out var _);
			writer.WriteRelativePosition(new RelativePosition(_hubTransform.position));
			writer.WriteUShort(syncH);
		}

		public virtual void WritePrivateSpawnData(NetworkWriter writer)
		{
		}

		public virtual void SpawnObject()
		{
			if (TryGetOwner(out var hub))
			{
				_hubTransform = hub.transform;
				_cameraTransform = hub.PlayerCameraReference;
				ShowStartScreen();
			}
		}

		public virtual bool TryGetViewmodelFov(out float fov)
		{
			fov = 0f;
			if (!TryGetOwner(out var hub))
			{
				return false;
			}
			ItemBase curInstance = hub.inventory.CurInstance;
			if (curInstance == null || curInstance.ViewModel == null)
			{
				return false;
			}
			fov = curInstance.ViewModel.ViewmodelCameraFOV;
			return true;
		}
	}
}

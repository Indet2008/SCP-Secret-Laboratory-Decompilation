using System;
using System.Collections.Generic;
using GameObjectPools;
using Interactables.Interobjects.DoorUtils;
using MapGeneration;
using PlayerRoles.PlayableScps.HUDs;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using PlayerRoles.Spectating;
using PlayerRoles.Subroutines;
using PlayerRoles.Voice;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079
{
	public class Scp079Role : PlayerRoleBase, ISubroutinedRole, ISpectatableRole, ISpawnableScp, ITeslaControllerRole, IAdvancedCameraController, ICameraController, IPoolResettable, IPoolSpawnable, IVoiceRole, IAvatarRole, IHudScp, IAmbientLightRole, IAFKRole, IDoorPermissionProvider
	{
		public static readonly HashSet<Scp079Role> ActiveInstances = new HashSet<Scp079Role>();

		private Scp079CurrentCameraSync _curCamSync;

		private Vector3 _lastAFKCamPos;

		public static Scp079Role LocalInstance { get; private set; }

		public static bool LocalInstanceActive { get; private set; }

		[field: SerializeField]
		public ScpHudBase HudPrefab { get; private set; }

		[field: SerializeField]
		public SubroutineManagerModule SubroutineModule { get; private set; }

		[field: SerializeField]
		public VoiceModuleBase VoiceModule { get; private set; }

		[field: SerializeField]
		public Texture RoleAvatar { get; private set; }

		[field: SerializeField]
		public SpectatableModuleBase SpectatorModule { get; private set; }

		public override RoleTypeId RoleTypeId => RoleTypeId.Scp079;

		public override Team Team => Team.SCPs;

		public override Color RoleColor => Color.red;

		public Vector3 CameraPosition { get; private set; }

		public float VerticalRotation { get; private set; }

		public float HorizontalRotation { get; private set; }

		public float RollRotation { get; private set; }

		public Scp079Camera CurrentCamera => _curCamSync.CurrentCamera;

		public bool IsSpectated
		{
			get
			{
				if (SpectatorTargetTracker.TryGetTrackedPlayer(out var hub))
				{
					return hub.roleManager.CurrentRole == this;
				}
				return false;
			}
		}

		public float AmbientBoost => 0f;

		public bool ForceBlackAmbient => false;

		public bool InsufficientLight => false;

		public PermissionUsed PermissionsUsedCallback => null;

		public bool IsAFK
		{
			get
			{
				if (!_curCamSync.TryGetCurrentCamera(out var cam))
				{
					return false;
				}
				if (_lastAFKCamPos == Vector3.zero)
				{
					_lastAFKCamPos = cam.CameraPosition;
				}
				Vector3 cameraPosition = cam.CameraPosition;
				if (cameraPosition == _lastAFKCamPos)
				{
					return true;
				}
				_lastAFKCamPos = cameraPosition;
				return false;
			}
		}

		public bool CanActivateShock { get; }

		public DoorPermissionFlags GetPermissions(IDoorPermissionRequester requester)
		{
			if (!(requester is DoorVariant))
			{
				return DoorPermissionFlags.None;
			}
			return DoorPermissionFlags.All;
		}

		public float GetSpawnChance(List<RoleTypeId> alreadySpawned)
		{
			int count = alreadySpawned.Count;
			return (count != 0 && !alreadySpawned.Contains(RoleTypeId.Scp096)) ? count : 0;
		}

		public bool IsInIdleRange(TeslaGate teslaGate)
		{
			if (!SubroutineModule.TryGetSubroutine<Scp079CurrentCameraSync>(out var subroutine))
			{
				return false;
			}
			if (!subroutine.TryGetCurrentCamera(out var cam))
			{
				return false;
			}
			return cam.Position.CompareCoords(teslaGate.Position);
		}

		public void ResetObject()
		{
			ActiveInstances.Remove(this);
			_lastAFKCamPos = Vector3.zero;
		}

		public void SpawnObject()
		{
			ActiveInstances.Add(this);
			if (!TryGetOwner(out var hub))
			{
				throw new InvalidOperationException("SCP-079 role failed to spawn - owner is null");
			}
			float num = 6000f;
			hub.transform.position = Vector3.up * num;
			_lastAFKCamPos = Vector3.zero;
		}

		private void Awake()
		{
			SubroutineModule.TryGetSubroutine<Scp079CurrentCameraSync>(out _curCamSync);
			MainCameraController.OnBeforeUpdated += SetCameraPoseData;
		}

		private void OnDestroy()
		{
			ActiveInstances.Remove(this);
			MainCameraController.OnBeforeUpdated -= SetCameraPoseData;
		}

		private void SetCameraPoseData()
		{
			if (!base.Pooled && _curCamSync.TryGetCurrentCamera(out var cam))
			{
				CameraPosition = cam.CameraPosition;
				VerticalRotation = cam.VerticalRotation;
				HorizontalRotation = cam.HorizontalRotation;
				RollRotation = cam.RollRotation;
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			PlayerRoleManager.OnRoleChanged += (ReferenceHub x, PlayerRoleBase y, PlayerRoleBase z) =>
			{
				if (x.isLocalPlayer)
				{
					if (z is Scp079Role localInstance)
					{
						LocalInstance = localInstance;
						LocalInstanceActive = true;
					}
					else
					{
						LocalInstanceActive = false;
					}
				}
			};
		}
	}
}

using System;
using CursorManagement;
using GameObjectPools;
using Mirror;
using NetworkManagerUtils.Dummies;
using PlayerRoles.FirstPersonControl.NetworkMessages;
using PlayerRoles.FirstPersonControl.Thirdperson;
using RelativePositioning;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace PlayerRoles.FirstPersonControl
{
	public class FirstPersonMovementModule : MonoBehaviour, IPoolSpawnable, IPoolResettable, ICursorOverride, IRootDummyActionProvider, IChildWaypointObject
	{
		public Action OnServerPositionOverwritten;

		public Action OnGrounded;

		public GameObject CharacterModelTemplate;

		public float CrouchSpeed;

		public float SneakSpeed;

		public float WalkSpeed;

		public float SprintSpeed;

		public float JumpSpeed;

		public CharacterControllerSettingsPreset CharacterControllerSettings;

		public FallDamageSettings FallDamageSettings;

		public float CrouchHeightRatio;

		private Transform _transform;

		private PlayerMovementState _speedState;

		private bool _syncGrounded;

		private Vector3 _cachedPosition;

		private RelativePosition _relativePosition;

		private static bool _movementUpdateCycle;

		private static Action _activeUpdates;

		public virtual CursorOverrideMode CursorOverride => CursorOverrideMode.Centered;

		public virtual bool LockMovement => false;

		public CharacterController CharController { get; private set; }

		public bool CharControllerSet { get; private set; }

		public bool ModuleReady { get; private set; }

		public FpcMotor Motor { get; protected set; }

		public FpcNoclip Noclip { get; protected set; }

		public FpcMouseLook MouseLook { get; protected set; }

		public FpcStateProcessor StateProcessor { get; protected set; }

		public MovementTracer Tracer { get; private set; }

		public CharacterModel CharacterModelInstance { get; protected set; }

		public FpcSyncData LastSentData { get; internal set; }

		public float MaxMovementSpeed => VelocityForState(ValidateMovementState(_speedState), applyCrouch: true);

		public PlayerMovementState CurrentMovementState
		{
			get
			{
				return ValidateMovementState(SyncMovementState);
			}
			set
			{
				SyncMovementState = value;
			}
		}

		public PlayerMovementState SyncMovementState { get; private set; }

		public bool IsGrounded
		{
			get
			{
				if (CharControllerSet ? CharController.isGrounded : _syncGrounded)
				{
					return !Noclip.IsActive;
				}
				return false;
			}
			set
			{
				if (_syncGrounded != value)
				{
					_syncGrounded = value;
					if (value)
					{
						OnGrounded?.Invoke();
					}
				}
			}
		}

		public Vector3 Position
		{
			get
			{
				return _cachedPosition;
			}
			set
			{
				_transform.position = value;
				_cachedPosition = value;
				if (!_movementUpdateCycle && ModuleReady)
				{
					CharacterModelInstance.OnPlayerMove();
				}
			}
		}

		public RelativePosition RelativePosition
		{
			get
			{
				return _relativePosition;
			}
			private set
			{
				if (_relativePosition.WaypointId != value.WaypointId)
				{
					OnWaypointChanged(_relativePosition.WaypointId, value.WaypointId);
				}
				_relativePosition = value;
			}
		}

		protected ReferenceHub Hub { get; private set; }

		protected PlayerRoleBase Role { get; private set; }

		protected virtual FpcMotor NewMotor => new FpcMotor(Hub, this, FallDamageSettings);

		protected virtual FpcNoclip NewNoclip => new FpcNoclip(Hub, this);

		protected virtual FpcMouseLook NewMouseLook => new FpcMouseLook(Hub, this);

		protected virtual FpcStateProcessor NewStateProcessor => new FpcStateProcessor(Hub, this);

		public bool DummyActionsDirty { get; set; }

		public static event Action OnPositionUpdated;

		protected virtual void UpdateMovement()
		{
			if (Hub == null)
			{
				ResetObject();
				return;
			}
			SyncMovementState = StateProcessor.UpdateMovementState(CurrentMovementState);
			Motor.UpdatePosition(out var sendJump);
			Noclip.UpdateNoclip();
			MouseLook.UpdateRotation();
			UpdateRelativePosition();
			if (SyncMovementState != PlayerMovementState.Crouching)
			{
				_speedState = SyncMovementState;
			}
			if (Hub.isLocalPlayer)
			{
				float walkSpeed = VelocityForState(PlayerMovementState.Walking, applyCrouch: false);
				StateProcessor.ClientUpdateInput(this, walkSpeed, out var valueToSend);
				Motor.ReceivedPosition = RelativePosition;
				NetworkClient.Send(new FpcFromClientMessage(Motor.ReceivedPosition, valueToSend, sendJump, MouseLook));
			}
			CharacterModelInstance.OnPlayerMove();
		}

		private void UpdateRelativePosition()
		{
			if (Hub.isLocalPlayer || NetworkServer.active)
			{
				RelativePosition = new RelativePosition(Position);
			}
			else
			{
				RelativePosition = Motor.ReceivedPosition;
			}
		}

		private void OnWaypointChanged(byte oldId, byte newId)
		{
			if (WaypointBase.TryGetWaypoint(oldId, out IMovableWaypoint wp))
			{
				wp.Remove(this);
			}
			if (WaypointBase.TryGetWaypoint(newId, out wp))
			{
				wp.Add(this);
			}
		}

		private void FixedUpdate()
		{
			if (NetworkServer.active)
			{
				Tracer.Record(Position);
			}
		}

		private void OnRoleDisabled(RoleTypeId rid)
		{
			CharControllerSet = false;
			CharacterModelInstance.ReturnToPool();
			Noclip.ShutdownModule();
		}

		protected virtual PlayerMovementState ValidateMovementState(PlayerMovementState state)
		{
			switch (state)
			{
			case PlayerMovementState.Crouching:
				if (CrouchSpeed != 0f)
				{
					break;
				}
				goto IL_0045;
			case PlayerMovementState.Sneaking:
				if (SneakSpeed != 0f)
				{
					break;
				}
				goto IL_0045;
			case PlayerMovementState.Sprinting:
				{
					if (SprintSpeed != 0f)
					{
						break;
					}
					goto IL_0045;
				}
				IL_0045:
				return PlayerMovementState.Walking;
			}
			return state;
		}

		public void ServerOverridePosition(Vector3 position)
		{
			Position = position;
			Motor.ReceivedPosition = new RelativePosition(position);
			Hub.CurrentRoomPlayerCache.ForceUnvalidate();
			Hub.connectionToClient.Send(new FpcPositionOverrideMessage(position));
			OnServerPositionOverwritten();
		}

		public void ServerOverrideRotation(Vector2 rotation)
		{
			MouseLook.CurrentVertical = rotation.x;
			MouseLook.CurrentHorizontal = rotation.y;
			Hub.connectionToClient.Send(new FpcRotationOverrideMessage(rotation));
		}

		public virtual float VelocityForState(PlayerMovementState state, bool applyCrouch)
		{
			float num = 0f;
			switch (state)
			{
			case PlayerMovementState.Crouching:
				num = CrouchSpeed;
				break;
			case PlayerMovementState.Sneaking:
				num = SneakSpeed;
				break;
			case PlayerMovementState.Sprinting:
				num = SprintSpeed * Hub.inventory.SprintSpeedMultiplier;
				break;
			case PlayerMovementState.Walking:
				num = WalkSpeed;
				break;
			}
			if (applyCrouch)
			{
				num = Mathf.Lerp(num, CrouchSpeed, StateProcessor.CrouchPercent);
			}
			num *= Hub.inventory.MovementSpeedMultiplier;
			float num2 = Hub.inventory.MovementSpeedLimit;
			for (int i = 0; i < Hub.playerEffectsController.EffectsLength; i++)
			{
				if (Hub.playerEffectsController.AllEffects[i] is IMovementSpeedModifier { MovementModifierActive: not false } movementSpeedModifier)
				{
					num2 = Mathf.Min(num2, movementSpeedModifier.MovementSpeedLimit);
					num *= movementSpeedModifier.MovementSpeedMultiplier;
				}
			}
			float num3 = Mathf.Sign(num);
			return Mathf.Min(Mathf.Abs(num), num2) * num3;
		}

		public void OnWaypointMoved(Transform transform, Vector3 deltaPos, Quaternion deltaRot)
		{
			bool movementUpdateCycle = _movementUpdateCycle;
			_movementUpdateCycle = true;
			Vector3 vector = Position + deltaPos;
			Position = deltaRot * (vector - transform.position) + transform.position;
			if (Hub.isLocalPlayer || Hub.IsDummy)
			{
				MouseLook.CurrentHorizontal += deltaRot.eulerAngles.y;
			}
			if (Hub.isLocalPlayer)
			{
				Hub.transform.rotation = Quaternion.Euler(Vector3.up * MouseLook.CurrentHorizontal);
				MainCameraController.ForceUpdatePosition();
			}
			_movementUpdateCycle = movementUpdateCycle;
		}

		public virtual void SpawnObject()
		{
			if (!TryGetComponent<PlayerRoleBase>(out var component) || !component.TryGetOwner(out var hub))
			{
				throw new InvalidOperationException("Movement module failed to initiate. Unable to find owner of the role.");
			}
			_activeUpdates = (Action)Delegate.Combine(_activeUpdates, new Action(UpdateMovement));
			Hub = hub;
			Role = component;
			_transform = Hub.transform;
			_cachedPosition = base.transform.position;
			_speedState = PlayerMovementState.Walking;
			SyncMovementState = PlayerMovementState.Walking;
			if (NetworkServer.active || Hub.isLocalPlayer)
			{
				CharController = Hub.GetComponent<CharacterController>();
				CharacterControllerSettings.Apply(CharController);
				CharControllerSet = true;
				if (NetworkServer.active)
				{
					Tracer = new MovementTracer(15, 3, 50f);
				}
			}
			else
			{
				CharControllerSet = false;
			}
			Motor = NewMotor;
			Noclip = NewNoclip;
			MouseLook = NewMouseLook;
			StateProcessor = NewStateProcessor;
			if (NetworkServer.active || Hub.isLocalPlayer)
			{
				Motor.RegisterMovementLock(this);
			}
			PlayerRoleBase role = Role;
			role.OnRoleDisabled = (Action<RoleTypeId>)Delegate.Combine(role.OnRoleDisabled, new Action<RoleTypeId>(OnRoleDisabled));
			SetModel(CharacterModelTemplate);
			ModuleReady = true;
		}

		protected virtual void SetModel(GameObject template)
		{
			if (PoolManager.Singleton.TryGetPoolObject(template, null, out var poolObject) && poolObject is CharacterModel characterModel)
			{
				SceneManager.MoveGameObjectToScene(poolObject.gameObject, SceneManager.GetActiveScene());
				CharacterModelInstance = characterModel;
				Transform transform = template.transform;
				characterModel.Setup(Hub, Role as IFpcRole, transform.localPosition, transform.localRotation);
				characterModel.transform.SetParent(Hub.transform, worldPositionStays: false);
			}
			else
			{
				Debug.LogError("Can't spawn '" + template.name + "' - FPC models must derive from CharacterModel.");
			}
		}

		public virtual void ResetObject()
		{
			if (Motor != null)
			{
				Motor.CleanupMovementLocks();
			}
			_activeUpdates = (Action)Delegate.Remove(_activeUpdates, new Action(UpdateMovement));
			PlayerRoleBase role = Role;
			role.OnRoleDisabled = (Action<RoleTypeId>)Delegate.Remove(role.OnRoleDisabled, new Action<RoleTypeId>(OnRoleDisabled));
			RelativePosition = default;
			ModuleReady = false;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			StaticUnityMethods.OnUpdate += () =>
			{
				if (_activeUpdates != null)
				{
					_movementUpdateCycle = true;
					_activeUpdates();
					_movementUpdateCycle = false;
					OnPositionUpdated?.Invoke();
				}
			};
		}

		public void PopulateDummyActions(Action<DummyAction> actionAdder, Action<string> categoryAdder)
		{
			DummyActionsDirty = false;
			categoryAdder("MouseLook");
			MouseLook.PopulateDummyActions(actionAdder);
			categoryAdder("Motor");
			Motor.PopulateDummyActions(actionAdder);
			categoryAdder("FpcJumpController");
			Motor.JumpController.PopulateDummyActions(actionAdder);
		}
	}
}

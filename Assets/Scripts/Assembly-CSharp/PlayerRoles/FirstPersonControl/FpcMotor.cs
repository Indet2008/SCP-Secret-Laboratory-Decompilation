using System;
using System.Collections.Generic;
using System.Diagnostics;
using CursorManagement;
using InventorySystem.Items;
using Mirror;
using NetworkManagerUtils.Dummies;
using PlayerRoles.FirstPersonControl.NetworkMessages;
using PlayerRoles.PlayableScps.Scp106;
using PlayerStatsSystem;
using RelativePositioning;
using UnityEngine;
using Utils.Networking;

namespace PlayerRoles.FirstPersonControl
{
	public class FpcMotor : IDummyActionProvider
	{
		protected enum FpcViewMode
		{
			LocalPlayer = 0,
			Server = 1,
			Thirdperson = 2
		}

		public static readonly Vector3 InvisiblePosition = Vector3.up * 6000f;

		public readonly ReferenceHub Hub;

		public readonly FirstPersonMovementModule MainModule;

		protected readonly Transform CachedTransform;

		protected readonly FpcViewMode ViewMode;

		public readonly FpcGravityController GravityController;

		public readonly FpcScaleController ScaleController;

		public readonly FpcJumpController JumpController;

		private const float JumpToStepOffsetRatio = 0.35f;

		private const float StepDiffMultiplier = 1.6f;

		private const float MinMoveDiff = 0.03f;

		private const float PositionOverrideAbsTolerance = 0.5f;

		private const float PositionOverrideCooldown = 0.4f;

		private const float ThirdpersonLerpMultiplier = 2f;

		private const float ThirdpersonHeightLerp = 9f;

		private const float ThirdpersonMinSpeed = 3f;

		private const float MovementLockOverrideTolerance = 0.1f;

		private const float MovementOverrideGracePeriod = 0.1f;

		private const float MovementOverrideGracePeriodCooldown = 1f;

		private float _lastMaxSpeed;

		private float _maxFallSpeed;

		private static KeyCode _keyFwd;

		private static KeyCode _keyBwd;

		private static KeyCode _keyLft;

		private static KeyCode _keyRgt;

		private static bool _reloadKeysEventSet;

		private readonly Stopwatch _lastOverrideTime;

		private readonly Stopwatch _fallDamageImmunity;

		private readonly FallDamageSettings _fallDamageSettings;

		private readonly float _defaultStepOffset;

		private readonly float _defaultHeight;

		private readonly List<ICursorOverride> _cursorOverrides = new List<ICursorOverride>();

		private double _lastOverrideGracePeriod;

		public Vector3 MoveDirection { get; set; }

		public virtual Vector3 Velocity { get; private set; }

		public bool IsInvisible { get; set; }

		public RelativePosition ReceivedPosition { get; set; }

		public bool MovementDetected { get; set; }

		public bool RotationDetected { get; set; }

		protected virtual float Speed => MainModule.MaxMovementSpeed;

		protected virtual Vector3 DesiredMove
		{
			get
			{
				if (ViewMode == FpcViewMode.LocalPlayer)
				{
					if (TryGetOverride(out var overrideDir))
					{
						return overrideDir;
					}
					if (InputLocked)
					{
						return Vector3.zero;
					}
					float num = 0f;
					float num2 = 0f;
					if (Input.GetKey(_keyFwd))
					{
						num2++;
					}
					if (Input.GetKey(_keyBwd))
					{
						num2--;
					}
					if (Input.GetKey(_keyRgt))
					{
						num++;
					}
					if (Input.GetKey(_keyLft))
					{
						num--;
					}
					Vector3 vector = CachedTransform.forward * num2;
					Vector3 vector2 = CachedTransform.right * num;
					Vector3 vector3 = vector + vector2;
					if (!InputInverted)
					{
						return vector3;
					}
					return -vector3;
				}
				Vector3 position = ReceivedPosition.Position;
				Vector3 vector4 = position - Position;
				if (NetworkServer.active)
				{
					float num3 = Mathf.Clamp(vector4.y * 1.6f, 0f, 0.35f * MainModule.JumpSpeed);
					MainModule.CharController.stepOffset = Mathf.Min(_defaultStepOffset + num3, _defaultHeight);
					if (MainModule.Noclip.RecentlyActive)
					{
						Position = position;
						return Vector3.zero;
					}
					bool movementLocked = MovementLocked;
					if (movementLocked && NetworkTime.time > _lastOverrideGracePeriod + 1.0)
					{
						_lastOverrideGracePeriod = NetworkTime.time;
					}
					if (movementLocked && NetworkTime.time > _lastOverrideGracePeriod + 0.10000000149011612)
					{
						if (Vector3.Distance(Position, position) >= 0.1f)
						{
							MainModule.ServerOverridePosition(Position);
						}
						return Vector3.zero;
					}
				}
				float num4 = vector4.MagnitudeIgnoreY();
				if (num4 < 0.03f)
				{
					return Vector3.zero;
				}
				num4 -= 0.5f;
				if (num4 < _lastMaxSpeed && Mathf.Abs(vector4.y) < Mathf.Max(MainModule.JumpSpeed, Mathf.Abs(MoveDirection.y)))
				{
					if (!NetworkServer.active)
					{
						return vector4;
					}
					return new Vector3(vector4.x, 0f, vector4.z);
				}
				if (NetworkServer.active)
				{
					if (_lastOverrideTime.Elapsed.TotalSeconds > 0.4000000059604645)
					{
						MainModule.ServerOverridePosition(Position);
					}
				}
				else
				{
					Position = position;
				}
				return Vector3.zero;
			}
		}

		public Vector3 Position
		{
			get
			{
				return MainModule.Position;
			}
			set
			{
				MainModule.Position = value;
			}
		}

		public bool InputLocked => CursorManager.MovementLocked;

		public bool InputInverted => Speed < 0f;

		public bool MovementLocked
		{
			get
			{
				if (TryGetOverride(out var overrideDir))
				{
					return overrideDir == Vector3.zero;
				}
				return false;
			}
		}

		public event Action<Vector3> OnBeforeMove;

		public FpcMotor(ReferenceHub hub, FirstPersonMovementModule module, FallDamageSettings fallDamageSettings)
		{
			Hub = hub;
			MainModule = module;
			GravityController = new FpcGravityController(this);
			ScaleController = new FpcScaleController(this);
			JumpController = new FpcJumpController(this);
			_fallDamageSettings = fallDamageSettings;
			CachedTransform = hub.transform;
			if (NetworkServer.active)
			{
				_lastOverrideTime = Stopwatch.StartNew();
				_fallDamageImmunity = Stopwatch.StartNew();
				module.OnServerPositionOverwritten = (Action)Delegate.Combine(module.OnServerPositionOverwritten, (Action)(() =>
				{
					_lastOverrideTime.Restart();
				}));
				_defaultStepOffset = module.CharController.stepOffset;
				_defaultHeight = module.CharController.height;
			}
			if (Hub.isLocalPlayer)
			{
				ViewMode = FpcViewMode.LocalPlayer;
				ReloadInputConfigs();
				if (!_reloadKeysEventSet)
				{
					NewInput.OnAnyModified += ReloadInputConfigs;
					_reloadKeysEventSet = true;
				}
			}
			else
			{
				ViewMode = (NetworkServer.active ? FpcViewMode.Server : FpcViewMode.Thirdperson);
			}
		}

		public void RegisterMovementLock(ICursorOverride cursorOverride)
		{
			_cursorOverrides.Add(cursorOverride);
			if (Hub.isLocalPlayer)
			{
				CursorManager.Register(cursorOverride);
			}
		}

		public void UnregisterMovementLock(ICursorOverride cursorOverride)
		{
			_cursorOverrides.Remove(cursorOverride);
			if (Hub.isLocalPlayer)
			{
				CursorManager.Unregister(cursorOverride);
			}
		}

		public void CleanupMovementLocks()
		{
			foreach (ICursorOverride cursorOverride in _cursorOverrides)
			{
				CursorManager.Unregister(cursorOverride);
			}
			_cursorOverrides.Clear();
		}

		public void UpdatePosition(out bool sendJump)
		{
			sendJump = false;
			_lastMaxSpeed = Mathf.Abs(Speed);
			if (MainModule.Noclip.IsActive)
			{
				MoveDirection = Vector3.zero;
				return;
			}
			if (ViewMode == FpcViewMode.Thirdperson)
			{
				UpdateThirdperson();
				return;
			}
			CharacterController charController = MainModule.CharController;
			Physics.SphereCast(Position, charController.radius, Vector3.down, out var hitInfo, charController.height / 2f, FpcStateProcessor.Mask, QueryTriggerInteraction.Ignore);
			Vector3 normalized = Vector3.ProjectOnPlane(DesiredMove, hitInfo.normal).normalized;
			MoveDirection = new Vector3(normalized.x * _lastMaxSpeed, MoveDirection.y, normalized.z * _lastMaxSpeed);
			if (charController.isGrounded)
			{
				UpdateGrounded(ref sendJump, MainModule.JumpSpeed);
			}
			else
			{
				UpdateFloating();
			}
		}

		public void ResetFallDamageCooldown()
		{
			_fallDamageImmunity.Restart();
		}

		protected virtual Vector3 GetFrameMove()
		{
			if (MainModule.Noclip.IsActive)
			{
				return Vector3.zero;
			}
			Vector3 result = MoveDirection * Time.deltaTime;
			if (ViewMode != FpcViewMode.LocalPlayer)
			{
				Vector3 position = ReceivedPosition.Position;
				Vector3 position2 = Position;
				result.x = ClampMoveDirection(position2.x, position.x, result.x);
				result.z = ClampMoveDirection(position2.z, position.z, result.z);
			}
			return result;
		}

		public virtual void Move()
		{
			CharacterController charController = MainModule.CharController;
			Vector3 position = Position;
			Vector3 frameMove = GetFrameMove();
			OnBeforeMove?.Invoke(frameMove);
			charController.Move(frameMove);
			Position = CachedTransform.position;
			MovementDetected = Position != position;
			Velocity = (Position - position) / Time.deltaTime;
			MainModule.IsGrounded = charController.isGrounded;
		}

		public virtual void UpdateGrounded(ref bool sendJump, float jumpSpeed)
		{
			Vector3 moveDirection = MoveDirection;
			bool num = JumpController.ProcessJump(ref sendJump, jumpSpeed, out var yVelocity);
			moveDirection.y = yVelocity;
			MoveDirection = moveDirection;
			if (_fallDamageSettings.Enabled && _maxFallSpeed > _fallDamageSettings.MinVelocity)
			{
				ServerProcessFall(_maxFallSpeed - _fallDamageSettings.MinVelocity);
			}
			_maxFallSpeed = _fallDamageSettings.MinVelocity;
			if (num)
			{
				UpdateFloating();
				return;
			}
			Move();
			if (!MainModule.CharController.isGrounded)
			{
				MoveDirection = Vector3.Scale(MoveDirection, new Vector3(1f, 0f, 1f));
			}
		}

		public virtual void UpdateFloating()
		{
			Vector3 vector = 0.5f * Time.deltaTime * GravityController.Gravity;
			MoveDirection += vector;
			Move();
			MoveDirection += vector;
			_maxFallSpeed = Mathf.Max(_maxFallSpeed, 0f - MoveDirection.y);
		}

		private static float ClampMoveDirection(float curPos, float targetPos, float moveDir)
		{
			float num = Mathf.Abs(curPos - targetPos);
			return Mathf.Clamp(moveDir, 0f - num, num);
		}

		private void UpdateThirdperson()
		{
			if (IsInvisible)
			{
				Position = InvisiblePosition;
				return;
			}
			Vector3 desiredMove = DesiredMove;
			Vector3 position = ReceivedPosition.Position;
			Vector3 position2 = Position;
			Vector3 b = new Vector3(position.x, position2.y, position.z);
			float num = Time.deltaTime * Mathf.Max(3f, _lastMaxSpeed);
			Vector3 vector = Vector3.Lerp(position2, b, num * 2f);
			vector.y = Mathf.Lerp(vector.y, position.y, 9f * Time.deltaTime);
			Position = vector;
			Velocity = (vector - position2) / Time.deltaTime;
			MoveDirection = new Vector3(desiredMove.x, 0f, desiredMove.z).normalized * _lastMaxSpeed + Vector3.up * desiredMove.y;
		}

		private void ServerProcessFall(float speed)
		{
			if (!NetworkServer.active || _fallDamageImmunity.Elapsed.TotalSeconds < (double)_fallDamageSettings.ImmunityTime)
			{
				return;
			}
			PlayerRoleBase currentRole = Hub.roleManager.CurrentRole;
			if (!(currentRole is Scp106Role { IsStalking: not false }))
			{
				RoleTypeId roleTypeId = currentRole.RoleTypeId;
				Vector3 position = Position;
				float damage = _fallDamageSettings.CalculateDamage(speed);
				if (Hub.playerStats.DealDamage(new UniversalDamageHandler(damage, DeathTranslations.Falldown)))
				{
					new FpcFallDamageMessage(Hub, position, roleTypeId).SendToAuthenticated();
				}
			}
		}

		private bool TryGetOverride(out Vector3 overrideDir)
		{
			_cursorOverrides.RemoveAll((ICursorOverride x) => x == null || (x is UnityEngine.Object obj && obj == null));
			bool result = false;
			overrideDir = Vector3.zero;
			foreach (ICursorOverride cursorOverride in _cursorOverrides)
			{
				if (cursorOverride.LockMovement)
				{
					result = true;
				}
			}
			if (Hub.inventory.CurInstance.GetMobilityController() is IMovementInputOverride { MovementOverrideActive: not false } movementInputOverride)
			{
				result = true;
				overrideDir = movementInputOverride.MovementOverrideDirection;
			}
			for (int num = 0; num < Hub.playerEffectsController.EffectsLength; num++)
			{
				if (Hub.playerEffectsController.AllEffects[num] is IMovementInputOverride { MovementOverrideActive: not false } movementInputOverride2)
				{
					result = true;
					overrideDir += movementInputOverride2.MovementOverrideDirection;
				}
			}
			return result;
		}

		private static void ReloadInputConfigs()
		{
			// Client-only body stripped from the server build (restored after the SL 12 CE client).
			_keyFwd = NewInput.GetKey(ActionName.MoveForward);
			_keyBwd = NewInput.GetKey(ActionName.MoveBackward);
			_keyLft = NewInput.GetKey(ActionName.MoveLeft);
			_keyRgt = NewInput.GetKey(ActionName.MoveRight);
			FpcJumpController.ReloadInputConfigs();
		}
		public void PopulateDummyActions(Action<DummyAction> actionAdder)
		{
			float[] array = new float[4] { 0.05f, 0.2f, 0.5f, 1.5f };
			foreach (float dist in array)
			{
				actionAdder(new DummyAction(string.Format("Walk {0} {1}m", "left", dist), () =>
				{
					SetPosition(Vector3.left, dist);
				}));
				actionAdder(new DummyAction(string.Format("Walk {0} {1}m", "right", dist), () =>
				{
					SetPosition(Vector3.right, dist);
				}));
				actionAdder(new DummyAction(string.Format("Walk {0} {1}m", "forward", dist), () =>
				{
					SetPosition(Vector3.forward, dist);
				}));
				actionAdder(new DummyAction(string.Format("Walk {0} {1}m", "back", dist), () =>
				{
					SetPosition(Vector3.back, dist);
				}));
			}
			void SetPosition(Vector3 dir, float distance)
			{
				Vector3 vector = Hub.PlayerCameraReference.TransformDirection(dir).NormalizeIgnoreY();
				ReceivedPosition = new RelativePosition(Position + vector * distance);
			}
		}
	}
}

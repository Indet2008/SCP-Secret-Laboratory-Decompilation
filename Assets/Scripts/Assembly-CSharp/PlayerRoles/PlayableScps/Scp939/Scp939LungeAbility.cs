using System;
using LabApi.Events.Arguments.Scp939Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Subroutines;
using RelativePositioning;
using UnityEngine;
using Utils.Networking;

namespace PlayerRoles.PlayableScps.Scp939
{
	public class Scp939LungeAbility : KeySubroutine<Scp939Role>
	{
		[SerializeField]
		private float _harshLandingHeight;

		[SerializeField]
		private float _lungeAngleLimit;

		[SerializeField]
		private float _overallTolerance;

		[SerializeField]
		private float _bottomTolerance;

		[SerializeField]
		private float _secondaryRangeSqr;

		[SerializeField]
		private Scp939LungeAudio _audio;

		[SerializeField]
		private AnimationCurve _jumpSpeedOverPitch;

		[SerializeField]
		private AnimationCurve _forwardSpeedOverPitch;

		private Scp939FocusAbility _focus;

		private Scp939MovementModule _movementModule;

		private FpcStandardRoleBase _playerToHit;

		private Scp939LungeState _state;

		private float _lungePitch;

		private const float MainHitmarkerSize = 1f;

		private const float SecondaryHitmarkerSize = 0.6f;

		public const float LungeDamage = 120f;

		public const float SecondaryDamage = 30f;

		public bool IsReady
		{
			get
			{
				if (_focus.State == 1f && State == Scp939LungeState.None && (!base.Owner.isLocalPlayer || !Cursor.visible))
				{
					return Mathf.Abs(_focus.AngularDeviation) < _lungeAngleLimit;
				}
				return false;
			}
		}

		public bool LungeRequested { get; private set; }

		public RelativePosition TriggerPos { get; private set; }

		public float LungeForwardSpeed => _forwardSpeedOverPitch.Evaluate(_lungePitch);

		public float LungeJumpSpeed => _jumpSpeedOverPitch.Evaluate(_lungePitch);

		[field: SerializeField]
		public RagdollAnimationTemplate LungeDeathAnim { get; private set; }

		public Scp939LungeState State
		{
			get
			{
				return _state;
			}
			private set
			{
				if (State == value)
				{
					return;
				}
				Scp939LungingEventArgs e = new Scp939LungingEventArgs(base.Owner, value);
				Scp939Events.OnLunging(e);
				if (e.IsAllowed && e.LungeState != State)
				{
					value = e.LungeState;
					_state = value;
					OnStateChanged?.Invoke(value);
					if (!base.Owner.isLocalPlayer)
					{
						_movementModule.MouseLook.UpdateRotation();
					}
					_lungePitch = _movementModule.MouseLook.CurrentVertical;
					ServerSendRpc(toAll: true);
					Scp939Events.OnLunged(new Scp939LungedEventArgs(base.Owner, value));
				}
			}
		}

		protected override ActionName TargetKey => ActionName.Shoot;

		private bool HasAuthority
		{
			get
			{
				if (!NetworkServer.active)
				{
					return base.Owner.isLocalPlayer;
				}
				return true;
			}
		}

		private RelativePosition CurPos => new RelativePosition(base.CastRole.FpcModule.Position);

		public event Action<Scp939LungeState> OnStateChanged;

		private void OnGrounded()
		{
			if (HasAuthority && State == Scp939LungeState.Triggered)
			{
				bool flag = CurPos.Position.y < TriggerPos.Position.y - _harshLandingHeight;
				State = (flag ? Scp939LungeState.LandHarsh : Scp939LungeState.LandRegular);
			}
		}

		private void OnFocusStateChanged()
		{
			if (!(_focus.State > 0f))
			{
				State = Scp939LungeState.None;
			}
		}

		protected override void OnKeyDown()
		{
			base.OnKeyDown();
			LungeRequested = true;
		}

		protected override void Awake()
		{
			base.Awake();
			GetSubroutine<Scp939FocusAbility>(out _focus);
			_movementModule = base.CastRole.FpcModule as Scp939MovementModule;
			_focus.OnStateChanged += OnFocusStateChanged;
			_audio.Init(this);
		}

		protected override void Update()
		{
			LungeRequested = false;
			base.Update();
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			Scp939MovementModule movementModule = _movementModule;
			movementModule.OnGrounded = (Action)Delegate.Combine(movementModule.OnGrounded, new Action(OnGrounded));
		}

		public override void ResetObject()
		{
			LungeRequested = false;
			State = Scp939LungeState.None;
			Scp939MovementModule movementModule = _movementModule;
			movementModule.OnGrounded = (Action)Delegate.Remove(movementModule.OnGrounded, new Action(OnGrounded));
		}

		public void TriggerLunge()
		{
			TriggerPos = CurPos;
			State = Scp939LungeState.Triggered;
		}

		public void ClientSendHit(FpcStandardRoleBase targetRole)
		{
			_playerToHit = targetRole;
			ClientSendCmd();
			State = Scp939LungeState.LandHit;
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			base.ClientWriteCmd(writer);
			writer.WriteRelativePosition(new RelativePosition(base.CastRole.FpcModule.Position));
			writer.WriteReferenceHub(_playerToHit.TryGetOwner(out var hub) ? hub : null);
			writer.WriteRelativePosition(new RelativePosition(_playerToHit.FpcModule.Position));
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (State != Scp939LungeState.Triggered)
			{
				return;
			}
			Vector3 position = reader.ReadRelativePosition().Position;
			ReferenceHub referenceHub = reader.ReadReferenceHub();
			RelativePosition relativePosition = reader.ReadRelativePosition();
			if (State != Scp939LungeState.Triggered)
			{
				if (!IsReady)
				{
					return;
				}
				TriggerLunge();
			}
			if (referenceHub == null || !HitboxIdentity.IsEnemy(base.Owner, referenceHub) || !(referenceHub.roleManager.CurrentRole is FpcStandardRoleBase { FpcModule: var fpcModule }))
			{
				return;
			}
			using (new FpcBacktracker(referenceHub, relativePosition.Position))
			{
				using (new FpcBacktracker(base.Owner, fpcModule.Position, Quaternion.identity))
				{
					Vector3 v = fpcModule.Position - base.CastRole.FpcModule.Position;
					if (v.SqrMagnitudeIgnoreY() > _overallTolerance * _overallTolerance || v.y > _overallTolerance || v.y < 0f - _bottomTolerance)
					{
						return;
					}
				}
			}
			using (new FpcBacktracker(base.Owner, position, Quaternion.identity))
			{
				position = base.CastRole.FpcModule.Position;
			}
			Transform transform = referenceHub.transform;
			Vector3 position2 = fpcModule.Position;
			Quaternion rotation = transform.rotation;
			Vector3 vector = new Vector3(position.x, position2.y, position.z);
			transform.forward = -base.Owner.transform.forward;
			fpcModule.Position = vector;
			bool flag = false;
			if (!Physics.Linecast(position, position2, PlayerRolesUtils.AttackMask))
			{
				float damage = 120f;
				Scp939AttackingEventArgs e = new Scp939AttackingEventArgs(base.Owner, referenceHub, damage);
				Scp939Events.OnAttacking(e);
				if (!e.IsAllowed)
				{
					return;
				}
				referenceHub = e.Target.ReferenceHub;
				damage = e.Damage;
				flag = referenceHub.playerStats.DealDamage(new Scp939DamageHandler(base.CastRole, damage, Scp939DamageType.LungeTarget));
				if (flag)
				{
					Scp939Events.OnAttacked(new Scp939AttackedEventArgs(base.Owner, referenceHub, damage));
				}
			}
			float num = (flag ? 1f : 0f);
			if (!flag || referenceHub.IsAlive())
			{
				fpcModule.Position = position2;
				transform.rotation = rotation;
			}
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub == referenceHub || !HitboxIdentity.IsEnemy(base.Owner, allHub) || !(allHub.roleManager.CurrentRole is FpcStandardRoleBase fpcStandardRoleBase2))
				{
					continue;
				}
				Vector3 position3 = fpcStandardRoleBase2.FpcModule.Position;
				if (!((fpcStandardRoleBase2.FpcModule.Position - vector).sqrMagnitude > _secondaryRangeSqr))
				{
					if (Physics.Linecast(position3, position, PlayerRolesUtils.AttackMask))
					{
						return;
					}
					float damage2 = 30f;
					Scp939AttackingEventArgs e2 = new Scp939AttackingEventArgs(base.Owner, allHub, damage2);
					Scp939Events.OnAttacking(e2);
					if (!e2.IsAllowed)
					{
						return;
					}
					referenceHub = e2.Target.ReferenceHub;
					damage2 = e2.Damage;
					if (allHub.playerStats.DealDamage(new Scp939DamageHandler(base.CastRole, damage2, Scp939DamageType.LungeSecondary)))
					{
						Scp939Events.OnAttacked(new Scp939AttackedEventArgs(base.Owner, allHub, damage2));
						flag = true;
						num = Mathf.Max(num, 0.6f);
					}
				}
			}
			if (flag)
			{
				Hitmarker.SendHitmarkerDirectly(base.Owner, num);
			}
			State = Scp939LungeState.LandHit;
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteByte((byte)State);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			if (!HasAuthority)
			{
				State = (Scp939LungeState)reader.ReadByte();
			}
		}
	}
}

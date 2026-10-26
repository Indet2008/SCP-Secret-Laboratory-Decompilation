using System.Collections.Generic;
using Mirror;
using PlayerRoles.FirstPersonControl;
using UnityEngine;
using Utils;

namespace CustomPlayerEffects
{
	public abstract class CokeBase<TStack> : CokeBase, IHealableEffect, IMovementSpeedModifier, IConflictableEffect where TStack : ICokeStack
	{
		private const float ConflictExplosionDelay = 1.05f;

		private bool _goingToExplode;

		private float _explosionTimer;

		public abstract Dictionary<PlayerMovementState, float> StateMultipliers { get; }

		public abstract float MovementSpeedMultiplier { get; }

		public bool MovementModifierActive => base.IsEnabled;

		public float MovementSpeedLimit => float.MaxValue;

		[field: SerializeField]
		protected TStack[] StackMultipliers { get; private set; }

		protected TStack CurrentStack { get; private set; }

		protected bool GoingToExplode
		{
			get
			{
				return _goingToExplode;
			}
			private set
			{
				_goingToExplode = value;
				_explosionTimer = 0f;
			}
		}

		public bool IsHealable(ItemType it)
		{
			return it == ItemType.SCP500;
		}

		protected float GetMovementStateMultiplier()
		{
			if (!(base.Hub.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return 1f;
			}
			PlayerMovementState playerMovementState = fpcRole.FpcModule.CurrentMovementState;
			float num = base.Hub.GetVelocity().SqrMagnitudeIgnoreY();
			if (playerMovementState == PlayerMovementState.Walking && num == 0f)
			{
				playerMovementState = PlayerMovementState.Crouching;
			}
			if (!StateMultipliers.TryGetValue(playerMovementState, out var value))
			{
				return 1f;
			}
			return value;
		}

		protected override void Awake()
		{
			base.Awake();
			CurrentStack = StackMultipliers[0];
		}

		protected override void IntensityChanged(byte prevState, byte newState)
		{
			CurrentStack = StackMultipliers[Mathf.Clamp(newState, 0, StackMultipliers.Length - 1)];
		}

		protected override void Enabled()
		{
			base.Enabled();
			GoingToExplode = false;
		}

		protected override void Disabled()
		{
			base.Disabled();
			GoingToExplode = false;
		}

		protected override void OnEffectUpdate()
		{
			base.OnEffectUpdate();
			if (NetworkServer.active && GoingToExplode)
			{
				_explosionTimer += Time.deltaTime;
				if (!(_explosionTimer < 1.05f))
				{
					ExplosionUtils.ServerExplode(base.Hub, ExplosionType.Cola);
					GoingToExplode = false;
				}
			}
		}

		public virtual bool CheckConflicts(StatusEffectBase other)
		{
			if (other is Scp1853)
			{
				if (!base.Hub.playerEffectsController.TryGetEffect<Poisoned>(out var playerEffect))
				{
					return false;
				}
				if (!playerEffect.IsEnabled)
				{
					playerEffect.ForceIntensity(1);
				}
				return true;
			}
			if (!(other is CokeBase cokeBase))
			{
				return false;
			}
			GoingToExplode = true;
			cokeBase.ServerDisable();
			return true;
		}
	}
	public abstract class CokeBase : TickingEffectBase
	{
	}
}

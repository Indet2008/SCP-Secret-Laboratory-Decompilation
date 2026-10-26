using MapGeneration.Holidays;
using Mirror;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerStatsSystem;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class SlowMetabolism : TickingEffectBase, IHealableEffect, IMovementSpeedModifier, IUsableItemModifierEffect, IHolidayEffect
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioSource _breathingSource;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioSource _balloonSound;


		private const float EatingSpeedMultiplier = 3f;

		private const float BreathingStaminaThreshold = 0.3f;

		private static readonly int HashBodyAnim = Animator.StringToHash("PurpleCandy");

		private StaminaStat _staminaCache;

		private bool _cacheSet;

		public bool MovementModifierActive => base.IsEnabled;

		public float MovementSpeedMultiplier => 0.9f;

		public float MovementSpeedLimit => float.MaxValue;

		public HolidayType[] TargetHolidays { get; } = new HolidayType[1] { HolidayType.Halloween };

		private float CurStamina
		{
			get
			{
				PrepCache();
				return _staminaCache.CurValue;
			}
			set
			{
				PrepCache();
				_staminaCache.CurValue = value;
			}
		}

		public bool IsHealable(ItemType it)
		{
			return it == ItemType.SCP500;
		}

		public bool TryGetSpeed(ItemType item, out float speed)
		{
			speed = 3f;
			return item == ItemType.SCP330;
		}

		protected override void OnTick()
		{
			if (NetworkServer.active)
			{
				bool flag = CurStamina <= 0.3f;
				base.Intensity = (byte)((!flag) ? 1 : 2);
			}
		}

		protected override void Enabled()
		{
			base.Enabled();
			ChangeBodyState(inflateBody: true);
		}

		protected override void Disabled()
		{
			base.Disabled();
			ChangeBodyState(inflateBody: false);
		}

		private void PrepCache()
		{
			if (!_cacheSet)
			{
				_cacheSet = true;
				_staminaCache = base.Hub.playerStats.GetModule<StaminaStat>();
			}
		}

		private void ChangeBodyState(bool inflateBody)
		{
			if (base.Hub.roleManager.CurrentRole is HumanRole humanRole && humanRole.FpcModule.CharacterModelInstance is AnimatedCharacterModel animatedCharacterModel && animatedCharacterModel.HasParameter(HashBodyAnim))
			{
				animatedCharacterModel.Animator.SetBool(HashBodyAnim, inflateBody);
			}
		}
	}
}

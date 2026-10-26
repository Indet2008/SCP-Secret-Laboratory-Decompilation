namespace PlayerRoles.PlayableScps.Scp049.Zombies
{
	public class ZombieHud : global::PlayerRoles.PlayableScps.HUDs.ScpHudBase, IViewmodelRole
	{
		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.AbilityHud _attackCooldownIcon;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.LoadingCircleHud _consumeCircle;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.Image _bloodlustBackground;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.Image _bloodlustFill;

		[global::UnityEngine.SerializeField]
		private float _bloodlustAlphaSpeed;

		[global::UnityEngine.SerializeField]
		private float _bloodlustTickDelay;

		[global::UnityEngine.SerializeField]
		private float _bloodlustThreshold;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Sprite _eyeOpen;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Sprite _eyeSemiOpen;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Sprite _eyeClosed;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Animator _hands;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _uiRoot;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.ScpWarningHud _warningHud;

		private global::PlayerRoles.PlayableScps.Scp049.Zombies.ZombieConsumeAbility _consumeAbility;

		private global::PlayerRoles.PlayableScps.Scp049.Zombies.ZombieAttackAbility _attackAbility;

		private global::PlayerRoles.PlayableScps.Scp049.Zombies.ZombieMovementModule _fpcModule;

		private float _bloodlustTimer;

		private float _bloodlustAlpha;

		private float _bloodlustLerpValue;

		private bool _handsDestroyed;

		private const float HandsFov = 70f;

		private static readonly int AttackHash;

		private static readonly int EatHash;

		protected override void Update()
		{
		}

		private void PlayAttack()
		{
		}

		private void ProcessError(byte err)
		{
		}

		private void UpdateBloodlust(global::UnityEngine.UI.Image fill, global::UnityEngine.UI.Image background, float fillAmount)
		{
		}

		private void SetBloodlustTransparency(global::UnityEngine.UI.Image fill, global::UnityEngine.UI.Image background, float fillAmount)
		{
		}

		private void SetTransparency(global::UnityEngine.UI.Image image, float alpha)
		{
		}

		private void DestroyHands()
		{
		}

		protected override void OnDestroy()
		{
		}

		internal override void OnDied()
		{
		}

		internal override void Init(ReferenceHub hub)
		{
		}

		public bool TryGetViewmodelFov(out float fov)
		{ fov = default;
			return default;
		}

		public ZombieHud()
		{
		}
	}
}

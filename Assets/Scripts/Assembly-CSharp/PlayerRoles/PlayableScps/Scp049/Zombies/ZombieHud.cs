using InventorySystem.Items;
using PlayerRoles.PlayableScps.HUDs;
using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.PlayableScps.Scp049.Zombies
{
	public class ZombieHud : ScpHudBase, IViewmodelRole
	{
		[SerializeField]
		private AbilityHud _attackCooldownIcon;

		[SerializeField]
		private LoadingCircleHud _consumeCircle;

		[SerializeField]
		private Image _bloodlustBackground;

		[SerializeField]
		private Image _bloodlustFill;

		[SerializeField]
		private float _bloodlustAlphaSpeed;

		[SerializeField]
		private float _bloodlustTickDelay;

		[SerializeField]
		private float _bloodlustThreshold;

		[SerializeField]
		private Sprite _eyeOpen;

		[SerializeField]
		private Sprite _eyeSemiOpen;

		[SerializeField]
		private Sprite _eyeClosed;

		[SerializeField]
		private Animator _hands;

		[SerializeField]
		private GameObject _uiRoot;

		[SerializeField]
		private ScpWarningHud _warningHud;

		private ZombieConsumeAbility _consumeAbility;

		private ZombieAttackAbility _attackAbility;

		private ZombieMovementModule _fpcModule;

		private float _bloodlustTimer;

		private float _bloodlustAlpha;

		private float _bloodlustLerpValue;

		private bool _handsDestroyed;

		private const float HandsFov = 70f;

		private static readonly int AttackHash = Animator.StringToHash("Shoot");

		private static readonly int EatHash = Animator.StringToHash("Eat");

		protected override void Update()
		{
			base.Update();
			if (!_handsDestroyed)
			{
				_consumeCircle.Apply(_consumeAbility.ProgressStatus);
				_hands.SetBool(EatHash, _consumeAbility.IsInProgress);
				_attackCooldownIcon.Update();
				float fillAmount = (_fpcModule.WalkSpeed - _fpcModule.NormalSpeed) / (_fpcModule.BloodlustSpeed - _fpcModule.NormalSpeed);
				UpdateBloodlust(_bloodlustFill, _bloodlustBackground, fillAmount);
			}
		}

		private void PlayAttack()
		{
			if (!_handsDestroyed)
			{
				_hands.SetTrigger(AttackHash);
			}
		}

		private void ProcessError(byte err)
		{
			string defaultValue = string.Format("Operation refused, code #{0}", err);
			_warningHud.SetText(TranslationReader.Get("SCP049_HUD", err + 3, defaultValue), 3.8f);
		}

		private void UpdateBloodlust(Image fill, Image background, float fillAmount)
		{
			SetBloodlustTransparency(fill, background, fillAmount);
			Sprite sprite = ((fillAmount > 0.75f) ? _eyeOpen : ((!(fillAmount > 0.4f)) ? _eyeClosed : _eyeSemiOpen));
			fill.sprite = sprite;
			background.sprite = sprite;
			_bloodlustLerpValue = Mathf.Lerp(_bloodlustLerpValue, fillAmount, Time.deltaTime * 1.5f);
			fill.fillAmount = _bloodlustLerpValue;
		}

		private void SetBloodlustTransparency(Image fill, Image background, float fillAmount)
		{
			_bloodlustTimer += Time.deltaTime;
			if (!(_bloodlustTimer < _bloodlustTickDelay))
			{
				float num = ((fillAmount > _bloodlustThreshold) ? _bloodlustAlphaSpeed : (0f - _bloodlustAlphaSpeed));
				_bloodlustAlpha = Mathf.Clamp01(_bloodlustAlpha + num);
				_bloodlustTimer = 0f;
				SetTransparency(fill, _bloodlustAlpha);
				SetTransparency(background, _bloodlustAlpha);
			}
		}

		private void SetTransparency(Image image, float alpha)
		{
			Color color = image.color;
			color.a = alpha;
			image.color = color;
		}

		private void DestroyHands()
		{
			if (!(_hands == null))
			{
				_handsDestroyed = true;
				Object.Destroy(_hands.gameObject);
			}
		}

		protected override void OnDestroy()
		{
			DestroyHands();
			if (_attackAbility != null)
			{
				_attackAbility.OnTriggered -= PlayAttack;
			}
			if (_consumeAbility != null)
			{
				_consumeAbility.OnErrorReceived -= ProcessError;
			}
			base.OnDestroy();
		}

		internal override void OnDied()
		{
			DestroyHands();
			_uiRoot.SetActive(value: false);
		}

		internal override void Init(ReferenceHub hub)
		{
			base.Init(hub);
			if (!(hub.roleManager.CurrentRole is ZombieRole zombieRole))
			{
				return;
			}
			zombieRole.SubroutineModule.TryGetSubroutine<ZombieConsumeAbility>(out _consumeAbility);
			zombieRole.SubroutineModule.TryGetSubroutine<ZombieAttackAbility>(out _attackAbility);
			_fpcModule = zombieRole.FpcModule as ZombieMovementModule;
			_attackCooldownIcon.Setup(_attackAbility.Cooldown, null);
			Transform transform = _hands.transform;
			Vector3 localPosition = transform.localPosition;
			transform.SetParent(SharedHandsController.Singleton.transform, worldPositionStays: true);
			transform.localPosition = localPosition;
			transform.localRotation = Quaternion.identity;
			_attackAbility.OnTriggered += PlayAttack;
			_consumeAbility.OnErrorReceived += ProcessError;
			if (!hub.isLocalPlayer)
			{
				for (int i = 0; i < 5; i++)
				{
					_hands.Update(0.15f);
				}
			}
		}

		public bool TryGetViewmodelFov(out float fov)
		{
			fov = 70f;
			return true;
		}
	}
}

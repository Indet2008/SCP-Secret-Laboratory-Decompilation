using PlayerRoles.PlayableScps.HUDs;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.PlayableScps.Scp173
{
	public class Scp173Hud : ScpHudBase
	{
		[SerializeField]
		private Animator _hudAnimator;

		[SerializeField]
		private Image _eyeIndicator;

		[SerializeField]
		private Image _tantrumCooldown;

		[SerializeField]
		private Image _breakneckSpeedsCooldown;

		[SerializeField]
		private TextMeshProUGUI _timer;

		[SerializeField]
		private Sprite _bloodshotEye;

		[SerializeField]
		private Sprite _openEye;

		[SerializeField]
		private AbilityHud _tantrumElement;

		[SerializeField]
		private AbilityHud _breakneckElement;

		private Scp173ObserversTracker _observersTracker;

		private Scp173BlinkTimer _blinkAbility;

		private Scp173TantrumAbility _tantrumAbility;

		private Scp173BreakneckSpeedsAbility _breakneckSpeedsAbility;

		private static readonly int AnimatorHudShownHash = Animator.StringToHash("Shown");

		private static readonly int AnimatorHudReadyHash = Animator.StringToHash("Ready");

		internal override void Init(ReferenceHub hub)
		{
			base.Init(hub);
			if (hub.roleManager.CurrentRole is Scp173Role scp173Role)
			{
				scp173Role.SubroutineModule.TryGetSubroutine<Scp173ObserversTracker>(out _observersTracker);
				scp173Role.SubroutineModule.TryGetSubroutine<Scp173BlinkTimer>(out _blinkAbility);
				scp173Role.SubroutineModule.TryGetSubroutine<Scp173TantrumAbility>(out _tantrumAbility);
				scp173Role.SubroutineModule.TryGetSubroutine<Scp173BreakneckSpeedsAbility>(out _breakneckSpeedsAbility);
				_tantrumAbility.TantrumAbilityHUD = _tantrumElement;
				_breakneckSpeedsAbility.BreakneckAbilityHUD = _breakneckElement;
				_tantrumElement.Setup(_tantrumAbility.Cooldown, null);
				_breakneckElement.Setup(_breakneckSpeedsAbility.Cooldown, null);
			}
		}

		protected override void Update()
		{
			base.Update();
			_tantrumElement.Update();
			_breakneckElement.Update();
			bool isObserved = _observersTracker.IsObserved;
			float remainingSustainPercent = _blinkAbility.RemainingSustainPercent;
			float remainingBlinkCooldown = _blinkAbility.RemainingBlinkCooldown;
			bool flag = isObserved || remainingSustainPercent > 0f;
			_hudAnimator.SetBool(AnimatorHudShownHash, flag);
			_hudAnimator.SetBool(AnimatorHudReadyHash, remainingBlinkCooldown <= 0f);
			_eyeIndicator.fillAmount = remainingSustainPercent;
			_timer.text = (flag ? $"{remainingBlinkCooldown:F1}s" : string.Empty);
			_timer.color = Color.Lerp(Color.clear, Color.white, remainingSustainPercent);
			_eyeIndicator.sprite = ((remainingBlinkCooldown <= 0f) ? _bloodshotEye : _openEye);
		}

		private void LateUpdate()
		{
			_tantrumElement.LateUpdate();
			_breakneckElement.LateUpdate();
		}
	}
}

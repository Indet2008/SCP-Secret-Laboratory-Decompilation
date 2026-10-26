using TMPro;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939.Mimicry
{
	public class EnvMimicryMenu : MimicryMenuBase
	{
		[SerializeField]
		private CanvasGroup _fader;

		[SerializeField]
		private float _fadedAlpha;

		[SerializeField]
		private float _fadeSpeed;

		[SerializeField]
		private TMP_Text _cooldownText;

		private EnvironmentalMimicry _envMimicry;

		protected override void Setup(Scp939Role role)
		{
			base.Setup(role);
			role.SubroutineModule.TryGetSubroutine<EnvironmentalMimicry>(out _envMimicry);
		}

		private void UpdateFade(bool instant)
		{
			bool isReady = _envMimicry.Cooldown.IsReady;
			float maxDelta = (instant ? 1f : (Time.deltaTime * _fadeSpeed));
			float target = (isReady ? 1f : _fadedAlpha);
			_fader.alpha = Mathf.MoveTowards(_fader.alpha, target, maxDelta);
			_fader.blocksRaycasts = isReady;
			float target2 = ((!isReady) ? 1 : 0);
			_cooldownText.alpha = Mathf.MoveTowards(_cooldownText.alpha, target2, maxDelta);
			if (!isReady)
			{
				_cooldownText.text = _envMimicry.CooldownText;
			}
		}

		private void OnEnable()
		{
			UpdateFade(instant: true);
		}

		private void Update()
		{
			UpdateFade(instant: false);
		}
	}
}

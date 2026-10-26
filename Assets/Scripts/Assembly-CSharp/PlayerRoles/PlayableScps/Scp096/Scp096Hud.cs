using PlayerRoles.PlayableScps.HUDs;
using TMPro;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.UI;

namespace PlayerRoles.PlayableScps.Scp096
{
	public class Scp096Hud : ViewmodelScpHud
	{
		[SerializeField]
		private AbilityHud _rageDuration;

		[SerializeField]
		private AbilityHud _chargeCooldown;

		[SerializeField]
		private Image[] _keyCircles;

		[SerializeField]
		private Image _rageEnterSustainCircle;

		[SerializeField]
		private GameObject _docileCircles;

		[SerializeField]
		private ScpWarningHud _rageInfo;

		[SerializeField]
		private TMP_Text _targetCounter;

		[SerializeField]
		private Volume _rageVolume;

		[SerializeField]
		private float _rageVolumeDelta;

		private Scp096Role _scp096;

		private Scp096RageCycleAbility _rageCycle;

		private Scp096RageManager _rageManager;

		private Scp096ChargeAbility _chargeAbility;

		private GameObject _targetTrackerParent;

		internal override void Init(ReferenceHub hub)
		{
			base.Init(hub);
			_scp096 = hub.roleManager.CurrentRole as Scp096Role;
			_scp096.SubroutineModule.TryGetSubroutine<Scp096RageCycleAbility>(out _rageCycle);
			_scp096.SubroutineModule.TryGetSubroutine<Scp096RageManager>(out _rageManager);
			_scp096.SubroutineModule.TryGetSubroutine<Scp096ChargeAbility>(out _chargeAbility);
			_chargeAbility.ChargeAbilityHUD = _chargeCooldown;
			_targetTrackerParent = _targetCounter.transform.parent.gameObject;
			_rageDuration.Setup(_rageManager.HudRageDuration, null);
			_chargeCooldown.Setup(_chargeAbility.Cooldown, _chargeAbility.Duration);
			_rageInfo.gameObject.SetActive(hub.isLocalPlayer);
			UpdateColorGrading(1f);
		}

		protected override void Update()
		{
			base.Update();
			_chargeCooldown.Update();
			UpdateRageInfo();
			UpdateTracker();
			UpdateColorGrading(_rageVolumeDelta * Time.deltaTime);
		}

		private void LateUpdate()
		{
			_chargeCooldown.LateUpdate();
		}

		private void UpdateColorGrading(float maxDelta)
		{
			_rageVolume.weight = Mathf.MoveTowards(_rageVolume.weight, _rageManager.IsEnragedOrDistressed ? 1 : 0, maxDelta);
		}

		private void UpdateRageInfo()
		{
			_keyCircles.ForEach((Image x) =>
			{
				x.fillAmount = _rageCycle.HudEnterRageKeyProgress;
			});
			switch (_scp096.StateController.RageState)
			{
			case Scp096RageState.Docile:
			{
				float hudEnterRageSustain = _rageCycle.HudEnterRageSustain;
				_docileCircles.SetActive(hudEnterRageSustain > 0f);
				_rageEnterSustainCircle.fillAmount = hudEnterRageSustain;
				_rageDuration.Update(forceHidden: true);
				_chargeCooldown.Update(forceHidden: true);
				if (!(hudEnterRageSustain <= 0f))
				{
					SetWarning(Scp096HudTranslation.EnterRageKeyInfo, ActionName.Reload, hudEnterRageSustain);
				}
				break;
			}
			case Scp096RageState.Enraged:
				_rageDuration.Update();
				_chargeCooldown.Update();
				_docileCircles.SetActive(value: false);
				SetWarning(Scp096HudTranslation.ExitRageKeyInfo, ActionName.Reload);
				break;
			default:
				_rageDuration.Update(forceHidden: true);
				_chargeCooldown.Update(forceHidden: true);
				_docileCircles.SetActive(value: false);
				_rageInfo.SetText(string.Empty);
				break;
			}
		}

		private void SetWarning(Scp096HudTranslation key, ActionName action, float duration = 3.8f)
		{
			if (!Translations.TryGet(key, out var tr))
			{
				tr = "Hold {0} to " + key;
			}
			_rageInfo.SetText(string.Format(tr, $"<color=red>{new ReadableKeyCode(action)}</color>"), duration);
		}

		private void UpdateTracker()
		{
			base.UpdateCounter();
			int current096Targets = Scp096TargetsTracker.Current096Targets;
			if (current096Targets == 0)
			{
				_targetTrackerParent.SetActive(value: false);
				return;
			}
			_targetCounter.text = current096Targets.ToString();
			_targetTrackerParent.SetActive(value: true);
		}
	}
}

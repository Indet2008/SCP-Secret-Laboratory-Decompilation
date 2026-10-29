using CustomRendering;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.HUDs;
using PlayerRoles.PlayableScps.Scp939.Mimicry;
using TMPro;
using UnityEngine;
using UnityEngine.Rendering;
using UserSettings;
using UserSettings.VideoSettings;

namespace PlayerRoles.PlayableScps.Scp939
{
	public class Scp939Hud : ViewmodelScpHud
	{
		[SerializeField]
		private GameObject _hudRoot;

		[SerializeField]
		private GameObject _mimicryMenuRoot;

		[SerializeField]
		private TextMeshProUGUI _lungeReadyText;

		[SerializeField]
		private AbilityHud _amnesticCloudPlacedIcon;

		[SerializeField]
		private AbilityHud _amnesticCloudBuildupIcon;

		[SerializeField]
		private AbilityHud _mimicryCooldown;

		[SerializeField]
		private ScpWarningHud _warningElement;

		[SerializeField]
		private Volume _postProcessVolume;

		[SerializeField]
		private float _blurAdditive;

		[SerializeField]
		private float _effectsLerpSpeed;

		private EnvironmentalMimicry _envMimicry;

		private MimicPointController _mimicPoint;

		private MimicryRecorder _recorder;

		private Scp939VisibilityController _visController;

		private Scp939LungeAbility _lungeAbility;

		private Scp939AmnesticCloudAbility _cloudAbility;

		private FogEffect _ppFog;

		private BlurEffect _ppBlur;

		private RadialBlur _ppRadialBlur;

		private Grayscale _ppGrayscale;

		private const float TextFadeSpeed = 5f;

		private const float WarningDuration = 5.5f;

		private const float ProlongedUpdateTime = 0.4f;

		private const string DefaultLungeFormat = "Press {0} or {1} to Lunge.";

		private void LateUpdate()
		{
			float speed = (_lungeAbility.IsReady ? 5f : (-5f));
			_lungeReadyText.alpha = Mathf.Clamp01(_lungeReadyText.alpha + Time.deltaTime * speed);
			_mimicryCooldown.Update();
			if (_cloudAbility.TargetState)
			{
				UpdateAmnesticCloud(buildupHidden: false);
			}
			else if (_cloudAbility.Cooldown.NextUse > NetworkTime.time - 0.4000000059604645)
			{
				UpdateAmnesticCloud(buildupHidden: true);
			}
			LerpEffects(Time.deltaTime * _effectsLerpSpeed);
		}

		private void UpdateAmnesticCloud(bool buildupHidden)
		{
			_amnesticCloudBuildupIcon.Update(buildupHidden);
			_amnesticCloudPlacedIcon.Update(!buildupHidden);
		}

		private void LerpEffects(float lerp)
		{
			if (_hudRoot.activeInHierarchy)
			{
				float currentDetectionRange = _visController.CurrentDetectionRange;
				LerpEffect(_ppFog, currentDetectionRange, lerp);
				LerpEffect(_ppGrayscale, currentDetectionRange, lerp);
				LerpEffect(_ppBlur, currentDetectionRange + _blurAdditive, lerp);
			}
		}

		private void ShowWarning(Scp939HudTranslation val)
		{
			if (val != Scp939HudTranslation.PressKeyToLunge)
			{
				_warningElement.SetText(Translations.Get(val), 5.5f);
			}
		}

		private void LerpEffect(DistanceEffect fx, float target, float lerp)
		{
			if (fx == null)
			{
				return;
			}
			fx.EndDistance.value = Mathf.Lerp(fx.EndDistance.value, target, lerp);
			fx.StartDistance.value = fx.EndDistance.value * 0.5f;
		}

		private string ActionKeyName(ActionName an)
		{
			return string.Format("<color=red>{0}</color>", new ReadableKeyCode(NewInput.GetKey(an)));
		}

		internal override void Init(ReferenceHub hub)
		{
			base.Init(hub);
			Scp939Role scp939Role = hub.roleManager.CurrentRole as Scp939Role;
			scp939Role.SubroutineModule.TryGetSubroutine<Scp939LungeAbility>(out _lungeAbility);
			scp939Role.SubroutineModule.TryGetSubroutine<Scp939AmnesticCloudAbility>(out _cloudAbility);
			scp939Role.SubroutineModule.TryGetSubroutine<MimicPointController>(out _mimicPoint);
			scp939Role.SubroutineModule.TryGetSubroutine<EnvironmentalMimicry>(out _envMimicry);
			scp939Role.SubroutineModule.TryGetSubroutine<MimicryRecorder>(out _recorder);
			_recorder.OnSavedVoicesItemAdded += ShowWarning;
			_cloudAbility.OnDeployFailed += ShowWarning;
			_mimicPoint.OnMessageReceived += ShowWarning;
			_visController = scp939Role.VisibilityController as Scp939VisibilityController;
			_mimicryCooldown.Setup(_envMimicry.Cooldown, null);
			_amnesticCloudPlacedIcon.Setup(_cloudAbility.Cooldown, _cloudAbility.Duration);
			_amnesticCloudBuildupIcon.Setup(_cloudAbility.HudIndicatorMin, _cloudAbility.HudIndicatorMax);
			VolumeProfile profile = _postProcessVolume.profile;
			profile.TryGet<FogEffect>(out _ppFog);
			profile.TryGet<BlurEffect>(out _ppBlur);
			profile.TryGet<RadialBlur>(out _ppRadialBlur);
			profile.TryGet<Grayscale>(out _ppGrayscale);
			UpdateBlur(UserSetting<bool>.Get(MiscVideoSetting.Scp939VisionBlur));
			UserSetting<bool>.AddListener(MiscVideoSetting.Scp939VisionBlur, UpdateBlur);
			if (!hub.isLocalPlayer)
			{
				_lungeReadyText.enabled = false;
			}
			else
			{
				_mimicryMenuRoot.SetActive(value: true);
				if (!Translations.TryGet(Scp939HudTranslation.PressKeyToLunge, out var tr))
				{
					tr = "Press {0} or {1} to Lunge.";
				}
				_lungeReadyText.text = string.Format(tr, ActionKeyName(ActionName.Shoot), ActionKeyName(ActionName.Jump));
			}
			LerpEffects(1f);
		}

		internal override void OnDied()
		{
			_hudRoot.SetActive(value: false);
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			if (_recorder != null)
			{
				_recorder.OnSavedVoicesItemAdded -= ShowWarning;
			}
			if (_cloudAbility != null)
			{
				_cloudAbility.OnDeployFailed -= ShowWarning;
			}
			if (_mimicPoint != null)
			{
				_mimicPoint.OnMessageReceived -= ShowWarning;
			}
			UserSetting<bool>.RemoveListener(MiscVideoSetting.Scp939VisionBlur, UpdateBlur);
		}

		private void UpdateBlur(bool enable)
		{
			if (_ppBlur != null)
			{
				_ppBlur.active = enable;
			}
			if (_ppRadialBlur != null)
			{
				_ppRadialBlur.active = enable;
			}
		}
	}
}

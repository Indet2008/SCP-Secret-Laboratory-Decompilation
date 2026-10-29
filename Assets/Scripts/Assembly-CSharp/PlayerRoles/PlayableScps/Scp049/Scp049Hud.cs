using PlayerRoles.PlayableScps.HUDs;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp049
{
	public class Scp049Hud : ScpHudBase
	{
		[Header("--- Senses Ability")]
		[Space(3f)]
		[SerializeField]
		private AbilityHud _senseElement;

		[SerializeField]
		private Image _senseIndicator;

		[SerializeField]
		private Vector3 _senseMinSize;

		[SerializeField]
		private Vector3 _senseMaxSize;

		[SerializeField]
		private Color _senseNearby;

		[SerializeField]
		private Color _senseFar;

		[SerializeField]
		private float _iconModifier;

		[SerializeField]
		private float _heartbeatModifier;

		[SerializeField]
		private float _heartbeatMin;

		[SerializeField]
		private float _heartbeatMax;

		[SerializeField]
		private AnimationCurve _heartbeatAnimation;

		[Header("--- Other Abilities")]
		[Space(3f)]
		[SerializeField]
		private LoadingCircleHud _resurrectBar;

		[SerializeField]
		private AbilityHud _callElement;

		[SerializeField]
		private AbilityHud _attackElement;

		[Header("--- HUD Elements")]
		[Space(3f)]
		[SerializeField]
		private GameObject _hudRoot;

		[SerializeField]
		private ScpWarningHud _warningHud;

		[SerializeField]
		private TMP_Text _zombieCounter;

		private Scp049ResurrectAbility _resurrectAbility;

		private Scp049AttackAbility _attackAbility;

		private Scp049SenseAbility _senseAbility;

		private Scp049CallAbility _callAbility;

		private Transform _senseTransform;

		private Transform _senseTransformParent;

		private GameObject _zombieCounterParent;

		private float _heartbeatTimer;

		internal override void Init(ReferenceHub hub)
		{
			base.Init(hub);
			if (base.Hub.roleManager.CurrentRole is Scp049Role scp049Role)
			{
				scp049Role.SubroutineModule.TryGetSubroutine<Scp049ResurrectAbility>(out _resurrectAbility);
				scp049Role.SubroutineModule.TryGetSubroutine<Scp049AttackAbility>(out _attackAbility);
				scp049Role.SubroutineModule.TryGetSubroutine<Scp049SenseAbility>(out _senseAbility);
				scp049Role.SubroutineModule.TryGetSubroutine<Scp049CallAbility>(out _callAbility);
				_callAbility.CallAbilityHUD = _callElement;
				_senseAbility.SenseAbilityHUD = _senseElement;
				_attackAbility.AttackAbilityHUD = _attackElement;
				_senseTransform = _senseIndicator.transform;
				_senseTransformParent = _senseTransform.parent;
				_zombieCounterParent = _zombieCounter.transform.parent.gameObject;
				_attackElement.Setup(_attackAbility.Cooldown, null);
				_senseElement.Setup(_senseAbility.Cooldown, _senseAbility.Duration);
				_callElement.Setup(_callAbility.Cooldown, _callAbility.Duration);
				_senseAbility.OnFailed += ShowSenseError;
				_resurrectAbility.OnErrorReceived += ShowResurrectErrorCode;
			}
		}

		internal override void OnDied()
		{
			_hudRoot.SetActive(value: false);
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			if (_senseAbility != null)
			{
				_senseAbility.OnFailed -= ShowSenseError;
			}
			if (_resurrectAbility != null)
			{
				_resurrectAbility.OnErrorReceived -= ShowResurrectErrorCode;
			}
		}

		protected override void Update()
		{
			base.Update();
			_attackElement.Update();
			_senseElement.Update();
			_callElement.Update();
			_resurrectBar.Apply(_resurrectAbility.ProgressStatus);
			UpdateSenses(_senseAbility.DistanceFromTarget);
			UpdateCounter();
		}

		private void LateUpdate()
		{
			_attackElement.LateUpdate();
			_senseElement.LateUpdate();
			_callElement.LateUpdate();
		}

		private void ShowSenseError()
		{
			_warningHud.SetText(TranslationReader.Get("SCP049_HUD", 10, "No target found."), 3.8f);
		}

		private void ShowResurrectErrorCode(byte code)
		{
			string defaultValue = string.Format("Resurrection refused, code #{0}", code);
			_warningHud.SetText(TranslationReader.Get("SCP049_HUD", code - 1, defaultValue), 3.8f);
		}

		private void UpdateSenses(float distance)
		{
			if (!_senseAbility.HasTarget)
			{
				_senseTransform.gameObject.SetActive(value: false);
				return;
			}
			float t = Mathf.Clamp01(_heartbeatModifier * distance);
			_heartbeatTimer += Mathf.Lerp(_heartbeatMax, _heartbeatMin, t) * Time.deltaTime;
			if (_heartbeatTimer > 1f)
			{
				_heartbeatTimer = 0f;
			}
			float num = _heartbeatAnimation.Evaluate(_heartbeatTimer);
			float t2 = Mathf.Clamp01(_iconModifier * distance);
			_senseIndicator.color = Color.Lerp(_senseNearby, _senseFar, t2);
			_senseTransform.localScale = Vector3.Lerp(_senseMaxSize, _senseMinSize, t2);
			_senseTransformParent.localScale = Vector3.one * num;
			_senseTransform.gameObject.SetActive(value: true);
		}

		protected override void UpdateCounter()
		{
			base.UpdateCounter();
			int num = ReferenceHub.AllHubs.Count((ReferenceHub x) => x.GetRoleId() == RoleTypeId.Scp0492 || x.GetRoleId() == RoleTypeId.ZombieFlamingo);
			if (num > 0)
			{
				_zombieCounter.text = num.ToString();
				_zombieCounterParent.SetActive(value: true);
			}
			else
			{
				_zombieCounterParent.SetActive(value: false);
			}
		}
	}
}

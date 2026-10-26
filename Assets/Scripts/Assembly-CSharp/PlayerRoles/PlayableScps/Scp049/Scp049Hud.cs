namespace PlayerRoles.PlayableScps.Scp049
{
	public class Scp049Hud : global::PlayerRoles.PlayableScps.HUDs.ScpHudBase
	{
		[global::UnityEngine.Header("--- Senses Ability")]
		[global::UnityEngine.Space(3f)]
		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.AbilityHud _senseElement;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.Image _senseIndicator;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Vector3 _senseMinSize;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Vector3 _senseMaxSize;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Color _senseNearby;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Color _senseFar;

		[global::UnityEngine.SerializeField]
		private float _iconModifier;

		[global::UnityEngine.SerializeField]
		private float _heartbeatModifier;

		[global::UnityEngine.SerializeField]
		private float _heartbeatMin;

		[global::UnityEngine.SerializeField]
		private float _heartbeatMax;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AnimationCurve _heartbeatAnimation;

		[global::UnityEngine.Header("--- Other Abilities")]
		[global::UnityEngine.Space(3f)]
		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.LoadingCircleHud _resurrectBar;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.AbilityHud _callElement;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.AbilityHud _attackElement;

		[global::UnityEngine.Header("--- HUD Elements")]
		[global::UnityEngine.Space(3f)]
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _hudRoot;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.ScpWarningHud _warningHud;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TMP_Text _zombieCounter;

		private global::PlayerRoles.PlayableScps.Scp049.Scp049ResurrectAbility _resurrectAbility;

		private global::PlayerRoles.PlayableScps.Scp049.Scp049AttackAbility _attackAbility;

		private global::PlayerRoles.PlayableScps.Scp049.Scp049SenseAbility _senseAbility;

		private global::PlayerRoles.PlayableScps.Scp049.Scp049CallAbility _callAbility;

		private global::UnityEngine.Transform _senseTransform;

		private global::UnityEngine.Transform _senseTransformParent;

		private global::UnityEngine.GameObject _zombieCounterParent;

		private float _heartbeatTimer;

		internal override void Init(ReferenceHub hub)
		{
		}

		internal override void OnDied()
		{
		}

		protected override void OnDestroy()
		{
		}

		protected override void Update()
		{
		}

		private void LateUpdate()
		{
		}

		private void ShowSenseError()
		{
		}

		private void ShowResurrectErrorCode(byte code)
		{
		}

		private void UpdateSenses(float distance)
		{
		}

		protected override void UpdateCounter()
		{
		}

		public Scp049Hud()
		{
		}
	}
}

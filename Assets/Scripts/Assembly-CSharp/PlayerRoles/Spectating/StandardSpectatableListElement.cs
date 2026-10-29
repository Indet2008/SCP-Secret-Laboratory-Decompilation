using PlayerStatsSystem;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.Spectating
{
	public class StandardSpectatableListElement : FullSizeSpectatableListElement
	{
		private const float StatLerpSpeed = 15.5f;

		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[SerializeField]
		private Image _healthCircle;

		[SerializeField]
		private Image _avatarBackground;

		[SerializeField]
		private RawImage _avatarIcon;

		[SerializeField]
		private TextMeshProUGUI _roleText;

		[SerializeField]
		private Image _healthIcon;

		[SerializeField]
		private TextMeshProUGUI _healthText;

		[SerializeField]
		private Image _shieldIcon;

		[SerializeField]
		private TextMeshProUGUI _shieldText;

		private HumeShieldStat _hsStat;

		private HealthStat _hpStat;

		private AhpStat _ahpStat;

		private Color _prevColor;

		protected override void Update()
		{
			base.Update();
			PlayerRoleBase mainRole = base.Target.MainRole;
			UpdateStats(Time.deltaTime * StatLerpSpeed);
			UpdateColor(mainRole.RoleColor);
			// Military roles use the short name (e.g. "Sgt."), except the facility guard.
			bool abbreviated = mainRole.Team == Team.ChaosInsurgency || (mainRole.Team == Team.FoundationForces && mainRole.RoleTypeId != RoleTypeId.FacilityGuard);
			_roleText.text = (abbreviated ? mainRole.RoleTypeId.GetAbbreviatedRoleName() : mainRole.RoleName);
			if (mainRole is IAvatarRole avatarRole)
			{
				_avatarIcon.texture = avatarRole.RoleAvatar;
			}
		}

		private void UpdateStats(float lerpT)
		{
			float num = _ahpStat.CurValue + _hsStat.CurValue;
			float curValue = _hpStat.CurValue;
			_shieldText.text = Mathf.CeilToInt(num).ToString();
			_healthText.text = Mathf.CeilToInt(curValue).ToString();
			_shieldIcon.enabled = num > 0f;
			_shieldText.enabled = num > 0f;
			float b = _hpStat.CurValue / _hpStat.MaxValue;
			_healthCircle.fillAmount = Mathf.Lerp(_healthCircle.fillAmount, b, lerpT);
		}

		private void UpdateColor(Color c)
		{
			Color color = c - _prevColor;
			if (!(color.r * color.r + color.g * color.g + color.b * color.b + color.a * color.a < 1E-10f))
			{
				_prevColor = c;
				_roleText.color = c;
				_healthCircle.color = c;
				_healthIcon.color = c;
				_healthText.color = c;
				_avatarBackground.color = SpectatableListColors.MixAvatarColor(c);
			}
		}

		protected override void OnTargetChanged(SpectatableModuleBase prevTarget, SpectatableModuleBase newTarget)
		{
			base.OnTargetChanged(prevTarget, newTarget);
			PlayerStats playerStats = newTarget.TargetHub.playerStats;
			_ahpStat = playerStats.GetModule<AhpStat>();
			_hpStat = playerStats.GetModule<HealthStat>();
			_hsStat = playerStats.GetModule<HumeShieldStat>();
			UpdateStats(1f);
		}
	}
}

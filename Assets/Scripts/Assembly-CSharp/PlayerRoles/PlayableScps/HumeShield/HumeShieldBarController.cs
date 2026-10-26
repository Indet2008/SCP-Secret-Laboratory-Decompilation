using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.PlayableScps.HumeShield
{
	public class HumeShieldBarController : MonoBehaviour
	{
		[SerializeField]
		private StatusBar _targetBar;

		[SerializeField]
		private Image _hsWarning;

		[SerializeField]
		private Color _hsColor;

		private float _colorTimer;

		private bool _prevVisible;

		private bool _firstFrame;

		private const float FadeSpeed = 8f;

		private const float BlinkSpeed = 35f;

		private void Awake()
		{
			_targetBar.AutohideOption = StatusBar.AutoHideType.AlwaysVisible;
			_firstFrame = true;
			if (ReferenceHub.TryGetPovHub(out var hub) && hub.roleManager.CurrentRole is IHumeShieldedRole humeShieldedRole && humeShieldedRole.HumeShieldModule.HideWhenEmpty)
			{
				_targetBar.AutohideOption = StatusBar.AutoHideType.WhenEmpty;
			}
		}

		private void Update()
		{
			GetValues(out var barVisible, out var warningColor);
			if (_firstFrame || barVisible != _prevVisible)
			{
				_targetBar.SetAlpha(barVisible ? 1 : 0);
				_firstFrame = true;
				_prevVisible = barVisible;
			}
			if (warningColor.HasValue)
			{
				Color value = warningColor.Value;
				Color hsColor = _hsColor;
				float num = 35f * value.a;
				hsColor.a = (value.a = Mathf.Min(1f, _colorTimer * 8f));
				float t = (Mathf.Sin(_colorTimer * num) + 1f) / 2f;
				_hsWarning.color = Color.Lerp(hsColor, value, t);
				_colorTimer += Time.deltaTime;
			}
			else
			{
				Color color = _hsWarning.color;
				color.a = Mathf.Max(0f, color.a - Time.deltaTime * 8f);
				_hsWarning.color = color;
				_colorTimer = 0f;
			}
		}

		private void GetValues(out bool barVisible, out Color? warningColor)
		{
			barVisible = false;
			warningColor = null;
			if (ReferenceHub.TryGetPovHub(out var hub))
			{
				IHumeShieldProvider.GetForHub(hub, out var stat, out barVisible, out var _, out var _, out warningColor);
				barVisible |= stat.CurValue > 0f;
			}
		}
	}
}

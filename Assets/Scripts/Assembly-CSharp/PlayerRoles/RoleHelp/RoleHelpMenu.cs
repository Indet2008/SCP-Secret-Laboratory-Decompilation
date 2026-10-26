using CursorManagement;
using ToggleableMenus;
using UnityEngine;

namespace PlayerRoles.RoleHelp
{
	public class RoleHelpMenu : ToggleableMenuBase
	{
		private bool _instanceSet;

		private GameObject _instance;

		private bool _fading;

		[SerializeField]
		private Transform _parent;

		[SerializeField]
		private GameObject _root;

		[SerializeField]
		private CanvasGroup _fader;

		[SerializeField]
		private float _fadeSpeed;

		public override bool CanToggle => _instanceSet;

		public override CursorOverrideMode CursorOverride => CursorOverrideMode.NoOverride;

		protected override void OnToggled()
		{
			_fading = true;
			_root.SetActive(value: true);
		}

		protected override void Awake()
		{
			base.Awake();
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
		}

		private void Update()
		{
			if (_fading && UpdateAlpha(IsEnabled ? _fadeSpeed : (0f - _fadeSpeed)))
			{
				_fading = false;
				_root.SetActive(IsEnabled);
			}
		}

		private bool UpdateAlpha(float speed)
		{
			float alpha = _fader.alpha;
			alpha = Mathf.Clamp01(alpha + Time.deltaTime * speed);
			bool result = alpha == 1f;
			bool result2 = alpha == 0f;
			_fader.alpha = alpha;
			if (!(speed > 0f))
			{
				return result2;
			}
			return result;
		}

		private void OnRoleChanged(ReferenceHub hub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (hub.isLocalPlayer)
			{
				IsEnabled = false;
				if (_instanceSet)
				{
					Object.Destroy(_instance);
					_instanceSet = false;
				}
				GameObject roleHelpInfo = newRole.RoleHelpInfo;
				if (!(roleHelpInfo == null))
				{
					_instance = Object.Instantiate(roleHelpInfo, _parent);
					_instanceSet = true;
				}
			}
		}
	}
}

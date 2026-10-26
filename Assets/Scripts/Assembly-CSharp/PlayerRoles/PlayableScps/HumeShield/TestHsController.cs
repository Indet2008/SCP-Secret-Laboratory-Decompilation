using UnityEngine;

namespace PlayerRoles.PlayableScps.HumeShield
{
	public class TestHsController : HumeShieldModuleBase
	{
		[SerializeField]
		private float _regeneration;

		[SerializeField]
		private float _maxAmount;

		[Space]
		[SerializeField]
		private Color _color;

		[SerializeField]
		private bool _colorActive;

		[Space]
		[SerializeField]
		private float _amountToModify;

		[SerializeField]
		private bool _apply;

		[SerializeField]
		private bool _hideWhenEmpty;

		public override float HsMax => _maxAmount;

		public override float HsRegeneration => _regeneration;

		public override Color? HsWarningColor
		{
			get
			{
				if (!_colorActive)
				{
					return null;
				}
				return _color;
			}
		}

		public override bool HideWhenEmpty => _hideWhenEmpty;

		private void Update()
		{
			if (_apply)
			{
				base.HsCurrent += _amountToModify;
				_apply = false;
			}
		}
	}
}

using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public abstract class Scp079BarBaseGui : Scp079GuiElementBase
	{
		[SerializeField]
		private Image _slider;

		[SerializeField]
		private TextMeshProUGUI _textNormal;

		[SerializeField]
		private TextMeshProUGUI _textInverted;

		private RectMask2D _rectMask;

		private float _width;

		protected abstract string Text { get; }

		protected abstract float FillAmount { get; }

		private void Awake()
		{
			_rectMask = _slider.GetComponent<RectMask2D>();
			_width = _slider.rectTransform.rect.width;
		}

		protected virtual void Update()
		{
			string text = Text;
			_textNormal.text = text;
			_textInverted.text = text;
			float num = Mathf.Clamp01(FillAmount);
			_slider.fillAmount = num;
			_rectMask.padding = _width * (1f - num) * Vector3.forward;
		}
	}
}

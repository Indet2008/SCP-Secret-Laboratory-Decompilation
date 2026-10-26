using UnityEngine;
using UnityEngine.UI;

namespace CustomPlayerEffects
{
	public class LerpIconVisuals : LerpVisualsBase
	{
		[SerializeField]
		private Image _icon;

		[SerializeField]
		private GameObject _iconParent;

		protected override void ApplyWeight(float weight)
		{
			if (_iconParent != null)
			{
				_iconParent.SetActive(weight > 0f);
			}
			if (_icon != null)
			{
				Color color = _icon.color;
				color.a = weight;
				_icon.color = color;
			}
		}
	}
}

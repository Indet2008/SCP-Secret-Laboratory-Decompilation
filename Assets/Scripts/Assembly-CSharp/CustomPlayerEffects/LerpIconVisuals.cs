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

		protected override void OnWeightChanged(float weight)
		{
			_icon.fillAmount = weight;
		}

		protected override void OnActivated()
		{
			_iconParent.SetActive(value: true);
		}

		protected override void OnShutdown()
		{
			_iconParent.SetActive(value: false);
		}
	}
}

using InventorySystem.Items.Firearms;
using InventorySystem.Items.Firearms.Modules;
using UnityEngine;

namespace InventorySystem.Crosshairs
{
	public class BuckshotCrosshair : FirearmCrosshairBase
	{
		[SerializeField]
		private RectTransform[] _elements;

		[SerializeField]
		private float _displacementRatio;

		[SerializeField]
		private float _radiusRatio;

		[SerializeField]
		private float _lerpSpeed;

		private void SetupElements(float innerAngle, float buckshotRadius)
		{
			RectTransform[] elements = _elements;
			foreach (RectTransform obj in elements)
			{
				Vector2 b = _displacementRatio * innerAngle * Vector2.up;
				obj.anchoredPosition = Vector2.Lerp(obj.anchoredPosition, b, Time.deltaTime * _lerpSpeed);
				obj.sizeDelta = _radiusRatio * buckshotRadius * Vector2.one;
			}
		}

		protected override void UpdateCrosshair(Firearm firearm, float currentInaccuracy)
		{
			if (firearm.TryGetModule<BuckshotHitreg>(out var module, ignoreSubmodules: false))
			{
				SetupElements(currentInaccuracy, module.BuckshotScale);
			}
		}
	}
}

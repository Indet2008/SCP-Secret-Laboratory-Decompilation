using InventorySystem.Items.Firearms;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Modules;
using UnityEngine;

namespace InventorySystem.Crosshairs
{
	public abstract class FirearmCrosshairBase : MonoBehaviour
	{
		[SerializeField]
		private CanvasGroup _fadeGroup;

		protected virtual float GetAlpha(Firearm firearm)
		{
			bool flag = firearm.HasDownsideFlag(AttachmentDescriptiveDownsides.Laser);
			bool flag2 = Cursor.visible | flag;
			if (flag | flag2)
			{
				return 0f;
			}
			float adsAmount = GetAdsAmount(firearm);
			return 1f - adsAmount;
		}

		private float GetAdsAmount(Firearm firearm)
		{
			if (!firearm.TryGetModule<IAdsModule>(out var module))
			{
				return 0f;
			}
			return module.AdsAmount * 3.2f;
		}

		private void Update()
		{
			if (!ReferenceHub.TryGetLocalHub(out var hub) || !(hub.inventory.CurInstance is Firearm firearm) || firearm == null)
			{
				return;
			}
			_fadeGroup.alpha = GetAlpha(firearm);
			float num = 0f;
			ModuleBase[] modules = firearm.Modules;
			for (int i = 0; i < modules.Length; i++)
			{
				if (modules[i] is IInaccuracyProviderModule inaccuracyProviderModule)
				{
					num += inaccuracyProviderModule.Inaccuracy;
				}
			}
			UpdateCrosshair(firearm, num);
		}

		protected abstract void UpdateCrosshair(Firearm firearm, float currentInaccuracy);
	}
}

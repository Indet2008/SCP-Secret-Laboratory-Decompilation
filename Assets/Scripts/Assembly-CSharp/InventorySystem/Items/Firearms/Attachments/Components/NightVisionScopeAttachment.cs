using InventorySystem.Items.Firearms.Modules;

namespace InventorySystem.Items.Firearms.Attachments.Components
{
	public class NightVisionScopeAttachment : SerializableAttachment, ILightEmittingItem
	{
		private const float AdsThreshold = 0.6f;

		public bool IsEmittingLight
		{
			get
			{
				if (IsEnabled && base.Firearm.TryGetModule<IAdsModule>(out var module))
				{
					return module.AdsAmount > 0.6f;
				}
				return false;
			}
		}
	}
}

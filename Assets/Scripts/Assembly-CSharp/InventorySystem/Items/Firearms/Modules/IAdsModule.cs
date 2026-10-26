namespace InventorySystem.Items.Firearms.Modules
{
	[UniqueModule]
	public interface IAdsModule
	{
		bool AdsTarget { get; }

		float AdsAmount { get; }

		void GetDisplayAdsValues(ushort serial, out bool adsTarget, out float adsAmount);
	}
}

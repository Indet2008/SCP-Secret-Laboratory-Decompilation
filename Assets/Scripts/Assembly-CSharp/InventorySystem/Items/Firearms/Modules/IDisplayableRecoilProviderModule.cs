namespace InventorySystem.Items.Firearms.Modules
{
	[UniqueModule]
	public interface IDisplayableRecoilProviderModule
	{
		float DisplayHipRecoilDegrees { get; }

		float DisplayAdsRecoilDegrees { get; }
	}
}

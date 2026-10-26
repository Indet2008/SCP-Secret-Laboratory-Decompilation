namespace InventorySystem.Items.Firearms.Modules
{
	public class AnimationTriggerReloaderModule : AnimatorReloaderModuleBase
	{
		protected override void StartReloading()
		{
			base.Firearm.AnimSetTrigger(FirearmAnimatorHashes.Reload);
		}

		protected override void StartUnloading()
		{
			base.Firearm.AnimSetTrigger(FirearmAnimatorHashes.Unload);
		}
	}
}

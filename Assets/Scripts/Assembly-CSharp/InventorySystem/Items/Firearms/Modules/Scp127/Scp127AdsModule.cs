namespace InventorySystem.Items.Firearms.Modules.Scp127
{
	public class Scp127AdsModule : LinearAdsModule
	{
		private static readonly float LengthMultiplier = 2f;

		public override float MovementSpeedLimit => LinearAdsModule.MovementLimitRemap.Get(base.AdsAmount * base.Firearm.Length * LengthMultiplier);
	}
}

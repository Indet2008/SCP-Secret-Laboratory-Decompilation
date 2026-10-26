namespace PlayerRoles.PlayableScps.HumeShield
{
	public class PercentageHumeShieldController : DynamicHumeShieldController
	{
		public override float HsRegeneration
		{
			get
			{
				float num = base.HsRegeneration * 0.01f;
				return HsMax * num;
			}
		}
	}
}

internal class LifeFriendlyFireDetector : FriendlyFireDetector
{
	private const string Detector = "Life";

	internal LifeFriendlyFireDetector(ReferenceHub hub)
		: base(hub)
	{
	}

	public override bool RegisterDamage(float damage)
	{
		if (!FriendlyFireConfig.LifeEnabled || _triggered)
		{
			return false;
		}
		base.RegisterDamage(damage);
		if (FriendlyFireConfig.LifeDamageThreshold != 0 && base.Damage >= (float)FriendlyFireConfig.LifeDamageThreshold)
		{
			TakeAction(ref FriendlyFireConfig.LifeAction, "Life", ref FriendlyFireConfig.LifeBanTime, ref FriendlyFireConfig.LifeBanReason, ref FriendlyFireConfig.LifeKillReason, ref FriendlyFireConfig.LifeAdminMessage, ref FriendlyFireConfig.LifeBroadcastMessage, ref FriendlyFireConfig.LifeWebhook);
			return true;
		}
		return false;
	}

	public override bool RegisterKill()
	{
		if (!FriendlyFireConfig.LifeEnabled || _triggered)
		{
			return false;
		}
		base.RegisterKill();
		if (FriendlyFireConfig.LifeKillThreshold != 0 && base.Kills >= FriendlyFireConfig.LifeKillThreshold)
		{
			TakeAction(ref FriendlyFireConfig.LifeAction, "Life", ref FriendlyFireConfig.LifeBanTime, ref FriendlyFireConfig.LifeBanReason, ref FriendlyFireConfig.LifeKillReason, ref FriendlyFireConfig.LifeAdminMessage, ref FriendlyFireConfig.LifeBroadcastMessage, ref FriendlyFireConfig.LifeWebhook);
			return true;
		}
		return false;
	}
}

internal class RoundFriendlyFireDetector : FriendlyFireDetector
{
	private const string Detector = "Round";

	internal RoundFriendlyFireDetector(ReferenceHub hub)
		: base(hub)
	{
	}

	public override bool RegisterDamage(float damage)
	{
		if (!FriendlyFireConfig.RoundEnabled || _triggered)
		{
			return false;
		}
		base.RegisterDamage(damage);
		if (FriendlyFireConfig.RoundDamageThreshold != 0 && base.Damage >= (float)FriendlyFireConfig.RoundDamageThreshold)
		{
			TakeAction(ref FriendlyFireConfig.RoundAction, "Round", ref FriendlyFireConfig.RoundBanTime, ref FriendlyFireConfig.RoundBanReason, ref FriendlyFireConfig.RoundKillReason, ref FriendlyFireConfig.RoundAdminMessage, ref FriendlyFireConfig.RoundBroadcastMessage, ref FriendlyFireConfig.RoundWebhook);
			return true;
		}
		return false;
	}

	public override bool RegisterKill()
	{
		if (!FriendlyFireConfig.RoundEnabled || _triggered)
		{
			return false;
		}
		base.RegisterKill();
		if (FriendlyFireConfig.RoundKillThreshold != 0 && base.Kills >= FriendlyFireConfig.RoundKillThreshold)
		{
			TakeAction(ref FriendlyFireConfig.RoundAction, "Round", ref FriendlyFireConfig.RoundBanTime, ref FriendlyFireConfig.RoundBanReason, ref FriendlyFireConfig.RoundKillReason, ref FriendlyFireConfig.RoundAdminMessage, ref FriendlyFireConfig.RoundBroadcastMessage, ref FriendlyFireConfig.RoundWebhook);
			return true;
		}
		return false;
	}
}

using UnityEngine;

internal class RespawnFriendlyFireDetector : FriendlyFireDetector
{
	private const string Detector = "Respawn";

	private float _lastReset = Time.unscaledTime;

	internal RespawnFriendlyFireDetector(ReferenceHub hub)
		: base(hub)
	{
	}

	public override bool RegisterDamage(float damage)
	{
		if (!FriendlyFireConfig.RespawnEnabled || _triggered || Time.unscaledTime > _lastReset + (float)FriendlyFireConfig.RespawnWindow)
		{
			return false;
		}
		base.RegisterDamage(damage);
		if (FriendlyFireConfig.RespawnDamageThreshold != 0 && base.Damage >= (float)FriendlyFireConfig.RespawnDamageThreshold)
		{
			TakeAction(ref FriendlyFireConfig.RespawnAction, "Respawn", ref FriendlyFireConfig.RespawnBanTime, ref FriendlyFireConfig.RespawnBanReason, ref FriendlyFireConfig.RespawnKillReason, ref FriendlyFireConfig.RespawnAdminMessage, ref FriendlyFireConfig.RespawnBroadcastMessage, ref FriendlyFireConfig.RespawnWebhook);
			return true;
		}
		return false;
	}

	public override bool RegisterKill()
	{
		if (!FriendlyFireConfig.RespawnEnabled || _triggered || Time.unscaledTime > _lastReset + (float)FriendlyFireConfig.RespawnWindow)
		{
			return false;
		}
		base.RegisterKill();
		if (FriendlyFireConfig.RespawnKillThreshold != 0 && base.Kills >= FriendlyFireConfig.RespawnKillThreshold)
		{
			TakeAction(ref FriendlyFireConfig.RespawnAction, "Respawn", ref FriendlyFireConfig.RespawnBanTime, ref FriendlyFireConfig.RespawnBanReason, ref FriendlyFireConfig.RespawnKillReason, ref FriendlyFireConfig.RespawnAdminMessage, ref FriendlyFireConfig.RespawnBroadcastMessage, ref FriendlyFireConfig.RespawnWebhook);
			return true;
		}
		return false;
	}

	public override void Reset()
	{
		base.Reset();
		_lastReset = Time.unscaledTime;
	}
}

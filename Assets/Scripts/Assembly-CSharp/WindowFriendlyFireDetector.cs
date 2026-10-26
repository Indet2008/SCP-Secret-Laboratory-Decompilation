using UnityEngine;

internal class WindowFriendlyFireDetector : FriendlyFireDetector
{
	private const string Detector = "Window";

	private float _lastReset = Time.unscaledTime;

	internal WindowFriendlyFireDetector(ReferenceHub hub)
		: base(hub)
	{
	}

	public override bool RegisterDamage(float damage)
	{
		if (!FriendlyFireConfig.WindowEnabled || _triggered)
		{
			return false;
		}
		if (Time.unscaledTime > _lastReset + (float)FriendlyFireConfig.Window)
		{
			Reset();
			_lastReset = Time.unscaledTime;
		}
		base.RegisterDamage(damage);
		if (FriendlyFireConfig.WindowDamageThreshold != 0 && base.Damage >= (float)FriendlyFireConfig.WindowDamageThreshold)
		{
			TakeAction(ref FriendlyFireConfig.WindowAction, "Window", ref FriendlyFireConfig.WindowBanTime, ref FriendlyFireConfig.WindowBanReason, ref FriendlyFireConfig.WindowKillReason, ref FriendlyFireConfig.WindowAdminMessage, ref FriendlyFireConfig.WindowBroadcastMessage, ref FriendlyFireConfig.WindowWebhook);
			return true;
		}
		return false;
	}

	public override bool RegisterKill()
	{
		if (!FriendlyFireConfig.WindowEnabled || _triggered)
		{
			return false;
		}
		if (Time.unscaledTime > _lastReset + (float)FriendlyFireConfig.Window)
		{
			Reset();
			_lastReset = Time.unscaledTime;
		}
		base.RegisterKill();
		if (FriendlyFireConfig.WindowKillThreshold != 0 && base.Kills >= FriendlyFireConfig.WindowKillThreshold)
		{
			TakeAction(ref FriendlyFireConfig.WindowAction, "Window", ref FriendlyFireConfig.WindowBanTime, ref FriendlyFireConfig.WindowBanReason, ref FriendlyFireConfig.WindowKillReason, ref FriendlyFireConfig.WindowAdminMessage, ref FriendlyFireConfig.WindowBroadcastMessage, ref FriendlyFireConfig.WindowWebhook);
			return true;
		}
		return false;
	}
}

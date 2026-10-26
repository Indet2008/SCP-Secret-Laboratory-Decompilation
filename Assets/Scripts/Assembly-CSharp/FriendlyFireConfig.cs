using System.Globalization;

internal static class FriendlyFireConfig
{
	internal static bool RoundEnabled;

	internal static bool LifeEnabled;

	internal static bool WindowEnabled;

	internal static bool RespawnEnabled;

	internal static bool ExplosionAfterDisconnecting;

	internal static FriendlyFireAction RoundAction;

	internal static FriendlyFireAction LifeAction;

	internal static FriendlyFireAction WindowAction;

	internal static FriendlyFireAction RespawnAction;

	internal static FriendlyFireAction ExplosionAfterDisconnectingAction;

	internal static uint RoundKillThreshold;

	internal static uint LifeKillThreshold;

	internal static uint WindowKillThreshold;

	internal static uint RespawnKillThreshold;

	internal static uint RoundDamageThreshold;

	internal static uint LifeDamageThreshold;

	internal static uint WindowDamageThreshold;

	internal static uint RespawnDamageThreshold;

	internal static long RoundBanTime;

	internal static long LifeBanTime;

	internal static long WindowBanTime;

	internal static long RespawnBanTime;

	internal static long ExplosionAfterDisconnectingTime;

	internal static string RoundBanReason;

	internal static string LifeBanReason;

	internal static string WindowBanReason;

	internal static string RespawnBanReason;

	internal static string ExplosionAfterDisconnectingBanReason;

	internal static string RoundKillReason;

	internal static string LifeKillReason;

	internal static string WindowKillReason;

	internal static string RespawnKillReason;

	internal static string RoundAdminMessage;

	internal static string LifeAdminMessage;

	internal static string WindowAdminMessage;

	internal static string RespawnAdminMessage;

	internal static string ExplosionAfterDisconnectingAdminMessage;

	internal static string RoundBroadcastMessage;

	internal static string LifeBroadcastMessage;

	internal static string WindowBroadcastMessage;

	internal static string RespawnBroadcastMessage;

	internal static string ExplosionAfterDisconnectingBroadcastMessage;

	internal static bool RoundWebhook;

	internal static bool LifeWebhook;

	internal static bool WindowWebhook;

	internal static bool RespawnWebhook;

	internal static bool ExplosionAfterDisconnectingWebhook;

	internal static uint Window;

	internal static uint RespawnWindow;

	internal static ushort BroadcastTime;

	internal static ushort AdminChatTime;

	internal static bool IgnoreClassDTeamkills;

	internal static string WebhookUrl;

	internal static bool PauseDetector;

	internal static FriendlyFireAction ParseAction(string action)
	{
		return action.ToLower(CultureInfo.InvariantCulture) switch
		{
			"kill" => FriendlyFireAction.Kill, 
			"kick" => FriendlyFireAction.Kick, 
			"ban" => FriendlyFireAction.Ban, 
			_ => FriendlyFireAction.Noop, 
		};
	}
}

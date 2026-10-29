namespace LabApi.Events.Handlers
{
	public static class Scp106Events
	{
		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp106Events.Scp106ChangingStalkModeEventArgs>? ChangingStalkMode;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp106Events.Scp106ChangedStalkModeEventArgs>? ChangedStalkMode;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp106Events.Scp106ChangingVigorEventArgs>? ChangingVigor;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp106Events.Scp106ChangedVigorEventArgs>? ChangedVigor;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp106Events.Scp106UsedHunterAtlasEventArgs>? UsedHunterAtlas;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp106Events.Scp106UsingHunterAtlasEventArgs>? UsingHunterAtlas;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp106Events.Scp106ChangingSubmersionStatusEventArgs>? ChangingSubmersionStatus;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp106Events.Scp106ChangedSubmersionStatusEventArgs>? ChangedSubmersionStatus;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp106Events.Scp106TeleportingPlayerEvent>? TeleportingPlayer;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp106Events.Scp106TeleportedPlayerEvent>? TeleportedPlayer;

		public static void OnChangingStalkMode(global::LabApi.Events.Arguments.Scp106Events.Scp106ChangingStalkModeEventArgs ev)
		{
			ChangingStalkMode.InvokeEvent(ev);
		}

		public static void OnChangedStalkMode(global::LabApi.Events.Arguments.Scp106Events.Scp106ChangedStalkModeEventArgs ev)
		{
			ChangedStalkMode.InvokeEvent(ev);
		}

		public static void OnChangingVigor(global::LabApi.Events.Arguments.Scp106Events.Scp106ChangingVigorEventArgs ev)
		{
			ChangingVigor.InvokeEvent(ev);
		}

		public static void OnChangedVigor(global::LabApi.Events.Arguments.Scp106Events.Scp106ChangedVigorEventArgs ev)
		{
			ChangedVigor.InvokeEvent(ev);
		}

		public static void OnUsedHunterAtlas(global::LabApi.Events.Arguments.Scp106Events.Scp106UsedHunterAtlasEventArgs ev)
		{
			UsedHunterAtlas.InvokeEvent(ev);
		}

		public static void OnUsingHunterAtlas(global::LabApi.Events.Arguments.Scp106Events.Scp106UsingHunterAtlasEventArgs ev)
		{
			UsingHunterAtlas.InvokeEvent(ev);
		}

		public static void OnChangingSubmersionStatus(global::LabApi.Events.Arguments.Scp106Events.Scp106ChangingSubmersionStatusEventArgs ev)
		{
			ChangingSubmersionStatus.InvokeEvent(ev);
		}

		public static void OnChangedSubmersionStatus(global::LabApi.Events.Arguments.Scp106Events.Scp106ChangedSubmersionStatusEventArgs ev)
		{
			ChangedSubmersionStatus.InvokeEvent(ev);
		}

		public static void OnTeleportingPlayer(global::LabApi.Events.Arguments.Scp106Events.Scp106TeleportingPlayerEvent ev)
		{
			TeleportingPlayer.InvokeEvent(ev);
		}

		public static void OnTeleportedPlayer(global::LabApi.Events.Arguments.Scp106Events.Scp106TeleportedPlayerEvent ev)
		{
			TeleportedPlayer.InvokeEvent(ev);
		}
	}
}

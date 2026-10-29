namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerCheckedHitmarkerEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Victim { get; }

		public global::PlayerStatsSystem.AttackerDamageHandler DamageHandler { get; }

		public bool Result { get; }

		public PlayerCheckedHitmarkerEventArgs(ReferenceHub hub, global::PlayerStatsSystem.AttackerDamageHandler adh, ReferenceHub victim, bool result)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			DamageHandler = adh;
			Victim = global::LabApi.Features.Wrappers.Player.Get(victim);
			Result = result;
		}
	}
}

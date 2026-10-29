namespace LabApi.Events.Arguments.Scp079Events
{
	public class Scp079LeveledUpEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public int Tier { get; }

		public Scp079LeveledUpEventArgs(ReferenceHub hub, int tier)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Tier = tier;
		}
	}
}

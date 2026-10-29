namespace LabApi.Events.Arguments.Scp079Events
{
	public class Scp079LevelingUpEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public int Tier { get; }

		public bool IsAllowed { get; set; }

		public Scp079LevelingUpEventArgs(ReferenceHub hub, int tier)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Tier = tier;
			IsAllowed = true;
		}
	}
}

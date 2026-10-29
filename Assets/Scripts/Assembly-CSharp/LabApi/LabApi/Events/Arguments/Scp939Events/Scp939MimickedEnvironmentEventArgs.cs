namespace LabApi.Events.Arguments.Scp939Events
{
	public class Scp939MimickedEnvironmentEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public byte PlayedSequence { get; }

		public Scp939MimickedEnvironmentEventArgs(ReferenceHub hub, byte playedSequence)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			PlayedSequence = playedSequence;
		}
	}
}

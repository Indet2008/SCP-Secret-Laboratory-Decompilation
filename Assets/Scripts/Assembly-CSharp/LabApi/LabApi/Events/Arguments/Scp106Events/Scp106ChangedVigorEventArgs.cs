namespace LabApi.Events.Arguments.Scp106Events
{
	public class Scp106ChangedVigorEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public float OldValue { get; }

		public float Value { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public Scp106ChangedVigorEventArgs(ReferenceHub hub, float oldVigor, float newVigor)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			OldValue = oldVigor;
			Value = newVigor;
		}
	}
}

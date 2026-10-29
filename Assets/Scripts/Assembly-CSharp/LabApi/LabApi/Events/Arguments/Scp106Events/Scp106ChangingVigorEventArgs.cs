namespace LabApi.Events.Arguments.Scp106Events
{
	public class Scp106ChangingVigorEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public float OldValue { get; }

		public float Value { get; set; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool IsAllowed { get; set; }

		public Scp106ChangingVigorEventArgs(ReferenceHub hub, float oldValue, float value)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			OldValue = oldValue;
			Value = value;
			IsAllowed = true;
		}
	}
}

namespace LabApi.Events.Arguments.Scp939Events
{
	public class Scp939MimickingEnvironmentEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public byte SelectedSequence { get; set; }

		public float CooldownTime { get; set; }

		public bool IsAllowed { get; set; }

		public Scp939MimickingEnvironmentEventArgs(ReferenceHub hub, byte selectedSequence, float cooldownTime)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			SelectedSequence = selectedSequence;
			CooldownTime = cooldownTime;
			IsAllowed = true;
		}
	}
}

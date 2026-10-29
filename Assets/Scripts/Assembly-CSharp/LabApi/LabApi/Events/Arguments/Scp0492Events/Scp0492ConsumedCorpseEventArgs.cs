namespace LabApi.Events.Arguments.Scp0492Events
{
	public class Scp0492ConsumedCorpseEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IRagdollEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Ragdoll Ragdoll { get; }

		public Scp0492ConsumedCorpseEventArgs(ReferenceHub hub, global::PlayerRoles.Ragdolls.BasicRagdoll ragdoll)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Ragdoll = global::LabApi.Features.Wrappers.Ragdoll.Get(ragdoll);
		}
	}
}

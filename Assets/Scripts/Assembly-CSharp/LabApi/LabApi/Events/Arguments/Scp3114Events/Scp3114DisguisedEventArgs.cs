namespace LabApi.Events.Arguments.Scp3114Events
{
	public class Scp3114DisguisedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IRagdollEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Ragdoll Ragdoll { get; }

		public Scp3114DisguisedEventArgs(ReferenceHub player, global::PlayerRoles.Ragdolls.BasicRagdoll ragdoll)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(player);
			Ragdoll = global::LabApi.Features.Wrappers.Ragdoll.Get(ragdoll);
		}
	}
}

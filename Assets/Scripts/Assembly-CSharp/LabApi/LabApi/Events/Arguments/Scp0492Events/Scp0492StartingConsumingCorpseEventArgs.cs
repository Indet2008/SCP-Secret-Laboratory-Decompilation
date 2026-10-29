namespace LabApi.Events.Arguments.Scp0492Events
{
	public class Scp0492StartingConsumingCorpseEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IRagdollEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::PlayerRoles.PlayableScps.Scp049.Zombies.ZombieConsumeAbility.ConsumeError Error { get; set; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Ragdoll Ragdoll { get; }

		public bool IsAllowed
		{
			get
			{
				return Error == global::PlayerRoles.PlayableScps.Scp049.Zombies.ZombieConsumeAbility.ConsumeError.None;
			}
			set
			{
				Error = ((!value) ? global::PlayerRoles.PlayableScps.Scp049.Zombies.ZombieConsumeAbility.ConsumeError.TargetNotValid : global::PlayerRoles.PlayableScps.Scp049.Zombies.ZombieConsumeAbility.ConsumeError.None);
			}
		}

		public Scp0492StartingConsumingCorpseEventArgs(ReferenceHub hub, global::PlayerRoles.Ragdolls.BasicRagdoll ragdoll, global::PlayerRoles.PlayableScps.Scp049.Zombies.ZombieConsumeAbility.ConsumeError error)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Ragdoll = global::LabApi.Features.Wrappers.Ragdoll.Get(ragdoll);
			Error = error;
		}
	}
}

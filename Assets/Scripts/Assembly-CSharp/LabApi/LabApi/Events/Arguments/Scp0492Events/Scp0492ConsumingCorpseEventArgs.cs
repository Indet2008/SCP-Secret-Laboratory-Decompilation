namespace LabApi.Events.Arguments.Scp0492Events
{
	public class Scp0492ConsumingCorpseEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IRagdollEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public float HealAmount { get; set; }

		public bool AddToConsumedRagdollList { get; set; } = true;

		public bool HealIfAlreadyConsumed { get; set; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Ragdoll Ragdoll { get; }

		public bool IsAllowed { get; set; }

		public Scp0492ConsumingCorpseEventArgs(ReferenceHub hub, global::PlayerRoles.Ragdolls.BasicRagdoll ragdoll, float healAmount)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Ragdoll = global::LabApi.Features.Wrappers.Ragdoll.Get(ragdoll);
			HealAmount = healAmount;
		}
	}
}

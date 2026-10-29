namespace LabApi.Events.Arguments.Scp079Events
{
	public class Scp079GainingExperienceEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public float Amount { get; set; }

		public global::PlayerRoles.PlayableScps.Scp079.Scp079HudTranslation Reason { get; set; }

		public global::PlayerRoles.RoleTypeId Subject { get; set; }

		public bool IsAllowed { get; set; }

		public Scp079GainingExperienceEventArgs(ReferenceHub hub, float amount, global::PlayerRoles.PlayableScps.Scp079.Scp079HudTranslation reason, global::PlayerRoles.RoleTypeId subject)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Amount = amount;
			Reason = reason;
			Subject = subject;
			IsAllowed = true;
		}
	}
}

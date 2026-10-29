namespace LabApi.Events.Arguments.Scp079Events
{
	public class Scp079GainedExperienceEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public float Amount { get; }

		public global::PlayerRoles.PlayableScps.Scp079.Scp079HudTranslation Reason { get; }

		public global::PlayerRoles.RoleTypeId Subject { get; }

		public Scp079GainedExperienceEventArgs(ReferenceHub hub, float amount, global::PlayerRoles.PlayableScps.Scp079.Scp079HudTranslation reason, global::PlayerRoles.RoleTypeId subject)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Amount = amount;
			Reason = reason;
			Subject = subject;
		}
	}
}

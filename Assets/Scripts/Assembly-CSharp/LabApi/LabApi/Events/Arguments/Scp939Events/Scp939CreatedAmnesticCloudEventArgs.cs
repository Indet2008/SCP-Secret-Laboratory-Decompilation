namespace LabApi.Events.Arguments.Scp939Events
{
	public class Scp939CreatedAmnesticCloudEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IAmnesticCloudEvent, global::LabApi.Events.Arguments.Interfaces.IHazardEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.AmnesticCloudHazard AmnesticCloud { get; }

		[global::System.Obsolete("Use AmnesticCloud instead")]
		public global::LabApi.Features.Wrappers.AmnesticCloudHazard AmnesticCloudInstance => AmnesticCloud;

		public Scp939CreatedAmnesticCloudEventArgs(ReferenceHub hub, global::PlayerRoles.PlayableScps.Scp939.Scp939AmnesticCloudInstance amnesticCloudInstance)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			AmnesticCloud = global::LabApi.Features.Wrappers.AmnesticCloudHazard.Get(amnesticCloudInstance);
		}
	}
}

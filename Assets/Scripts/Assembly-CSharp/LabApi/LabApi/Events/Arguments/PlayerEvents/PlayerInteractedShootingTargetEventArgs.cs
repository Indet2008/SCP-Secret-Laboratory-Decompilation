namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerInteractedShootingTargetEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IShootingTargetEvent, global::LabApi.Events.Arguments.Interfaces.IAdminToyEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.ShootingTargetToy ShootingTarget { get; }

		[global::System.Obsolete("Use ShootingTarget instead")]
		public global::AdminToys.ShootingTarget Target => ShootingTarget.Base;

		public PlayerInteractedShootingTargetEventArgs(ReferenceHub hub, global::AdminToys.ShootingTarget target)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			ShootingTarget = global::LabApi.Features.Wrappers.ShootingTargetToy.Get(target);
		}
	}
}

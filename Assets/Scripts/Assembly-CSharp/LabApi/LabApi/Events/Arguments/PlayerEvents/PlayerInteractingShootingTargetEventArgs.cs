namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerInteractingShootingTargetEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IShootingTargetEvent, global::LabApi.Events.Arguments.Interfaces.IAdminToyEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.ShootingTargetToy ShootingTarget { get; }

		public bool IsAllowed { get; set; }

		[global::System.Obsolete("Use ShootingTarget instead")]
		public global::AdminToys.ShootingTarget Target => ShootingTarget.Base;

		public PlayerInteractingShootingTargetEventArgs(ReferenceHub hub, global::AdminToys.ShootingTarget target)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			ShootingTarget = global::LabApi.Features.Wrappers.ShootingTargetToy.Get(target);
		}
	}
}

namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerDamagedShootingTargetEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IShootingTargetEvent, global::LabApi.Events.Arguments.Interfaces.IAdminToyEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.ShootingTargetToy ShootingTarget { get; }

		public global::PlayerStatsSystem.DamageHandlerBase DamageHandler { get; }

		[global::System.Obsolete("Use ShootingTarget instead")]
		public global::AdminToys.ShootingTarget Target => ShootingTarget.Base;

		public PlayerDamagedShootingTargetEventArgs(ReferenceHub hub, global::AdminToys.ShootingTarget target, global::PlayerStatsSystem.DamageHandlerBase damageHandler)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			ShootingTarget = global::LabApi.Features.Wrappers.ShootingTargetToy.Get(target);
			DamageHandler = damageHandler;
		}
	}
}

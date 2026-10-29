namespace LabApi.Events.Arguments.Interfaces
{
	public interface IShootingTargetEvent : global::LabApi.Events.Arguments.Interfaces.IAdminToyEvent
	{
		global::LabApi.Features.Wrappers.AdminToy? global::LabApi.Events.Arguments.Interfaces.IAdminToyEvent.AdminToy => ShootingTarget;

		global::LabApi.Features.Wrappers.ShootingTargetToy? ShootingTarget { get; }
	}
}

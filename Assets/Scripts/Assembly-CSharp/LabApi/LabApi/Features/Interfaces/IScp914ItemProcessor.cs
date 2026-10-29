namespace LabApi.Features.Interfaces
{
	public interface IScp914ItemProcessor
	{
		static global::UnityEngine.Vector3 MoveVector => global::Scp914.Scp914Controller.MoveVector;

		bool UsePickupMethodOnly { get; }

		global::Scp914.Scp914Result UpgradeItem(global::Scp914.Scp914KnobSetting setting, global::LabApi.Features.Wrappers.Item item);

		global::Scp914.Scp914Result UpgradePickup(global::Scp914.Scp914KnobSetting setting, global::LabApi.Features.Wrappers.Pickup pickup);
	}
}

namespace InventorySystem.Items.Firearms.Modules
{
	public interface ISwayModifierModule
	{
		float WalkSwayScale => 1f;

		float JumpSwayScale => 1f;

		float BobbingSwayScale => 1f;
	}
}

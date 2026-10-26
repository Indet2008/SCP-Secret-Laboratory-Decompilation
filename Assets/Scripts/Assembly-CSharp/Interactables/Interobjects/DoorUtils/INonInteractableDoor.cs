namespace Interactables.Interobjects.DoorUtils
{
	public interface INonInteractableDoor
	{
		bool IgnoreLockdowns { get; }

		bool IgnoreRemoteAdmin { get; }
	}
}

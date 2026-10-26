using Interactables.Interobjects.DoorUtils;

namespace Interactables.Interobjects.DoorButtons
{
	public abstract class ButtonVariant : InteractableCollider
	{
		protected DoorVariant ParentDoor { get; private set; }

		public virtual void Init(DoorVariant door)
		{
			ParentDoor = door;
		}
	}
}

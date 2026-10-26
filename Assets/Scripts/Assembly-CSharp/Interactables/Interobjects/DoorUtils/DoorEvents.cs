using System;

namespace Interactables.Interobjects.DoorUtils
{
	public static class DoorEvents
	{
		public static event Action<DoorVariant, DoorAction, ReferenceHub> OnDoorAction = (DoorVariant variant, DoorAction action, ReferenceHub user) =>
		{
		};

		public static void TriggerAction(DoorVariant variant, DoorAction action, ReferenceHub user)
		{
			OnDoorAction(variant, action, user);
		}
	}
}

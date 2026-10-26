using UnityEngine;

namespace Interactables.Interobjects.DoorUtils
{
	public abstract class DoorVariantExtension : MonoBehaviour
	{
		public DoorVariant TargetDoor;

		private void OnValidate()
		{
			TargetDoor = GetComponent<DoorVariant>();
		}

		private void Awake()
		{
			if (!TargetDoor)
			{
				TargetDoor = GetComponent<DoorVariant>();
			}
		}
	}
}

using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.Wearables
{
	public readonly struct WearableGameObject
	{
		public readonly GameObject Source;

		public readonly Transform SourceTr;

		public readonly Vector3 GlobalScale;

		public WearableGameObject(GameObject source)
		{
			Source = source;
			SourceTr = Source.transform;
			GlobalScale = SourceTr.lossyScale;
		}
	}
}

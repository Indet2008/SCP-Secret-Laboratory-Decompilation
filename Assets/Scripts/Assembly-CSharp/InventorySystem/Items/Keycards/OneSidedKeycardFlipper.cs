using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class OneSidedKeycardFlipper : MonoBehaviour
	{
		private Transform _tr;

		[SerializeField]
		private Vector3 _facingDirection;

		[SerializeField]
		private Vector3 _flipRotation;

		private void Awake()
		{
			_tr = base.transform;
		}

		private void LateUpdate()
		{
			_tr.GetPositionAndRotation(out var position, out var rotation);
			Vector3 lhs = rotation * _facingDirection;
			Vector3 rhs = MainCameraController.LastPosition - position;
			if (!(Vector3.Dot(lhs, rhs) >= 0f))
			{
				_tr.localEulerAngles += _flipRotation;
			}
		}
	}
}

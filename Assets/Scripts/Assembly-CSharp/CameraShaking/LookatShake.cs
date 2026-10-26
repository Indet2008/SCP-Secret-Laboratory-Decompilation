using UnityEngine;

namespace CameraShaking
{
	public class LookatShake : IShakeEffect
	{
		private readonly Vector3 _point;

		public LookatShake(Vector3 point)
		{
			_point = point;
		}

		public bool GetEffect(ReferenceHub ply, out ShakeEffectValues shakeValues)
		{
			Transform playerCameraReference = ply.PlayerCameraReference;
			Vector3 eulerAngles = playerCameraReference.eulerAngles;
			Vector3 eulerAngles2 = Quaternion.LookRotation(_point - playerCameraReference.position).eulerAngles;
			float verticalLook = eulerAngles.x - eulerAngles2.x;
			float horizontalLook = eulerAngles2.y - eulerAngles.y;
			shakeValues = new ShakeEffectValues(null, null, null, 1f, verticalLook, horizontalLook);
			return false;
		}
	}
}

using UnityEngine;

namespace InventorySystem.Items.Jailbird
{
	public class JailbirdMaterialController : MonoBehaviour
	{
		private ushort _serial;

		[SerializeField]
		private Material _almostDepletedMat;

		[SerializeField]
		private Material _normalMat;

		[SerializeField]
		private Renderer _emissionRend;

		private void Update()
		{
			bool flag = JailbirdDeteriorationTracker.ReceivedStates.TryGetValue(_serial, out var value) && value >= JailbirdWearState.AlmostBroken;
			_emissionRend.sharedMaterial = (flag ? _almostDepletedMat : _normalMat);
		}

		public void SetSerial(ushort serial)
		{
			_serial = serial;
		}
	}
}

using InventorySystem.Items.Firearms.Modules;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class WorldmodelAutomaticActionExtension : MonoBehaviour, IWorldmodelExtension
	{
		private ushort _lastSerial;

		[SerializeField]
		private BipolarTransform[] _anyChambered;

		[SerializeField]
		private BipolarTransform[] _boltLocked;

		[SerializeField]
		private BipolarTransform[] _cocked;

		public void SetupWorldmodel(FirearmWorldmodel worldmodel)
		{
			_lastSerial = worldmodel.Identifier.SerialNumber;
			UpdateAllPolarity();
		}

		private void UpdateAllPolarity()
		{
			AutomaticActionModule.DecodeSyncFlags(_lastSerial, out var ammoChambered, out var boltLocked, out var cocked);
			UpdatePolarity(_anyChambered, ammoChambered > 0);
			UpdatePolarity(_boltLocked, boltLocked);
			UpdatePolarity(_cocked, cocked);
		}

		private void UpdatePolarity(BipolarTransform[] arr, bool polarity)
		{
			for (int i = 0; i < arr.Length; i++)
			{
				arr[i].Polarity = polarity;
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			AutomaticActionModule.OnSyncDataReceived += (ushort serial) =>
			{
				if (FirearmWorldmodel.Instances.TryGetValue(serial, out var value) && value.TryGetExtension<WorldmodelAutomaticActionExtension>(out var extension))
				{
					extension.UpdateAllPolarity();
				}
			};
		}
	}
}

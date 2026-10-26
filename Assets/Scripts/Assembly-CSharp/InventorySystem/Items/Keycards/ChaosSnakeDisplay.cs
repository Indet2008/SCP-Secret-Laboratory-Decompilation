using InventorySystem.Items.Keycards.Snake;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class ChaosSnakeDisplay : MonoBehaviour
	{
		[SerializeField]
		private SnakeDisplay _display;

		[SerializeField]
		private bool _checkForActiveInspect;

		private IIdentifierProvider _idProvider;

		private bool _firstTime;

		private void Awake()
		{
			_firstTime = true;
			_idProvider = GetComponentInParent<IIdentifierProvider>();
		}

		private void Update()
		{
			if (_idProvider == null)
			{
				return;
			}
			ushort serialNumber = _idProvider.ItemId.SerialNumber;
			if (_checkForActiveInspect)
			{
				bool flag = KeycardItem.StartInspectTimes.TryGetValue(serialNumber, out var value) && NetworkTime.time - value > 1.7000000476837158;
				_display.gameObject.SetActive(flag);
				if (!flag)
				{
					return;
				}
			}
			if (ChaosKeycardItem.SnakeSessions.TryGetValue(serialNumber, out var value2))
			{
				value2.UpdateDisplay(_display, _firstTime);
				_firstTime = false;
			}
		}
	}
}

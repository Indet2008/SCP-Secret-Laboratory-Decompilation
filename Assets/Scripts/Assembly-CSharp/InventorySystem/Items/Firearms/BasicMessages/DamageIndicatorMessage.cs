using Mirror;
using RelativePositioning;
using UnityEngine;

namespace InventorySystem.Items.Firearms.BasicMessages
{
	public struct DamageIndicatorMessage : NetworkMessage
	{
		public byte ReceivedDamage;

		public RelativePosition DamagePosition;

		public DamageIndicatorMessage(float damage, Vector3 position)
		{
			ReceivedDamage = (byte)Mathf.Clamp(Mathf.RoundToInt(damage), 1, 255);
			DamagePosition = new RelativePosition(position);
		}
	}
}

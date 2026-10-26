using System;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Attachments
{
	[Serializable]
	public struct AttachmentGameObjectGroup
	{
		public GameObject[] Group;

		public readonly void SetActive(bool state)
		{
			for (int i = 0; i < Group.Length; i++)
			{
				if ((bool)Group[i])
				{
					Group[i].SetActive(state);
				}
			}
		}
	}
}

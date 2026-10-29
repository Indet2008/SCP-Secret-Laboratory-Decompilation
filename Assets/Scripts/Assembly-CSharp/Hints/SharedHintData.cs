using TMPro;
using UnityEngine;

namespace Hints
{
	public readonly struct SharedHintData
	{
		public readonly ReferenceHub PlayerHub;

		public readonly TextMeshProUGUI Textbox;

		public SharedHintData(GameObject self, TextMeshProUGUI textbox)
		{
			PlayerHub = ReferenceHub.GetHub(self);
			Textbox = textbox;
		}
	}
}

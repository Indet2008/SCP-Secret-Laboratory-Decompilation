using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.Disarming
{
	// Restored from the 14.2.8 client disassembly.
	public class DisarmingGUI : MonoBehaviour
	{
		private const string TranslationKey = "Disarming";

		public static DisarmingGUI Singleton;

		public Image Circle;

		[SerializeField]
		private GameObject _disarmedMessageObject;

		[SerializeField]
		private TextMeshProUGUI _disarmedMessageText;

		[SerializeField]
		private TextMeshProUGUI _bottomText;

		private string _adminCuffed;

		private string _detainedFormat;

		private void Start()
		{
			Singleton = this;
			_detainedFormat = TranslationReader.Get("Disarming", 0, "You have been detained by {0}.");
			_adminCuffed = TranslationReader.Get("Disarming", 1, "an administrator");
			_bottomText.text = TranslationReader.Get("Disarming", 2, "Follow orders or ask teammates for help.");
		}

		private void Update()
		{
			bool active = false;
			if (ReferenceHub.TryGetLocalHub(out var hub))
			{
				foreach (DisarmedPlayers.DisarmedEntry entry in DisarmedPlayers.Entries)
				{
					if (entry.DisarmedPlayer != hub.netId)
					{
						continue;
					}
					active = true;
					if (entry.Disarmer != 0 && ReferenceHub.TryGetHubNetID(entry.Disarmer, out var hub2))
					{
						_disarmedMessageText.text = string.Format(_detainedFormat, hub2.nicknameSync.MyNick);
						_bottomText.enabled = true;
					}
					else
					{
						_disarmedMessageText.text = string.Format(_detainedFormat, _adminCuffed);
						_bottomText.enabled = false;
					}
					break;
				}
			}
			_disarmedMessageObject.SetActive(active);
		}
	}
}

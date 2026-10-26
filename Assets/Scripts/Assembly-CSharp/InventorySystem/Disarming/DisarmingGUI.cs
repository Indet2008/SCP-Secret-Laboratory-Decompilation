using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.Disarming
{
	public class DisarmingGUI : MonoBehaviour
	{
		public Image Circle;

		[SerializeField]
		private GameObject _disarmedMessageObject;

		[SerializeField]
		private TextMeshProUGUI _disarmedMessageText;

		[SerializeField]
		private TextMeshProUGUI _bottomText;

		private void Awake()
		{
			if (Circle != null)
			{
				Circle.fillAmount = 0f;
				Circle.enabled = false;
			}
			if (_disarmedMessageObject != null)
			{
				_disarmedMessageObject.SetActive(value: false);
			}
		}

		private void Update()
		{
			float progress = DisarmingController.Progress;
			if (Circle != null)
			{
				Circle.enabled = progress > 0f;
				Circle.fillAmount = progress;
			}
			bool flag = ReferenceHub.TryGetLocalHub(out var hub) && hub.inventory.IsDisarmed();
			if (_disarmedMessageObject != null && _disarmedMessageObject.activeSelf != flag)
			{
				_disarmedMessageObject.SetActive(flag);
			}
		}
	}
}

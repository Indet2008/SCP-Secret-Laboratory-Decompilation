using InventorySystem.Items;
using PlayerRoles;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.Drawers
{
	public class InventoryDrawersController : MonoBehaviour
	{
		[SerializeField]
		private TextMeshProUGUI _alertText;

		[SerializeField]
		private Slider _progressbarSlider;

		[SerializeField]
		private RectTransform _progressbarSliderRect;

		[SerializeField]
		private Graphic[] _detailsToRecolor;

		[SerializeField]
		private CanvasGroup _thisGroup;

		[SerializeField]
		private CanvasGroup _inventoryGroup;

		private IItemAlertDrawer _alertToTrack;

		private IItemProgressbarDrawer _progressbarToTrack;

		private bool _active;

		private Color _roleColor;

		private void Start()
		{
			Inventory.OnCurrentItemChanged += ItemChanged;
			PlayerRoleManager.OnRoleChanged += RecolorDetails;
		}

		private void OnDestroy()
		{
			Inventory.OnCurrentItemChanged -= ItemChanged;
			PlayerRoleManager.OnRoleChanged -= RecolorDetails;
		}

		private void RecolorDetails(ReferenceHub hub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (hub.isLocalPlayer)
			{
				_roleColor = newRole.RoleColor;
				Graphic[] detailsToRecolor = _detailsToRecolor;
				foreach (Graphic graphic in detailsToRecolor)
				{
					Color roleColor = _roleColor;
					roleColor.a = graphic.color.a;
					graphic.color = roleColor;
				}
			}
		}

		private void Update()
		{
			if (!_active)
			{
				return;
			}
			float num = 1f - _inventoryGroup.alpha;
			if (num != _thisGroup.alpha)
			{
				_thisGroup.alpha = num;
			}
			_alertText.text = _alertToTrack?.Alert.ParseText(_roleColor) ?? string.Empty;
			if (_progressbarToTrack != null)
			{
				if (_progressbarToTrack.ProgressbarEnabled)
				{
					_progressbarSlider.gameObject.SetActive(value: true);
					_progressbarSlider.minValue = _progressbarToTrack.ProgressbarMin;
					_progressbarSlider.maxValue = _progressbarToTrack.ProgressbarMax;
					_progressbarSlider.value = _progressbarToTrack.ProgressbarValue;
					_progressbarSliderRect.sizeDelta = new Vector2(_progressbarToTrack.ProgressbarWidth, 10f);
				}
				else
				{
					_progressbarSlider.gameObject.SetActive(value: false);
				}
			}
		}

		private void ItemChanged(ReferenceHub hub, ItemIdentifier prevItem, ItemIdentifier newItem)
		{
			if (hub.isLocalPlayer)
			{
				_active = hub.inventory.UserInventory.Items.TryGetValue(newItem.SerialNumber, out var value) && value is IItemDrawer;
				_alertToTrack = value as IItemAlertDrawer;
				_alertText.text = string.Empty;
				_progressbarToTrack = value as IItemProgressbarDrawer;
				_progressbarSlider.gameObject.SetActive(value: false);
			}
		}
	}
}

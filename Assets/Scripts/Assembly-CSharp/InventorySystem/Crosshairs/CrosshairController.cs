using System;
using InventorySystem.Items;
using PlayerRoles;
using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.Crosshairs
{
	public class CrosshairController : MonoBehaviour
	{
		private static CrosshairController _singleton;

		private static bool _singletonSet;

		[SerializeField]
		private MonoBehaviour _defaultCrosshair;

		[SerializeField]
		private MonoBehaviour[] _customCrosshairs;

		[SerializeField]
		private GameObject _rootObject;

		[SerializeField]
		private CanvasScaler _canvasScaler;

		private bool IsLowResolution
		{
			get
			{
				if (Screen.width < 1280)
				{
					return Screen.height < 720;
				}
				return false;
			}
		}

		private void Start()
		{
			Inventory.OnCurrentItemChanged += OnItemChanged;
			_singleton = this;
			_singletonSet = true;
		}

		private void OnDestroy()
		{
			Inventory.OnCurrentItemChanged -= OnItemChanged;
			_singletonSet = false;
		}

		private void Update()
		{
			_rootObject.SetActive(ReferenceHub.TryGetLocalHub(out var hub) && hub.roleManager.CurrentRole is IHealthbarRole && hub.IsAlive() && !Cursor.visible);
			AdjustScaleMode();
		}

		private static void OnItemChanged(ReferenceHub ply, ItemIdentifier prevItem, ItemIdentifier newItem)
		{
			if (ply.isLocalPlayer)
			{
				Refresh(ply, newItem.SerialNumber);
			}
		}

		public static void Refresh(ReferenceHub ply, ushort serial)
		{
			if (_singletonSet)
			{
				if (!ply.inventory.UserInventory.Items.TryGetValue(serial, out var value))
				{
					value = null;
				}
				Type type = ((value is ICustomCrosshairItem customCrosshairItem) ? customCrosshairItem.CrosshairType : null);
				MonoBehaviour[] customCrosshairs = _singleton._customCrosshairs;
				foreach (MonoBehaviour obj in customCrosshairs)
				{
					Type type2 = obj.GetType();
					obj.gameObject.SetActive(type2 == type);
				}
				_singleton._defaultCrosshair.gameObject.SetActive(type == null);
			}
		}

		private void AdjustScaleMode()
		{
			_canvasScaler.uiScaleMode = ((!IsLowResolution) ? CanvasScaler.ScaleMode.ScaleWithScreenSize : CanvasScaler.ScaleMode.ConstantPixelSize);
		}
	}
}

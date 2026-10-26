using System;
using CursorManagement;
using CustomPlayerEffects;
using InventorySystem.GUI;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.Items.Usables.Scp330
{
	public class Scp330Viewmodel : UsableItemViewmodel, ICursorOverride
	{
		[Serializable]
		private struct CandyObject
		{
			public CandyKindID KindID;

			public GameObject HandObject;

			public Texture Icon;

			public AudioClip EatingSound;
		}

		[SerializeField]
		private RadialInventory _selector;

		[SerializeField]
		private RawImage[] _selectorSlots;

		[SerializeField]
		private CanvasGroup _selectorGroup;

		[SerializeField]
		private CanvasGroup _descriptionGroup;

		[SerializeField]
		private CandyObject[] _candies;

		[SerializeField]
		private TextMeshProUGUI _title;

		[SerializeField]
		private TextMeshProUGUI _description;

		[SerializeField]
		private TextMeshProUGUI _effects;

		private Scp330Bag _bag;

		private bool _openDelay;

		private bool _cancelled;

		private CandyKindID _displayedCandy;

		public CursorOverrideMode CursorOverride { get; private set; }

		public bool LockMovement => false;

		public override void InitLocal(ItemBase parent)
		{
			base.InitLocal(parent);
			_bag = parent as Scp330Bag;
		}

		public override void InitSpectator(ReferenceHub ply, ItemIdentifier id, bool wasEquipped)
		{
			Scp330NetworkHandler.OnClientSelectMessageReceived += HandleSelectMessage;
			base.InitSpectator(ply, id, wasEquipped);
			OnEquipped();
		}

		internal override void OnEquipped()
		{
			_openDelay = true;
			_cancelled = false;
			_descriptionGroup.alpha = 0f;
			_displayedCandy = CandyKindID.None;
			if (base.IsLocal)
			{
				CursorManager.Register(this);
				CursorOverride = CursorOverrideMode.NoOverride;
			}
			else
			{
				_selectorGroup.gameObject.SetActive(value: false);
			}
			base.OnEquipped();
		}

		protected void Update()
		{
			if (base.IsLocal)
			{
				KeyCode key = NewInput.GetKey(ActionName.Inventory);
				bool flag = !InventoryGuiController.ToggleInventory.Value;
				if (Input.GetKeyDown(KeyCode.Escape) || (!flag && Input.GetKeyDown(key)) || (flag && !Input.GetKey(key)))
				{
					CancelSelector();
				}
			}
		}

		protected override void LateUpdate()
		{
			base.LateUpdate();
			if (!base.IsLocal)
			{
				return;
			}
			CandyKindID candyKindID = (_bag.IsCandySelected ? _bag.Candies[_bag.SelectedCandyId] : CandyKindID.None);
			SetCandyModel(candyKindID);
			DisplaySelector(candyKindID);
			if (candyKindID != CandyKindID.None)
			{
				return;
			}
			for (ushort num = 0; num < _selector.OrganizedContent.Length; num++)
			{
				_selector.OrganizedContent[num] = (ushort)((num < _bag.Candies.Count) ? ((uint)(num + 1)) : 0u);
			}
			if (_openDelay)
			{
				_openDelay = false;
				return;
			}
			ushort itemSerial;
			switch (_selector.DisplayAndSelectItems(null, out itemSerial))
			{
			case InventoryGuiAction.Select:
			{
				if (base.Hub.playerEffectsController.TryGetEffect<AmnesiaItems>(out var playerEffect) && playerEffect.IsEnabled)
				{
					playerEffect.ExecutePulse();
					CancelSelector();
					break;
				}
				if (itemSerial == 0 || base.ParentItem.Owner.HasBlock(BlockedInteraction.ItemPrimaryAction))
				{
					CancelSelector();
				}
				if (TryGetCandyObject(_bag.Candies[Mathf.Clamp(itemSerial - 1, 0, _bag.Candies.Count)], out var val))
				{
					_bag.UsingSfxClip = val.EatingSound;
				}
				_bag.SelectCandy(itemSerial - 1);
				break;
			}
			case InventoryGuiAction.Drop:
				if (itemSerial == 0)
				{
					return;
				}
				_bag.DropCandy(itemSerial - 1);
				break;
			}
			bool flag = itemSerial == 0 || _bag.Candies.Count == 0 || itemSerial > _bag.Candies.Count;
			DisplayDescriptions((!flag) ? _bag.Candies[itemSerial - 1] : CandyKindID.None);
		}

		private void HandleSelectMessage(SelectScp330Message msg)
		{
			if (msg.Serial == base.ItemId.SerialNumber)
			{
				SetCandyModel((CandyKindID)msg.CandyID);
				OnUsingStarted();
			}
		}

		private void OnDisable()
		{
			if (!base.IsLocal)
			{
				Scp330NetworkHandler.OnClientSelectMessageReceived -= HandleSelectMessage;
			}
			else
			{
				CursorManager.Unregister(this);
			}
		}

		private void SetCandyModel(CandyKindID id)
		{
			CandyObject[] candies = _candies;
			for (int i = 0; i < candies.Length; i++)
			{
				CandyObject candyObject = candies[i];
				candyObject.HandObject.SetActive(candyObject.KindID == id);
			}
		}

		private void DisplaySelector(CandyKindID id)
		{
			bool flag = id == CandyKindID.None && !_cancelled;
			_selectorGroup.alpha = Mathf.Clamp01(_selectorGroup.alpha + (float)(flag ? 10 : (-10)) * Time.deltaTime);
			_selectorGroup.gameObject.SetActive(_selectorGroup.alpha > 0f);
			CursorOverride = ((!flag) ? CursorOverrideMode.Centered : CursorOverrideMode.Free);
			for (int i = 0; i < _selectorSlots.Length; i++)
			{
				if (i < _bag.Candies.Count && TryGetCandyObject(_bag.Candies[i], out var val))
				{
					_selectorSlots[i].texture = val.Icon;
					_selectorSlots[i].enabled = true;
				}
				else
				{
					_selectorSlots[i].enabled = false;
				}
			}
		}

		private void DisplayDescriptions(CandyKindID candy)
		{
			bool flag = candy == CandyKindID.None;
			if (_displayedCandy == candy && !flag)
			{
				_descriptionGroup.alpha = Mathf.Clamp01(_descriptionGroup.alpha + 10f * Time.deltaTime);
				return;
			}
			if ((_descriptionGroup.alpha > 0f) | flag)
			{
				_descriptionGroup.alpha = Mathf.Clamp01(_descriptionGroup.alpha - 10f * Time.deltaTime);
				return;
			}
			Scp330Translations.GetCandyTranslation(candy, out var text, out var desc, out var fx);
			_title.text = text;
			_description.text = desc;
			_effects.text = fx;
			_displayedCandy = candy;
		}

		private bool TryGetCandyObject(CandyKindID id, out CandyObject val)
		{
			CandyObject[] candies = _candies;
			for (int i = 0; i < candies.Length; i++)
			{
				CandyObject candyObject = candies[i];
				if (candyObject.KindID == id)
				{
					val = candyObject;
					return true;
				}
			}
			val = default;
			return false;
		}

		private void CancelSelector(bool bringBackInventory = false)
		{
			_cancelled = true;
			_bag.OwnerInventory.ClientSelectItem(0);
			InventoryGuiController.InventoryVisible |= bringBackInventory;
		}

		public static AudioClip GetClipForCandy(CandyKindID kind)
		{
			if (!InventoryItemLoader.TryGetItem<Scp330Bag>(ItemType.SCP330, out var result))
			{
				return null;
			}
			CandyObject[] candies = (result.ViewModel as Scp330Viewmodel)._candies;
			for (int i = 0; i < candies.Length; i++)
			{
				CandyObject candyObject = candies[i];
				if (candyObject.KindID == kind)
				{
					return candyObject.EatingSound;
				}
			}
			return null;
		}
	}
}

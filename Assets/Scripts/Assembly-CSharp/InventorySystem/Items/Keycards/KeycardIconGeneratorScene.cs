using System.Collections.Generic;
using InventorySystem.Items.AutoIcons;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class KeycardIconGeneratorScene : AutoIconGeneratorScene, IIdentifierProvider
	{
		[SerializeField]
		private Transform _gfxSpawnpoint;

		private GameObject _prevActive;

		private readonly Dictionary<KeycardGfx, KeycardGfx> _prevInstances = new Dictionary<KeycardGfx, KeycardGfx>();

		public ItemIdentifier ItemId { get; private set; }

		protected override void SetupScene(ItemBase item)
		{
			if (_prevActive != null)
			{
				_prevActive.SetActive(value: false);
			}
			KeycardItem keycardItem = item as KeycardItem;
			KeycardGfx keycardGfx = keycardItem.KeycardGfx;
			if (!_prevInstances.TryGetValue(keycardGfx, out var value))
			{
				value = Object.Instantiate(keycardGfx, _gfxSpawnpoint);
				value.SetAsIconSubject();
				_prevInstances.Add(keycardGfx, value);
			}
			else
			{
				value.gameObject.SetActive(value: true);
			}
			ItemId = keycardItem.ItemId;
			if (ItemId.SerialNumber == 0)
			{
				KeycardDetailSynchronizer.ApplyTemplateDetails(keycardItem, value);
			}
			else
			{
				KeycardDetailSynchronizer.TryReapplyDetails(value);
			}
			_prevActive = value.gameObject;
		}
	}
}

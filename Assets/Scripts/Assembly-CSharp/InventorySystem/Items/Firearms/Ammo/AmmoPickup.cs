using System.Collections.Generic;
using System.Runtime.InteropServices;
using InventorySystem.Items.Pickups;
using InventorySystem.Searching;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Ammo
{
	public class AmmoPickup : ItemPickupBase
	{
		[SyncVar]
		public ushort SavedAmmo;

		[SerializeField]
		private int _minDisplayedValue;

		[SerializeField]
		private int _maxDisplayedValue;

		[SerializeField]
		private int _roundingValue;

		[SerializeField]
		private bool _hideFirstDigitBelow10;

		[SerializeField]
		private Material _targetDigitMaterial;

		[SerializeField]
		private Renderer[] _firstDigits;

		[SerializeField]
		private Renderer[] _secondDigits;

		private static readonly Dictionary<ItemType, Dictionary<int, Material>> DigitMaterials = new Dictionary<ItemType, Dictionary<int, Material>>();

		private ushort _prevAmmo;

		public int MaxAmmo => _maxDisplayedValue;

		public ushort NetworkSavedAmmo
		{
			get
			{
				return SavedAmmo;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref SavedAmmo, 2uL, null);
			}
		}

		public override PickupSearchCompletor GetPickupSearchCompletor(SearchCoordinator coordinator, float sqrDistance)
		{
			return new AmmoSearchCompletor(coordinator.Hub, this, sqrDistance);
		}

		private Material GetDigitMaterial(int digit)
		{
			if (!DigitMaterials.TryGetValue(Info.ItemId, out var value))
			{
				value = new Dictionary<int, Material>();
				DigitMaterials.Add(Info.ItemId, value);
			}
			if (!value.TryGetValue(digit, out var value2))
			{
				value2 = new Material(_targetDigitMaterial)
				{
					mainTextureOffset = Vector2.up * digit / 10f
				};
				value.Add(digit, value2);
			}
			return value2;
		}

		private void Update()
		{
			if (_roundingValue == 0 || SavedAmmo == _prevAmmo)
			{
				return;
			}
			int i;
			for (i = Mathf.Clamp(SavedAmmo, _minDisplayedValue, _maxDisplayedValue); i % _roundingValue != 0; i++)
			{
			}
			Material digitMaterial = GetDigitMaterial(Mathf.FloorToInt((float)i / 10f));
			Material digitMaterial2 = GetDigitMaterial(i % 10);
			Renderer[] firstDigits = _firstDigits;
			foreach (Renderer renderer in firstDigits)
			{
				renderer.sharedMaterial = digitMaterial;
				if (_hideFirstDigitBelow10)
				{
					renderer.gameObject.SetActive(i >= 10);
				}
			}
			firstDigits = _secondDigits;
			for (int j = 0; j < firstDigits.Length; j++)
			{
				firstDigits[j].sharedMaterial = digitMaterial2;
			}
			_prevAmmo = SavedAmmo;
		}

		public override bool Weaved()
		{
			return true;
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteUShort(SavedAmmo);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				writer.WriteUShort(SavedAmmo);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref SavedAmmo, null, reader.ReadUShort());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref SavedAmmo, null, reader.ReadUShort());
			}
		}
	}
}

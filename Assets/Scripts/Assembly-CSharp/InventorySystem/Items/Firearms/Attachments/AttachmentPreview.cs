using System;
using InventorySystem.Items.Autosync;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Attachments
{
	public static class AttachmentPreview
	{
		private static readonly Firearm[] Instances = new Firearm[EnumUtils<ItemType>.Values.Length];

		private static readonly bool[] HasInstances = new bool[Instances.Length];

		public static Firearm Get(ItemType id, uint attachmentsCode, bool reValidate = false)
		{
			if (!TryGet(id, attachmentsCode, reValidate, out var result))
			{
				throw new InvalidOperationException($"Unable to create a preview for {id} - it's not a valid firearm id!");
			}
			return result;
		}

		public static Firearm Get(ItemIdentifier id, bool reValidate = false)
		{
			if (!TryGet(id, reValidate, out var result))
			{
				throw new InvalidOperationException($"Unable to create a preview for {id} - it's not a valid firearm id!");
			}
			return result;
		}

		public static bool TryGet(ItemType id, uint attachmentsCode, bool reValidate, out Firearm result)
		{
			if (!TryGetOrAddInstance(id, out result))
			{
				return false;
			}
			result.ApplyAttachmentsCode(attachmentsCode, reValidate);
			return true;
		}

		public static bool TryGet(ItemIdentifier id, bool reValidate, out Firearm result)
		{
			if (!AttachmentCodeSync.TryGet(id.SerialNumber, out var code))
			{
				code = 0u;
				reValidate = true;
			}
			return TryGet(id.TypeId, code, reValidate, out result);
		}

		private static bool TryGetOrAddInstance(ItemType id, out Firearm instance)
		{
			if (HasInstances[(int)id])
			{
				instance = Instances[(int)id];
				return true;
			}
			if (!InventoryItemLoader.TryGetItem<Firearm>(id, out var result))
			{
				instance = null;
				return false;
			}
			instance = UnityEngine.Object.Instantiate(result);
			instance.InstantiationStatus = AutosyncInstantiationStatus.SimulatedInstance;
			instance.InitializeSubcomponents();
			UnityEngine.Object.DontDestroyOnLoad(instance);
			Instances[(int)id] = instance;
			HasInstances[(int)id] = true;
			return true;
		}
	}
}

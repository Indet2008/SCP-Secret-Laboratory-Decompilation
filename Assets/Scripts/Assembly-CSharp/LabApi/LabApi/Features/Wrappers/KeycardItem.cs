namespace LabApi.Features.Wrappers
{
	public class KeycardItem : global::LabApi.Features.Wrappers.Item
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Keycards.KeycardItem, global::LabApi.Features.Wrappers.KeycardItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Keycards.KeycardItem, global::LabApi.Features.Wrappers.KeycardItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.KeycardItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.Keycards.KeycardItem Base { get; }

		public global::Interactables.Interobjects.DoorUtils.DoorPermissionFlags Permissions => Base.GetPermissions(null);

		public global::Interactables.Interobjects.DoorUtils.KeycardLevels Levels => new global::Interactables.Interobjects.DoorUtils.KeycardLevels(Permissions);

		public static global::LabApi.Features.Wrappers.KeycardItem? CreateCustomKeycardSite02(global::LabApi.Features.Wrappers.Player targetPlayer, string itemName, string holderName, string cardLabel, global::Interactables.Interobjects.DoorUtils.KeycardLevels permissions, global::UnityEngine.Color keycardColor, global::UnityEngine.Color permissionsColor, global::UnityEngine.Color labelColor, byte wearLevel)
		{
			return CreateCustomCard(ItemType.KeycardCustomSite02, targetPlayer, itemName, permissions, (global::UnityEngine.Color32)permissionsColor, (global::UnityEngine.Color32)keycardColor, cardLabel, (global::UnityEngine.Color32)labelColor, holderName, wearLevel);
		}

		public static global::LabApi.Features.Wrappers.KeycardItem? CreateCustomKeycardTaskForce(global::LabApi.Features.Wrappers.Player targetPlayer, string itemName, string holderName, global::Interactables.Interobjects.DoorUtils.KeycardLevels permissions, global::UnityEngine.Color keycardColor, global::UnityEngine.Color permissionsColor, string serialLabel, int rankIndex)
		{
			return CreateCustomCard(ItemType.KeycardCustomTaskForce, targetPlayer, itemName, permissions, (global::UnityEngine.Color32)permissionsColor, (global::UnityEngine.Color32)keycardColor, holderName, serialLabel, rankIndex);
		}

		public static global::LabApi.Features.Wrappers.KeycardItem? CreateCustomKeycardMetal(global::LabApi.Features.Wrappers.Player targetPlayer, string itemName, string holderName, string cardLabel, global::Interactables.Interobjects.DoorUtils.KeycardLevels permissions, global::UnityEngine.Color keycardColor, global::UnityEngine.Color permissionsColor, global::UnityEngine.Color labelColor, byte wearLevel, string serialLabel)
		{
			return CreateCustomCard(ItemType.KeycardCustomMetalCase, targetPlayer, itemName, permissions, (global::UnityEngine.Color32)permissionsColor, (global::UnityEngine.Color32)keycardColor, cardLabel, (global::UnityEngine.Color32)labelColor, holderName, serialLabel, wearLevel);
		}

		public static global::LabApi.Features.Wrappers.KeycardItem? CreateCustomKeycardManagement(global::LabApi.Features.Wrappers.Player targetPlayer, string itemName, string cardLabel, global::Interactables.Interobjects.DoorUtils.KeycardLevels permissions, global::UnityEngine.Color keycardColor, global::UnityEngine.Color permissionsColor, global::UnityEngine.Color labelColor)
		{
			return CreateCustomCard(ItemType.KeycardCustomManagement, targetPlayer, itemName, permissions, (global::UnityEngine.Color32)permissionsColor, (global::UnityEngine.Color32)keycardColor, cardLabel, (global::UnityEngine.Color32)labelColor);
		}

		public static global::LabApi.Features.Wrappers.KeycardItem? CreateCustomCard(ItemType itemType, global::LabApi.Features.Wrappers.Player targetPlayer, params object[] args)
		{
			if (targetPlayer == null)
			{
				return null;
			}
			if (!global::InventorySystem.InventoryExtensions.TryGetTemplate<global::InventorySystem.Items.Keycards.KeycardItem>(itemType, out var item))
			{
				throw new global::System.ArgumentException("Template for itemType not found");
			}
			if (!item.Customizable)
			{
				return null;
			}
			int num = 0;
			global::InventorySystem.Items.Keycards.DetailBase[] details = item.Details;
			for (int i = 0; i < details.Length; i++)
			{
				if (details[i] is global::InventorySystem.Items.Keycards.ICustomizableDetail customizableDetail)
				{
					customizableDetail.SetArguments(new global::System.ArraySegment<object>(args, num, customizableDetail.CustomizablePropertiesAmount));
					num += customizableDetail.CustomizablePropertiesAmount;
				}
			}
			return (global::LabApi.Features.Wrappers.KeycardItem)targetPlayer.AddItem(itemType);
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseKeycardItem")]
		public static global::LabApi.Features.Wrappers.KeycardItem? Get(global::InventorySystem.Items.Keycards.KeycardItem? baseKeycardItem)
		{
			if (baseKeycardItem == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseKeycardItem, out global::LabApi.Features.Wrappers.KeycardItem value))
			{
				return (global::LabApi.Features.Wrappers.KeycardItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(baseKeycardItem);
			}
			return value;
		}

		internal KeycardItem(global::InventorySystem.Items.Keycards.KeycardItem baseKeycardItem)
			: base(baseKeycardItem)
		{
			Base = baseKeycardItem;
			if (base.CanCache)
			{
				Dictionary.Add(baseKeycardItem, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}

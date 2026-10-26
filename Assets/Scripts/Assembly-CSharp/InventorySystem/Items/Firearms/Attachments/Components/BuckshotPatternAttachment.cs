using InventorySystem.Items.Firearms.Modules.Misc;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Attachments.Components
{
	public class BuckshotPatternAttachment : SerializableAttachment
	{
		[field: SerializeField]
		public BuckshotSettings Pattern { get; private set; }
	}
}

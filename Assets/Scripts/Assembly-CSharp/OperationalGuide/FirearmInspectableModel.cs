using InventorySystem.Items;
using InventorySystem.Items.Firearms;
using InventorySystem.Items.Firearms.Attachments;
using UnityEngine;

namespace OperationalGuide
{
	public class FirearmInspectableModel : MonoBehaviour
	{
		[SerializeField]
		private ItemType _firearmToSpawn;

		[SerializeField]
		private Vector3 _localSpawnOffset;

		private FirearmWorldmodel _inst;

		private void Start()
		{
			Firearm firearm = AttachmentPreview.Get(new ItemIdentifier(_firearmToSpawn, 0), reValidate: true);
			_inst = Object.Instantiate(firearm.WorldModel, base.transform);
			_inst.Setup(new ItemIdentifier(_firearmToSpawn, 0), FirearmWorldmodelType.Presentation, firearm.GetCurrentAttachmentsCode());
			_inst.transform.localPosition = _localSpawnOffset;
		}
	}
}

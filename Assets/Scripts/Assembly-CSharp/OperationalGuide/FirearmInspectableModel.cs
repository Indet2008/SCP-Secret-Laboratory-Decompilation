namespace OperationalGuide
{
	public class FirearmInspectableModel : global::UnityEngine.MonoBehaviour
	{
		[global::UnityEngine.SerializeField]
		private ItemType _firearmToSpawn;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Vector3 _localSpawnOffset;

		private global::InventorySystem.Items.Firearms.FirearmWorldmodel _inst;

		private void Start()
		{
		}

		public FirearmInspectableModel()
		{
		}
	}
}

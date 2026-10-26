using UnityEngine;

namespace MapGeneration.StaticHelpers
{
	public class DynamicChildController : MonoBehaviour
	{
		private static Transform _dynamicRoot;

		[SerializeField]
		private GameObject spawnPrefab;

		public GameObject Child { get; private set; }

		public void SetChild(GameObject child)
		{
			child.SetActive(child.activeInHierarchy);
			child.transform.GetPositionAndRotation(out var position, out var rotation);
			child.transform.parent = ((_dynamicRoot == null) ? CreateDynamicRoot() : _dynamicRoot);
			child.transform.SetPositionAndRotation(position, rotation);
			Child = child;
		}

		private static Transform CreateDynamicRoot()
		{
			_dynamicRoot = new GameObject("DynamicChild Container").transform;
			return _dynamicRoot;
		}

		private void Awake()
		{
			if (!(spawnPrefab == null))
			{
				SetChild(Object.Instantiate(spawnPrefab, base.transform.position, base.transform.rotation, base.transform));
			}
		}

		private void OnEnable()
		{
			if (!(Child == null))
			{
				Child.SetActive(value: true);
			}
		}

		private void OnDisable()
		{
			if (!(Child == null))
			{
				Child.SetActive(value: false);
			}
		}

		private void OnDestroy()
		{
			Object.Destroy(Child);
		}
	}
}

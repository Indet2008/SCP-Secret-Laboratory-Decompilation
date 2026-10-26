using System.Collections.Generic;
using GameCore;
using UnityEngine;

public class Clutter : MonoBehaviour
{
	[Header("Prefab Data")]
	public GameObject holderObject;

	public List<GameObject> possiblePrefabs = new List<GameObject>();

	public Vector3 spawnOffset;

	public Vector3 clutterScale = Vector3.zero;

	public bool spawned;

	private const float OverallScale = 0.72745f;

	public void SpawnClutter()
	{
		Console.AddDebugLog("MGCLTR", "Spawning clutter component on object of name \"" + base.gameObject.name + "\"", MessageImportance.LeastImportant, nospace: true);
		spawned = true;
		if (!holderObject)
		{
			holderObject = base.gameObject;
		}
		GameObject gameObject = Object.Instantiate((possiblePrefabs.Count > 0) ? possiblePrefabs[Random.Range(0, possiblePrefabs.Count)] : base.gameObject, holderObject.transform.position + spawnOffset * 0.72745f, holderObject.transform.rotation.normalized, holderObject.transform.parent);
		if (clutterScale != Vector3.zero)
		{
			gameObject.transform.localScale = clutterScale;
		}
		else
		{
			gameObject.transform.localScale = holderObject.transform.localScale;
		}
		gameObject.SetActive(value: true);
		if (gameObject.TryGetComponent<Clutter>(out var component))
		{
			Object.Destroy(component);
		}
		Object.Destroy(holderObject);
	}
}

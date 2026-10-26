using GameObjectPools;
using UnityEngine;

public class PlayerModelCollisionController : MonoBehaviour, IPoolSpawnable, IPoolResettable
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	public global::UnityEngine.Collider[] MyColliders;

	public ReferenceHub Owner;


	public void SpawnObject()
	{
	}

	public void ResetObject()
	{
	}
}

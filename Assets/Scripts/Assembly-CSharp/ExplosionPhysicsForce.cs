using System.Collections;
using System.Collections.Generic;
using NorthwoodLib.Pools;
using UnityEngine;
using UnityStandardAssets.Effects;

public class ExplosionPhysicsForce : MonoBehaviour
{
	public float explosionForce = 4f;

	private IEnumerator Start()
	{
		yield return null;
		float num = 0f;
		if (GetComponent<ParticleSystemMultiplier>() != null)
		{
			num = GetComponent<ParticleSystemMultiplier>().multiplier;
		}
		float num2 = 10f * num;
		Collider[] array = Physics.OverlapSphere(base.transform.position, num2);
		List<Rigidbody> list = ListPool<Rigidbody>.Shared.Rent();
		Collider[] array2 = array;
		foreach (Collider collider in array2)
		{
			if (collider.attachedRigidbody != null && !list.Contains(collider.attachedRigidbody))
			{
				list.Add(collider.attachedRigidbody);
			}
		}
		foreach (Rigidbody item in list)
		{
			item.AddExplosionForce(explosionForce * num, base.transform.position, num2, 1f * num, ForceMode.Impulse);
		}
		ListPool<Rigidbody>.Shared.Return(list);
	}
}

using System.Collections.Generic;
using GameObjectPools;
using PlayerRoles;
using UnityEngine;

public class PlayerModelCollisionController : MonoBehaviour, IPoolSpawnable, IPoolResettable
{
	public Collider[] MyColliders;

	public ReferenceHub Owner;

	public static PlayerModelCollisionController LocalPlayerController;

	public static List<PlayerModelCollisionController> AllControllers = new List<PlayerModelCollisionController>();

	public void SpawnObject()
	{
		AllControllers.Add(this);
		Owner = ReferenceHub.GetHub(base.transform.parent.gameObject);
		if (!(Owner == null))
		{
			if (!Owner.isLocalPlayer)
			{
				RefreshRelation(this);
				return;
			}
			LocalPlayerController = this;
			RefreshAllRelations();
		}
	}

	public void ResetObject()
	{
		AllControllers.Remove(this);
	}

	private void RefreshAllRelations()
	{
		foreach (PlayerModelCollisionController allController in AllControllers)
		{
			if (!(allController == null) && !(allController.Owner == null) && !allController.Owner.isLocalPlayer)
			{
				RefreshRelation(allController);
			}
		}
	}

	private void RefreshRelation(PlayerModelCollisionController targetController)
	{
		if (LocalPlayerController == null || LocalPlayerController.Owner == null || targetController == null || targetController.Owner == null)
		{
			return;
		}
		bool flag = LocalPlayerController.Owner.IsHuman() && HitboxIdentity.IsEnemy(targetController.Owner, LocalPlayerController.Owner);
		Collider[] myColliders = targetController.MyColliders;
		for (int i = 0; i < myColliders.Length; i++)
		{
			myColliders[i].isTrigger = !flag;
		}
	}
}

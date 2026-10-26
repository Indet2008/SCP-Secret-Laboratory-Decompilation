using GameObjectPools;
using InventorySystem.Items;
using InventorySystem.Items.Thirdperson;
using UnityEngine;

public class HandPart : ThirdpersonItemBase
{
	public GameObject TargetPart;

	public ItemType TargetItemId;

	public bool UseUniversalAnimations;

	[SerializeField]
	private GameObject optionalPrefab;

	protected bool CurrentlyEnabled { get; set; }

	protected GameObject SpawnedObject { get; set; }

	public void UpdateItem()
	{
		bool flag = base.OwnerHub.inventory.CurItem.TypeId == TargetItemId;
		if (flag == CurrentlyEnabled)
		{
			return;
		}
		CurrentlyEnabled = flag;
		TargetPart.SetActive(flag);
		if (flag && optionalPrefab != null)
		{
			SpawnedObject = (PoolManager.Singleton.TryGetPoolObject(optionalPrefab, TargetPart.transform, out var poolObject) ? poolObject.gameObject : Object.Instantiate(optionalPrefab, TargetPart.transform));
			SpawnedObject.transform.localScale = Vector3.one;
			SpawnedObject.transform.localPosition = Vector3.zero;
			SpawnedObject.transform.localRotation = Quaternion.identity;
			OnActiveStateChange(isEnabled: true);
		}
		else if (SpawnedObject != null)
		{
			OnActiveStateChange(isEnabled: false);
			if (!PoolManager.Singleton.TryReturnPoolObject(SpawnedObject))
			{
				Object.Destroy(SpawnedObject);
			}
		}
	}

	public override void ResetObject()
	{
		base.ResetObject();
		TargetPart.SetActive(value: false);
		CurrentlyEnabled = false;
		OnActiveStateChange(isEnabled: false);
	}

	protected virtual void OnActiveStateChange(bool isEnabled)
	{
	}

	public override float GetTransitionTime(ItemIdentifier iid)
	{
		return 2f;
	}

	public override ThirdpersonLayerWeight GetWeightForLayer(AnimItemLayer3p layer)
	{
		return new ThirdpersonLayerWeight(1f, allowOther: false);
	}
}

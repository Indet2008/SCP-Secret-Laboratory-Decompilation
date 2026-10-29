using Decals;
using Mirror;
using UnityEngine;

public class BloodDrawer : NetworkBehaviour
{
	public void PlaceUnderneath(Vector3 pos, float amountMultiplier = 1f)
	{
		if (Physics.Raycast(pos, Vector3.down, out var hitInfo, 3f, 1) && DecalPoolManager.TryGet(DecalPoolType.Blood, out var decal))
		{
			Transform transform = decal.transform;
			transform.position = hitInfo.point + new Vector3(0f, 0.5f, 0f);
			transform.rotation = Quaternion.FromToRotation(Vector3.up, hitInfo.normal);
			transform.Rotate(0f, Random.Range(0, 360), 0f, Space.Self);
			float num = Random.Range(0.75f, 1.25f);
			transform.localScale = new Vector3(num * amountMultiplier, num * amountMultiplier, num * amountMultiplier);
			transform.SetParent(hitInfo.collider.transform, worldPositionStays: true);
		}
	}

	public override bool Weaved()
	{
		return true;
	}
}

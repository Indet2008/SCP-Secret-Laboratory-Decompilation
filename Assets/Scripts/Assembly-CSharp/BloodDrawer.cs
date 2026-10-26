using Mirror;
using UnityEngine;

public class BloodDrawer : NetworkBehaviour
{
	public void PlaceUnderneath(Vector3 pos, float amountMultiplier = 1f)
	{
	}

	public override bool Weaved()
	{
		return true;
	}
}

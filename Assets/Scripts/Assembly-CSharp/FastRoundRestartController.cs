using Mirror;
using UnityEngine;

public class FastRoundRestartController : NetworkBehaviour
{
	private void Start()
	{
		Object.Destroy(this);
	}

	public override bool Weaved()
	{
		return true;
	}
}

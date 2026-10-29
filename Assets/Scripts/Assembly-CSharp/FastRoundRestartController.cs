using GameCore;
using Mirror;
using UnityEngine;

public class FastRoundRestartController : NetworkBehaviour
{
	private static bool _fastRestartInProgress;

	internal static bool FastRestartInProgress
	{
		get
		{
			return _fastRestartInProgress;
		}
		set
		{
			if (_fastRestartInProgress != value)
			{
				_fastRestartInProgress = value;
				Console.AddLog($"FastRestartInProgress set to: {value}", new Color(0f, 1f, 1f, 1f));
			}
		}
	}

	private void Start()
	{
		if (base.isLocalPlayer)
		{
			FastRestartInProgress = false;
		}
		else
		{
			Object.Destroy(this);
		}
	}

	public override bool Weaved()
	{
		return true;
	}
}

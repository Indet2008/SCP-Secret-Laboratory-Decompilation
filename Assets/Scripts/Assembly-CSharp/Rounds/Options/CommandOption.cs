using System;
using UnityEngine;

namespace Rounds.Options
{
	[Serializable]
	public class CommandOption : IRoundOption
	{
		[field: SerializeField]
		public string Command { get; set; }

		public void Invoke()
		{
			if (global::Mirror.NetworkServer.active && ReferenceHub.TryGetLocalHub(out var hub))
			{
				hub.queryProcessor.CmdSendQuery(Command);
			}
		}
	}
}

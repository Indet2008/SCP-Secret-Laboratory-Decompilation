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
		}
	}
}

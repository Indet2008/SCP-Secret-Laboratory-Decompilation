using System.Collections.Generic;
using Mirror;

namespace Respawning
{
	public class RespawnEffectsController : NetworkBehaviour
	{
		private static readonly List<RespawnEffectsController> AllControllers = new List<RespawnEffectsController>();

		private void Awake()
		{
			while (AllControllers.Contains(null))
			{
				AllControllers.Remove(null);
			}
			AllControllers.Add(this);
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}

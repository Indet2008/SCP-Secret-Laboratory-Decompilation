using Mirror;
using UnityEngine;

namespace CustomPlayerEffects
{
	public struct GhostlyWalkThroughMessage : NetworkMessage
	{
		public Vector3 Position;
	}
}

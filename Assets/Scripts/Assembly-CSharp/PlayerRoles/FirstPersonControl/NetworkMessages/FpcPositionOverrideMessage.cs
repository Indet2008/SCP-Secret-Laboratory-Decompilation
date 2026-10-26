using Mirror;
using RelativePositioning;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.NetworkMessages
{
	public readonly struct FpcPositionOverrideMessage : NetworkMessage
	{
		public readonly Vector3 Position;

		public FpcPositionOverrideMessage(Vector3 pos)
		{
			Position = pos;
		}

		public FpcPositionOverrideMessage(NetworkReader reader)
		{
			Position = reader.ReadRelativePosition().Position;
		}

		public void Write(NetworkWriter writer)
		{
			writer.WriteRelativePosition(new RelativePosition(Position));
		}

		public void ProcessMessage()
		{
			if (ReferenceHub.TryGetLocalHub(out var hub) && hub.roleManager.CurrentRole is IFpcRole fpcRole && fpcRole.FpcModule.ModuleReady)
			{
				fpcRole.FpcModule.Position = Position;
			}
		}
	}
}

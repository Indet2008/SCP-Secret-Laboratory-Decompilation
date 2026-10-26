using Mirror;
using RelativePositioning;

namespace PlayerRoles.FirstPersonControl.NetworkMessages
{
	public readonly struct FpcFromClientMessage : NetworkMessage
	{
		private readonly FpcSyncData _data;

		public FpcFromClientMessage(RelativePosition pos, PlayerMovementState state, bool jump, FpcMouseLook mouseLook)
		{
			_data = new FpcSyncData(default, state, jump, pos, mouseLook);
		}

		public FpcFromClientMessage(NetworkReader reader)
		{
			_data = new FpcSyncData(reader);
		}

		public void Write(NetworkWriter writer)
		{
			_data.Write(writer);
		}

		public void ProcessMessage(NetworkConnection sender)
		{
			if (!sender.identity.isLocalPlayer && ReferenceHub.TryGetHubNetID(sender.identity.netId, out var hub) && _data.TryApply(hub, out var module, out var bit) && bit)
			{
				module.Motor.JumpController.WantsToJump = true;
			}
		}
	}
}

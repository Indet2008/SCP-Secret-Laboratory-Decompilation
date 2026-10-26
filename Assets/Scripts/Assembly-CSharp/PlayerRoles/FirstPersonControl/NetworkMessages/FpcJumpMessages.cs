using Mirror;
using Utils.Networking;

namespace PlayerRoles.FirstPersonControl.NetworkMessages
{
	public static class FpcJumpMessages
	{
		public readonly struct FpcForceJumpMessage : NetworkMessage
		{
			public readonly ReferenceHub TargetHub;

			public readonly float Force;

			public FpcForceJumpMessage(ReferenceHub hub, float force)
			{
				TargetHub = hub;
				Force = force;
			}
		}

		public static void Serialize(this NetworkWriter writer, FpcForceJumpMessage value)
		{
			writer.WriteReferenceHub(value.TargetHub);
			writer.WriteFloat(value.Force);
		}

		public static FpcForceJumpMessage Deserialize(this NetworkReader reader)
		{
			ReferenceHub hub = reader.ReadReferenceHub();
			float force = reader.ReadFloat();
			return new FpcForceJumpMessage(hub, force);
		}
	}
}

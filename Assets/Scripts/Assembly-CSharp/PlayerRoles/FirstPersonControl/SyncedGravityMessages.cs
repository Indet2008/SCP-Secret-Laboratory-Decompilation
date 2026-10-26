using Mirror;
using UnityEngine;
using Utils.Networking;

namespace PlayerRoles.FirstPersonControl
{
	public static class SyncedGravityMessages
	{
		public readonly struct GravityMessage : NetworkMessage
		{
			public readonly ReferenceHub TargetHub;

			public readonly Vector3 Gravity;

			public GravityMessage(Vector3 gravity, ReferenceHub targetHub)
			{
				Gravity = gravity;
				TargetHub = targetHub;
			}
		}

		public static void Serialize(this NetworkWriter writer, GravityMessage value)
		{
			writer.WriteReferenceHub(value.TargetHub);
			writer.WriteVector3(value.Gravity);
		}

		public static GravityMessage Deserialize(this NetworkReader reader)
		{
			ReferenceHub targetHub = reader.ReadReferenceHub();
			return new GravityMessage(reader.ReadVector3(), targetHub);
		}
	}
}

using Mirror;
using UnityEngine;
using Utils.Networking;

namespace PlayerRoles.FirstPersonControl
{
	public static class SyncedScaleMessages
	{
		public readonly struct ScaleMessage : NetworkMessage
		{
			public readonly ReferenceHub TargetHub;

			public readonly Vector3 Scale;

			public ScaleMessage(Vector3 scale, ReferenceHub targetHub)
			{
				Scale = scale;
				TargetHub = targetHub;
			}
		}

		public static void Serialize(this NetworkWriter writer, ScaleMessage value)
		{
			writer.WriteReferenceHub(value.TargetHub);
			writer.WriteVector3(value.Scale);
		}

		public static ScaleMessage Deserialize(this NetworkReader reader)
		{
			ReferenceHub targetHub = reader.ReadReferenceHub();
			return new ScaleMessage(reader.ReadVector3(), targetHub);
		}
	}
}

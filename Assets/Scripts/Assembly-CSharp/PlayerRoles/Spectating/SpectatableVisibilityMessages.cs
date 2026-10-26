using Mirror;
using Utils.Networking;

namespace PlayerRoles.Spectating
{
	public static class SpectatableVisibilityMessages
	{
		public readonly struct SpectatableVisibilityMessage : NetworkMessage
		{
			public readonly ReferenceHub TargetHub;

			public readonly bool ForceHidden;

			public SpectatableVisibilityMessage(ReferenceHub targetHub, bool forceHidden)
			{
				TargetHub = targetHub;
				ForceHidden = forceHidden;
			}
		}

		public static void Serialize(this NetworkWriter writer, SpectatableVisibilityMessage value)
		{
			writer.WriteReferenceHub(value.TargetHub);
			writer.WriteBool(value.ForceHidden);
		}

		public static SpectatableVisibilityMessage Deserialize(this NetworkReader reader)
		{
			ReferenceHub targetHub = reader.ReadReferenceHub();
			bool forceHidden = reader.ReadBool();
			return new SpectatableVisibilityMessage(targetHub, forceHidden);
		}
	}
}

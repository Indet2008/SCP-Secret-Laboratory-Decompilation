using Mirror;

namespace Hints
{
	public static class UIntHintParameterFunctions
	{
		public static void Serialize(this NetworkWriter writer, UIntHintParameter value)
		{
			value.Serialize(writer);
		}

		public static UIntHintParameter Deserialize(this NetworkReader reader)
		{
			return UIntHintParameter.FromNetwork(reader);
		}
	}
}

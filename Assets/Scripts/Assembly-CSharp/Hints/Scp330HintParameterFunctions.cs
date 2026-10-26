using Mirror;

namespace Hints
{
	public static class Scp330HintParameterFunctions
	{
		public static void Serialize(this NetworkWriter writer, Scp330HintParameter value)
		{
			value.Serialize(writer);
		}

		public static Scp330HintParameter Deserialize(this NetworkReader reader)
		{
			return Scp330HintParameter.FromNetwork(reader);
		}
	}
}

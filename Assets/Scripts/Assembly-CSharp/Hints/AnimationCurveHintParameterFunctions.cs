using Mirror;

namespace Hints
{
	public static class AnimationCurveHintParameterFunctions
	{
		public static void Serialize(this NetworkWriter writer, AnimationCurveHintParameter value)
		{
			value.Serialize(writer);
		}

		public static AnimationCurveHintParameter Deserialize(this NetworkReader reader)
		{
			return AnimationCurveHintParameter.FromNetwork(reader);
		}
	}
}

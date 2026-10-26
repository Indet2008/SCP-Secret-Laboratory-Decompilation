using Mirror;
using Utils.Networking;

namespace Hints
{
	public abstract class Hint : DisplayableObject<SharedHintData>
	{
		private HintEffect[] _effects;

		protected HintParameter[] Parameters { get; private set; }

		protected Hint(HintParameter[] parameters, HintEffect[] effects, float durationScalar = 1f)
			: base(durationScalar)
		{
			_effects = effects;
			Parameters = parameters;
		}

		public override void Deserialize(NetworkReader reader)
		{
			base.Deserialize(reader);
			_effects = reader.ReadHintEffectArray();
			Parameters = reader.ReadHintParameterArray();
		}

		public override void Serialize(NetworkWriter writer)
		{
			base.Serialize(writer);
			writer.WriteHintEffectArray(_effects);
			writer.WriteHintParameterArray(Parameters);
		}
	}
}

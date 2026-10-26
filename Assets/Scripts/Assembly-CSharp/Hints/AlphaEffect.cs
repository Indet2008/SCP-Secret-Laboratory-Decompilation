using Mirror;

namespace Hints
{
	public class AlphaEffect : HintEffect
	{
		protected float Alpha { get; private set; }

		public static AlphaEffect FromNetwork(NetworkReader reader)
		{
			AlphaEffect alphaEffect = new AlphaEffect();
			alphaEffect.Deserialize(reader);
			return alphaEffect;
		}

		private AlphaEffect()
		{
		}

		public AlphaEffect(float alpha, float startScalar = 0f, float durationScalar = 1f)
			: base(startScalar, durationScalar)
		{
			Alpha = alpha;
		}

		public override void Deserialize(NetworkReader reader)
		{
			base.Deserialize(reader);
			Alpha = reader.ReadFloat();
		}

		public override void Serialize(NetworkWriter writer)
		{
			base.Serialize(writer);
			writer.WriteFloat(Alpha);
		}
	}
}

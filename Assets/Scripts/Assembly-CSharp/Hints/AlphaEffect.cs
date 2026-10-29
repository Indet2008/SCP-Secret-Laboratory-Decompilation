using Mirror;

namespace Hints
{
	public class AlphaEffect : HintEffect
	{
		private float _oldAlpha;

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

		protected override void Start()
		{
			_oldAlpha = base.Data.Textbox.alpha;
		}

		protected override void Destroy()
		{
			base.Data.Textbox.alpha = _oldAlpha;
		}

		protected override void UpdateState(float progress)
		{
			base.Data.Textbox.alpha = Alpha;
		}
	}
}

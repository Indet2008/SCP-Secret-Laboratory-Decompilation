using Mirror;

namespace Hints
{
	public abstract class HintEffect : DisplayableObject<SharedHintData>
	{
		public float StartScalar { get; private set; }

		protected HintEffect(float startScalar = 0f, float durationScalar = 1f)
			: base(durationScalar)
		{
			StartScalar = startScalar;
		}

		public override void Deserialize(NetworkReader reader)
		{
			base.Deserialize(reader);
			StartScalar = reader.ReadFloat();
		}

		public override void Serialize(NetworkWriter writer)
		{
			base.Serialize(writer);
			writer.WriteFloat(StartScalar);
		}

		protected override float UpdateProgress(float rawTime)
		{
			return (rawTime - StartScalar) / base.DurationScalar;
		}
	}
}

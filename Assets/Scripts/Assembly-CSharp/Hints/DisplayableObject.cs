using Mirror;

namespace Hints
{
	public abstract class DisplayableObject<TData> : NetworkObject<TData>
	{
		public float DurationScalar { get; private set; }

		protected DisplayableObject(float durationScalar = 1f)
		{
			DurationScalar = durationScalar;
		}

		public override void Deserialize(NetworkReader reader)
		{
			DurationScalar = reader.ReadFloat();
		}

		public override void Serialize(NetworkWriter writer)
		{
			writer.WriteFloat(DurationScalar);
		}
	}
}

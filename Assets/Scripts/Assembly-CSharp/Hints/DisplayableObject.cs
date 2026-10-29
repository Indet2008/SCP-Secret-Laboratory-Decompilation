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

		public bool TryAwake(TData data, float rawTime)
		{
			float num = UpdateProgress(rawTime);
			if (num > 0f && num <= 1f)
			{
				Awake(data);
				return true;
			}
			return false;
		}

		public float Update(float rawTime)
		{
			float num = UpdateProgress(rawTime);
			if (num > 0f && num <= 1f)
			{
				UpdateState(num);
			}
			return num;
		}

		protected abstract float UpdateProgress(float rawTime);

		protected abstract void UpdateState(float progress);
	}
}

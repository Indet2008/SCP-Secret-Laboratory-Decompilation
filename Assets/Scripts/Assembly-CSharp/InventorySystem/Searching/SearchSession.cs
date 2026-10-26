using System;
using Mirror;
using Utils;

namespace InventorySystem.Searching
{
	public struct SearchSession : ISearchSession, NetworkMessage, IEquatable<SearchSession>
	{
		public ISearchable Target { get; set; }

		public double InitialTime { get; set; }

		public double FinishTime { get; set; }

		public double Duration => FinishTime - InitialTime;

		public double Progress => MoreMath.InverseLerp(InitialTime, FinishTime, NetworkTime.time);

		public SearchSession(double initialTime, double finishTime, ISearchable target)
		{
			Target = target;
			InitialTime = initialTime;
			FinishTime = finishTime;
		}

		public void Deserialize(NetworkReader reader)
		{
			NetworkIdentity networkIdentity = reader.ReadNetworkIdentity();
			Target = ((networkIdentity == null) ? null : networkIdentity.GetComponent<ISearchable>());
			InitialTime = reader.ReadDouble();
			FinishTime = reader.ReadDouble();
		}

		public void Serialize(NetworkWriter writer)
		{
			writer.WriteNetworkIdentity(Target?.netIdentity);
			writer.WriteDouble(InitialTime);
			writer.WriteDouble(FinishTime);
		}

		public bool Equals(SearchSession other)
		{
			if (object.Equals(Target, other.Target) && InitialTime.Equals(other.InitialTime))
			{
				return FinishTime.Equals(other.FinishTime);
			}
			return false;
		}

		public override bool Equals(object obj)
		{
			if (obj is SearchSession other)
			{
				return Equals(other);
			}
			return false;
		}

		public override int GetHashCode()
		{
			return (((((Target != null) ? Target.GetHashCode() : 0) * 397) ^ InitialTime.GetHashCode()) * 397) ^ FinishTime.GetHashCode();
		}
	}
}

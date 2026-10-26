using System;
using Mirror;

namespace InventorySystem.Searching
{
	public struct SearchInvalidation : ISearchIdentifiable, NetworkMessage, IEquatable<SearchInvalidation>
	{
		public byte Id { get; private set; }

		public SearchInvalidation(byte id)
		{
			Id = id;
		}

		public void Deserialize(NetworkReader reader)
		{
			Id = reader.ReadByte();
		}

		public void Serialize(NetworkWriter writer)
		{
			writer.WriteByte(Id);
		}

		public bool Equals(SearchInvalidation other)
		{
			return Id == other.Id;
		}

		public override bool Equals(object obj)
		{
			if (obj is SearchInvalidation other)
			{
				return Equals(other);
			}
			return false;
		}

		public override int GetHashCode()
		{
			return Id.GetHashCode();
		}
	}
}

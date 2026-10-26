using System;
using Mirror;

namespace InventorySystem.Searching
{
	public struct SearchRequest : ISearchSession, NetworkMessage, IEquatable<SearchRequest>
	{
		private SearchSession _body;

		public byte Id { get; private set; }

		public SearchRequest(byte id, SearchSession body)
		{
			_body = body;
			Id = id;
		}

		public SearchSession Body => _body;

		public ISearchable Target
		{
			get
			{
				return _body.Target;
			}
			set
			{
				_body.Target = value;
			}
		}

		public double InitialTime
		{
			get
			{
				return _body.InitialTime;
			}
			set
			{
				_body.InitialTime = value;
			}
		}

		public double FinishTime
		{
			get
			{
				return _body.FinishTime;
			}
			set
			{
				_body.FinishTime = value;
			}
		}

		public double Progress => _body.Progress;

		public void Deserialize(NetworkReader reader)
		{
			Id = reader.ReadByte();
			_body.Deserialize(reader);
		}

		public void Serialize(NetworkWriter writer)
		{
			writer.WriteByte(Id);
			_body.Serialize(writer);
		}

		public bool Equals(SearchRequest other)
		{
			if (Body.Equals(other.Body))
			{
				return Id == other.Id;
			}
			return false;
		}

		public override bool Equals(object obj)
		{
			if (obj is SearchRequest other)
			{
				return Equals(other);
			}
			return false;
		}

		public override int GetHashCode()
		{
			return (Body.GetHashCode() * 397) ^ Id.GetHashCode();
		}
	}
}

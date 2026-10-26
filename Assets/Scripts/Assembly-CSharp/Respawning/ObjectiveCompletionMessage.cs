using System.Collections.Generic;
using Mirror;
using Respawning.Objectives;

namespace Respawning
{
	public struct ObjectiveCompletionMessage : NetworkMessage
	{
		private readonly int _index;

		public FactionObjectiveBase Objective { get; private set; }

		public ObjectiveCompletionMessage(FactionObjectiveBase objective)
		{
			_index = FactionInfluenceManager.Objectives.IndexOf(objective);
			Objective = objective;
		}

		public ObjectiveCompletionMessage(int index)
		{
			_index = index;
			Objective = FactionInfluenceManager.Objectives[_index];
		}

		public ObjectiveCompletionMessage(NetworkReader reader)
		{
			_index = reader.ReadInt();
			if (!FactionInfluenceManager.Objectives.TryGet(_index, out var element))
			{
				throw new KeyNotFoundException($"Failed to get objective of index: {_index}.");
			}
			Objective = element;
			Objective.ClientReadRpc(reader);
		}

		public void Write(NetworkWriter writer)
		{
			writer.WriteInt(_index);
			if (NetworkServer.active)
			{
				Objective.ServerWriteRpc(writer);
			}
		}
	}
}

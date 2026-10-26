using System;
using MapGeneration;
using UnityEngine;

namespace Interactables.Interobjects
{
	public interface IRoomConnector
	{
		protected static readonly Vector3[] WorldDirections;

		protected static readonly RoomIdentifier[] RoomsNonAlloc;

		RoomIdentifier[] Rooms { get; }

		bool RoomsAlreadyRegistered { get; }

		bool IsVisibleThrough { get; }

		event Action OnRoomsRegistered;

		static IRoomConnector()
		{
			WorldDirections = new Vector3[4]
			{
				Vector3.forward,
				Vector3.back,
				Vector3.left,
				Vector3.right
			};
			RoomsNonAlloc = new RoomIdentifier[WorldDirections.Length];
		}
	}
}

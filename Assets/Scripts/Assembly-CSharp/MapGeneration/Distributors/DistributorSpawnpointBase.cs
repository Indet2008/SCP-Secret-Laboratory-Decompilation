using System;
using UnityEngine;

namespace MapGeneration.Distributors
{
	public abstract class DistributorSpawnpointBase : MonoBehaviour
	{
		private RoomName _roomName;

		private bool _roomSet;

		public RoomName RoomName
		{
			get
			{
				if (_roomSet)
				{
					return _roomName;
				}
				if (base.transform.position.TryGetRoom(out var room))
				{
					_roomName = room.Name;
					_roomSet = true;
					return _roomName;
				}
				Debug.LogError("This spawnpoint (" + base.transform.GetHierarchyPath() + ") has no valid room!", base.gameObject);
				throw new InvalidOperationException("Misplaced spawnpoint detected!");
			}
		}

		protected virtual void Awake()
		{
			base.transform.localScale = Vector3.one;
		}
	}
}

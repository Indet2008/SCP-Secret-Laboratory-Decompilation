using System;
using System.Collections.Generic;
using UnityEngine;

namespace MapGeneration.Rooms
{
	public class MultiLevelRoomIdentifier : RoomIdentifier
	{
		[Serializable]
		public struct LevelBounds
		{
			public RoomLevelName Name;

			public Bounds Bounds;

			public LevelBounds(RoomLevelName name, Bounds bounds)
			{
				Name = name;
				Bounds = bounds;
			}
		}

		public List<LevelBounds> Levels;

		public bool IsInLevel(RoomLevelName levelName, Vector3 position)
		{
			if (TryGetLevelBounds(levelName, out var bounds))
			{
				return bounds.Contains(position - base.transform.position);
			}
			return false;
		}

		public bool TryGetLevelBounds(RoomLevelName levelName, out Bounds bounds)
		{
			foreach (LevelBounds level in Levels)
			{
				if (level.Name == levelName)
				{
					bounds = level.Bounds;
					return true;
				}
			}
			bounds = default;
			return false;
		}

		public bool TryGetLevel(Vector3 position, out RoomLevelName levelName)
		{
			base.transform.GetPositionAndRotation(out var position2, out var rotation);
			foreach (LevelBounds level in Levels)
			{
				Bounds bounds = level.Bounds;
				Vector3 center = rotation * bounds.center + position2;
				Vector3 size = (rotation * bounds.size).Abs();
				if (new Bounds(center, size).Contains(position))
				{
					levelName = level.Name;
					return true;
				}
			}
			levelName = RoomLevelName.Main;
			return false;
		}
	}
}

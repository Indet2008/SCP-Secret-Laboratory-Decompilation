using System;
using System.Collections.Generic;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Spawnpoints
{
	public class ConditionalSpawnpointHandler : StandardSpawnpointHandler
	{
		[Serializable]
		private struct SerializedSpawnpoint
		{
			public RoleChangeReason Condition;

			public RoomRoleSpawnpoint[] Spawnpoints;
		}

		private static readonly Dictionary<RoleTypeId, Dictionary<RoleChangeReason, RoomRoleSpawnpoint[]>> RoleSpawnpoints = new Dictionary<RoleTypeId, Dictionary<RoleChangeReason, RoomRoleSpawnpoint[]>>();

		[SerializeField]
		private SerializedSpawnpoint[] _conditionalSpawnpoints;

		private void Awake()
		{
			if (base.Role == null)
			{
				return;
			}
			RoleTypeId roleTypeId = base.Role.RoleTypeId;
			if (!RoleSpawnpoints.ContainsKey(roleTypeId))
			{
				Dictionary<RoleChangeReason, RoomRoleSpawnpoint[]> dictionary = new Dictionary<RoleChangeReason, RoomRoleSpawnpoint[]>();
				SerializedSpawnpoint[] conditionalSpawnpoints = _conditionalSpawnpoints;
				for (int i = 0; i < conditionalSpawnpoints.Length; i++)
				{
					SerializedSpawnpoint serializedSpawnpoint = conditionalSpawnpoints[i];
					dictionary.Add(serializedSpawnpoint.Condition, serializedSpawnpoint.Spawnpoints);
				}
				RoleSpawnpoints[roleTypeId] = dictionary;
			}
		}

		public override bool TryGetSpawnpoint(out Vector3 position, out float horizontalRot)
		{
			if (TryGetConditionalSpawnpoint(out position, out horizontalRot))
			{
				return true;
			}
			return base.TryGetSpawnpoint(out position, out horizontalRot);
		}

		public bool TryGetConditionalSpawnpoint(out Vector3 position, out float horizontalRot)
		{
			position = default;
			horizontalRot = 0f;
			if (_conditionalSpawnpoints.Length == 0)
			{
				return false;
			}
			if (!RoleSpawnpoints.TryGetValue(base.Role.RoleTypeId, out var value))
			{
				return false;
			}
			RoleChangeReason serverSpawnReason = base.Role.ServerSpawnReason;
			if (!value.TryGetValue(serverSpawnReason, out var value2))
			{
				return false;
			}
			value2 = StandardSpawnpointHandler.GetValidSpawnpoints(value2);
			return value2.RandomItem().TryGetSpawnpoint(out position, out horizontalRot);
		}
	}
}

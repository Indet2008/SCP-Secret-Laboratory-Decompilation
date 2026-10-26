using System;
using System.Collections.Generic;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace MapGeneration
{
	public class RoomIdentifier : MonoBehaviour
	{
		public static readonly HashSet<RoomIdentifier> AllRoomIdentifiers = new HashSet<RoomIdentifier>();

		public static readonly Dictionary<Vector3Int, RoomIdentifier> RoomsByCoords = new Dictionary<Vector3Int, RoomIdentifier>();

		public static readonly Vector3 GridScale = new Vector3(15f, 100f, 15f);

		public readonly HashSet<RoomIdentifier> ConnectedRooms = new HashSet<RoomIdentifier>();

		public readonly List<RoomLightController> LightControllers = new List<RoomLightController>();

		public RoomShape Shape;

		public RoomName Name;

		public FacilityZone Zone;

		public Sprite Icon;

		public Vector3Int MainCoords { get; private set; }

		public Bounds WorldspaceBounds { get; private set; }

		public static event Action<RoomIdentifier> OnAdded;

		public static event Action<RoomIdentifier> OnRemoved;

		private void Awake()
		{
			SeedSynchronizer.OnGenerationStage += OnMapgenPhase;
			if (SeedSynchronizer.MapGenerated)
			{
				RegisterCoords();
			}
			AllRoomIdentifiers.Add(this);
			OnAdded?.Invoke(this);
		}

		private void OnDestroy()
		{
			SeedSynchronizer.OnGenerationStage -= OnMapgenPhase;
			AllRoomIdentifiers.Remove(this);
			RoomsByCoords.Remove(MainCoords);
			OnRemoved?.Invoke(this);
			LightControllers.Clear();
		}

		private void OnMapgenPhase(MapGenerationPhase phase)
		{
			if (phase == MapGenerationPhase.RoomCoordsRegistrations)
			{
				RegisterCoords();
			}
		}

		private void RegisterCoords()
		{
			MainCoords = RoomUtils.PositionToCoords(base.transform.position);
			RoomsByCoords[MainCoords] = this;
			RecalculateWorldspaceBounds();
		}

		private void RecalculateWorldspaceBounds()
		{
			Bounds worldspaceBounds = new Bounds(base.transform.position, Vector3.zero);
			MeshRenderer[] componentsInChildren = GetComponentsInChildren<MeshRenderer>();
			foreach (MeshRenderer meshRenderer in componentsInChildren)
			{
				meshRenderer.ResetBounds();
				worldspaceBounds.Encapsulate(meshRenderer.bounds);
			}
			WorldspaceBounds = worldspaceBounds;
		}

		public RoomLightController GetClosestLightController(ReferenceHub hub)
		{
			if (hub == null || !(hub.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return null;
			}
			if (LightControllers.Count == 0)
			{
				return null;
			}
			if (LightControllers.Count == 1)
			{
				return LightControllers[0];
			}
			Vector3 position = fpcRole.FpcModule.Position;
			float num = float.MaxValue;
			RoomLightController result = null;
			foreach (RoomLightController lightController in LightControllers)
			{
				float sqrMagnitude = (lightController.transform.position - position).sqrMagnitude;
				if (sqrMagnitude < num)
				{
					num = sqrMagnitude;
					result = lightController;
				}
			}
			return result;
		}

		private void OnDrawGizmosSelected()
		{
			Gizmos.color = Color.white;
			Gizmos.DrawWireCube(WorldspaceBounds.center, WorldspaceBounds.size);
		}
	}
}

using System.Collections.Generic;
using MapGeneration;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace ProgressiveCulling
{
	public static class RoomPreCuller
	{
		private static readonly HashSet<Vector3Int> VisibleCoords = new HashSet<Vector3Int>();

		private static bool _lastSuccess = false;

		private static Vector3 _lastCameraPosition;

		private static float? _roomSize;

		private const float ExtraCameraRange = 4f;

		private static readonly Vector3Int[] ScanDirections = new Vector3Int[4]
		{
			Vector3Int.forward,
			Vector3Int.back,
			Vector3Int.left,
			Vector3Int.right
		};

		private static readonly bool EnableDebugging = false;

		private static float RoomSize
		{
			get
			{
				float valueOrDefault = _roomSize.GetValueOrDefault();
				if (!_roomSize.HasValue)
				{
					valueOrDefault = Mathf.Max(RoomIdentifier.GridScale.x, RoomIdentifier.GridScale.z);
					_roomSize = valueOrDefault;
				}
				return _roomSize.Value;
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CullingCamera.OnStageStarted += OnStageStarted;
		}

		private static void OnStageStarted(RootCullablePriority priority, Camera cam)
		{
			if (priority == RootCullablePriority.PreCull)
			{
				_lastSuccess = TryPreCull(cam);
			}
		}

		private static bool TryPreCull(Camera cam)
		{
			if (ReferenceHub.TryGetLocalHub(out var hub) && hub.roleManager.CurrentRole is IFpcRole fpcRole && fpcRole.FpcModule.Noclip.IsActive)
			{
				return false;
			}
			Transform transform = cam.transform;
			_lastCameraPosition = transform.position;
			if (!_lastCameraPosition.TryGetRoom(out var room))
			{
				return false;
			}
			VisibleCoords.Clear();
			int maxJumps = Mathf.CeilToInt((cam.farClipPlane + 4f) / RoomSize);
			ScanCoords(camVertex: new VertexAngle2D(transform.forward, _lastCameraPosition, cam.fieldOfView, cam.aspect), coords: room.MainCoords, maxJumps: maxJumps, iteration: 0);
			return true;
		}

		private static void ScanCoords(Vector3Int coords, VertexAngle2D camVertex, int maxJumps, int iteration)
		{
			DebugVertexAngle(camVertex, (float)iteration * RoomSize + 1f);
			VisibleCoords.Add(coords);
			if (iteration >= maxJumps)
			{
				return;
			}
			Vector3Int[] scanDirections = ScanDirections;
			foreach (Vector3Int vector3Int in scanDirections)
			{
				Vector3Int vector3Int2 = coords + vector3Int;
				if (VisibleCoords.Contains(vector3Int2) || !RoomCullingConnection.TryGetConnection(coords, vector3Int2, out var conn))
				{
					continue;
				}
				Bounds worldspaceBounds = conn.WorldspaceBounds;
				if (conn.Connector.IsVisibleThrough || worldspaceBounds.Contains(_lastCameraPosition))
				{
					VertexAngle2D vertexAngle2D = new VertexAngle2D(camVertex.Origin, worldspaceBounds);
					VertexAngle2D result;
					bool flag;
					if (iteration == 0)
					{
						result = vertexAngle2D;
						flag = true;
					}
					else
					{
						flag = CullingMath.TryGetCommon(camVertex, vertexAngle2D, out result);
					}
					if (flag && CullingCamera.CheckBoundsVisibility(worldspaceBounds))
					{
						ScanCoords(vector3Int2, result, maxJumps, iteration + 1);
					}
					else
					{
						ScanBounds(conn, camVertex, vector3Int2);
					}
				}
			}
		}

		private static void ScanBounds(RoomCullingConnection rcc, VertexAngle2D vertex, Vector3Int otherCoords)
		{
			RoomCullingConnection.RoomLink link = rcc.Link;
			CullableRoom cullableRoom;
			if (link.Coords.CoordsA == otherCoords)
			{
				cullableRoom = link.CullableA;
			}
			else
			{
				if (!(link.Coords.CoordsB == otherCoords))
				{
					Debug.LogError($"Link {rcc.name} is not matching any rooms at {otherCoords}.");
					return;
				}
				cullableRoom = link.CullableB;
			}
			Bounds worldspaceBounds = cullableRoom.WorldspaceBounds;
			if (CullingCamera.CheckBoundsVisibility(worldspaceBounds) && CullingMath.ContainsBoundsWithinVertex(vertex, worldspaceBounds))
			{
				VisibleCoords.Add(otherCoords);
			}
		}

		private static void DebugVertexAngle(VertexAngle2D vertex, float distance)
		{
			if (EnableDebugging)
			{
				Vector3 start = CullingMath.To3D(vertex.Origin, _lastCameraPosition.y);
				Vector3 vector = CullingMath.To3D(vertex.Left, 0f);
				Vector3 vector2 = CullingMath.To3D(vertex.Right, 0f);
				Debug.DrawRay(start, vector * distance, Color.green);
				Debug.DrawRay(start, vector2 * distance, Color.yellow);
			}
		}

		public static bool ValidateCoords(Vector3Int coords)
		{
			if (_lastSuccess)
			{
				return VisibleCoords.Contains(coords);
			}
			return true;
		}
	}
}

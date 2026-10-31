using System.Collections.Generic;
using Interactables.Interobjects.DoorUtils;
using Mirror;
using UnityEngine;

namespace MapGeneration.RoomConnectors.Spawners
{
	public abstract class RoomConnectorSpawnpointBase : MonoBehaviour
	{
		private static readonly Queue<RoomConnectorSpawnpointBase> AllInstances = new Queue<RoomConnectorSpawnpointBase>();

		private const float MinSqrDistanceBetweenConnectors = 1f;

		private RoomIdentifier _parentRoom;

		public string DesiredNametag;

		public int ConnectorPriority;

		public int SpawnPriority;

		public abstract SpawnableRoomConnectorType FallbackType { get; }

#if UNITY_EDITOR
		private static readonly Color PreviewColor = new Color(1f, 1f, 1f, 0.35f);

		private static RoomConnectorDistributorSettings[] _previewSettings;

		private static readonly Dictionary<SpawnableRoomConnector, List<(Mesh, Matrix4x4)>> PreviewMeshes = new Dictionary<SpawnableRoomConnector, List<(Mesh, Matrix4x4)>>();

		// The connector type drawn in the Scene view.
		protected virtual SpawnableRoomConnectorType PreviewType => FallbackType;

		// Scene-view preview: the connector this spawnpoint creates, drawn as a translucent solid mesh.
		private void OnDrawGizmos()
		{
			if (!TryGetPreviewTemplate(PreviewType, out var template) && !TryGetPreviewTemplate(FallbackType, out template))
			{
				return;
			}
			Matrix4x4 spawnpointMatrix = Matrix4x4.TRS(base.transform.position, base.transform.rotation, Vector3.one);
			Gizmos.color = PreviewColor;
			foreach ((Mesh mesh, Matrix4x4 local) in GetPreviewMeshes(template))
			{
				Gizmos.matrix = spawnpointMatrix * local;
				for (int i = 0; i < mesh.subMeshCount; i++)
				{
					Gizmos.DrawMesh(mesh, i);
				}
			}
			Gizmos.matrix = Matrix4x4.identity;
		}

		private static List<(Mesh, Matrix4x4)> GetPreviewMeshes(SpawnableRoomConnector template)
		{
			if (PreviewMeshes.TryGetValue(template, out var meshes))
			{
				return meshes;
			}
			meshes = new List<(Mesh, Matrix4x4)>();
			Matrix4x4 templateRoot = template.transform.worldToLocalMatrix;
			foreach (MeshFilter meshFilter in template.GetComponentsInChildren<MeshFilter>(includeInactive: false))
			{
				if (meshFilter.sharedMesh != null)
				{
					meshes.Add((meshFilter.sharedMesh, templateRoot * meshFilter.transform.localToWorldMatrix));
				}
			}
			PreviewMeshes[template] = meshes;
			return meshes;
		}

		private static bool TryGetPreviewTemplate(SpawnableRoomConnectorType type, out SpawnableRoomConnector template)
		{
			if (RoomConnectorDistributorSettings.TryGetTemplate(type, out template))
			{
				return true;
			}
			// Outside play mode nothing has registered the templates yet; look them up directly. Loaded once, because
			// Resources.LoadAll scans the whole Resources folder and gizmos are drawn every repaint.
			if (_previewSettings == null)
			{
				_previewSettings = Resources.LoadAll<RoomConnectorDistributorSettings>(string.Empty);
			}
			foreach (RoomConnectorDistributorSettings settings in _previewSettings)
			{
				if (settings == null)
				{
					continue;
				}
				foreach (SpawnableRoomConnector connector in settings.SpawnableConnectors)
				{
					if (connector != null && connector.SpawnData.ConnectorType == type)
					{
						template = connector;
						return true;
					}
				}
			}
			return false;
		}
#endif

		protected virtual void Awake()
		{
			_parentRoom = GetComponentInParent<RoomIdentifier>();
			AllInstances.Enqueue(this);
		}

		public abstract float GetSpawnChanceWeight(SpawnableRoomConnectorType type);

		public virtual void SpawnFallback()
		{
			Spawn(FallbackType);
		}

		public void Spawn(SpawnableRoomConnectorType type)
		{
			if (RoomConnectorDistributorSettings.TryGetTemplate(type, out var result))
			{
				SpawnableRoomConnector spawnableRoomConnector = Object.Instantiate(result, base.transform.position, base.transform.rotation);
				if (spawnableRoomConnector.TryGetComponent<DoorVariant>(out var component) && !string.IsNullOrEmpty(DesiredNametag))
				{
					component.gameObject.AddComponent<DoorNametagExtension>().UpdateName(DesiredNametag);
				}
				NetworkServer.Spawn(spawnableRoomConnector.gameObject);
			}
		}

		protected abstract void MergeWith(RoomConnectorSpawnpointBase retired);

		protected virtual void OnRetire(RoomConnectorSpawnpointBase successor)
		{
		}

		public static void SetupAllRoomConnectors()
		{
			HashSet<RoomConnectorSpawnpointBase> readyToSpawn = ResolveConnectorConflicts();
			if (NetworkServer.active)
			{
				RoomConnectorSpawner.ServerSpawnAllConnectors(readyToSpawn);
			}
		}

		private static HashSet<RoomConnectorSpawnpointBase> ResolveConnectorConflicts()
		{
			HashSet<RoomConnectorSpawnpointBase> hashSet = new HashSet<RoomConnectorSpawnpointBase>();
			while (AllInstances.Count > 0)
			{
				RoomConnectorSpawnpointBase roomConnectorSpawnpointBase = AllInstances.Dequeue();
				if (roomConnectorSpawnpointBase == null || !roomConnectorSpawnpointBase.gameObject.activeInHierarchy)
				{
					continue;
				}
				Vector3 position = roomConnectorSpawnpointBase.transform.position;
				bool flag = true;
				RoomConnectorSpawnpointBase roomConnectorSpawnpointBase2 = null;
				foreach (RoomConnectorSpawnpointBase item in hashSet)
				{
					if ((item.transform.position - position).sqrMagnitude > 1f)
					{
						continue;
					}
					ConnectRooms(item, roomConnectorSpawnpointBase);
					if (NetworkServer.active)
					{
						if (roomConnectorSpawnpointBase.ConnectorPriority > item.ConnectorPriority)
						{
							MergeRoomConnectors(roomConnectorSpawnpointBase, item);
							roomConnectorSpawnpointBase2 = item;
						}
						else
						{
							MergeRoomConnectors(item, roomConnectorSpawnpointBase);
							flag = false;
						}
						break;
					}
				}
				if (flag)
				{
					hashSet.Add(roomConnectorSpawnpointBase);
				}
				if (roomConnectorSpawnpointBase2 != null)
				{
					hashSet.Remove(roomConnectorSpawnpointBase2);
				}
			}
			return hashSet;
		}

		private static void MergeRoomConnectors(RoomConnectorSpawnpointBase higherPriority, RoomConnectorSpawnpointBase lowerPriority)
		{
			Vector3 position = higherPriority.transform.position;
			Vector3 position2 = lowerPriority.transform.position;
			Vector3 position3 = (position + position2) / 2f;
			higherPriority.transform.position = position3;
			higherPriority.MergeWith(lowerPriority);
			lowerPriority.OnRetire(higherPriority);
			if (!string.IsNullOrEmpty(lowerPriority.DesiredNametag))
			{
				higherPriority.DesiredNametag = lowerPriority.DesiredNametag;
			}
		}

		private static void ConnectRooms(RoomConnectorSpawnpointBase connector1, RoomConnectorSpawnpointBase connector2)
		{
			if (!(connector1._parentRoom == connector2._parentRoom))
			{
				connector1._parentRoom.ConnectedRooms.Add(connector2._parentRoom);
				connector2._parentRoom.ConnectedRooms.Add(connector1._parentRoom);
				if (!NetworkServer.active)
				{
					Object.Destroy(connector2.gameObject);
					Object.Destroy(connector1.gameObject);
				}
			}
		}
	}
}

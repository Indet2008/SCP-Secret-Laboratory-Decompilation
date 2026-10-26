using System;
using System.Collections.Generic;
using MapGeneration;
using PlayerRoles;
using UnityEngine;

namespace ProgressiveCulling
{
	public class CullingCamera : MonoBehaviour
	{
		private Camera _camera;

		[SerializeField]
		private float _minFarClipPlane = 10f;

		[SerializeField]
		private float _farClipPlaneFogOffset = 1f;

		private static float _lastFarPlaneSqr;

		private static bool _pauseCulling;

		private static readonly Plane[] LastPlanes = new Plane[6];

		private static readonly HashSet<IRootCullable> RootCullables = new HashSet<IRootCullable>();

		public static Vector3 LastCamPosition { get; private set; }

		private static bool CullingPaused
		{
			get
			{
				if (!_pauseCulling)
				{
					return false;
				}
				if (!ReferenceHub.TryGetLocalHub(out var hub) || !hub.IsAlive())
				{
					return true;
				}
				foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
				{
					if (allHub.IsAlive() && HitboxIdentity.IsEnemy(allHub, hub))
					{
						return false;
					}
				}
				return true;
			}
		}

		public static event Action<RootCullablePriority, Camera> OnStageStarted;

		private void Awake()
		{
			_camera = GetComponent<Camera>();
		}

		private void OnEnable()
		{
			MainCameraController.OnUpdated += UpdateCulling;
		}

		private void OnDisable()
		{
			MainCameraController.OnUpdated -= UpdateCulling;
		}

		private static readonly List<IRootCullable> StageBuffer = new List<IRootCullable>();

		// Client-only body stripped from the server build. Rebuilt from how the rest of this namespace consumes it:
		// refresh the frustum/camera state, then run each priority stage (PreCull lets RoomPreCuller pick visible
		// coords, then rooms, then dynamic objects) and update every root cullable registered for it.
		private void UpdateCulling()
		{
			if (_camera == null || CullingPaused)
			{
				return;
			}
			LastCamPosition = _camera.transform.position;
			float farPlane = Mathf.Max(_minFarClipPlane, _camera.farClipPlane + _farClipPlaneFogOffset);
			_lastFarPlaneSqr = farPlane * farPlane;
			GeometryUtility.CalculateFrustumPlanes(_camera, LastPlanes);
			foreach (RootCullablePriority priority in (RootCullablePriority[])Enum.GetValues(typeof(RootCullablePriority)))
			{
				OnStageStarted?.Invoke(priority, _camera);
				StageBuffer.Clear();
				foreach (IRootCullable cullable in RootCullables)
				{
					if (cullable.Priority == priority)
					{
						StageBuffer.Add(cullable);
					}
				}
				foreach (IRootCullable cullable in StageBuffer)
				{
					if (cullable is Component component && component == null)
					{
						RootCullables.Remove(cullable);
						continue;
					}
					cullable.UpdateState();
				}
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			SeedSynchronizer.OnGenerationStage += OnMapGenerationStage;
		}

		private static void OnMapGenerationStage(MapGenerationPhase stage)
		{
			if (stage != MapGenerationPhase.CullingCaching)
			{
				return;
			}
			foreach (IRootCullable rootCullable in RootCullables)
			{
				rootCullable.SetupCache();
			}
		}

		public static bool CheckBoundsVisibility(Plane[] planes, float maxDistanceSqr, Bounds bounds)
		{
			Vector3 min = bounds.min;
			Vector3 max = bounds.max;
			for (int i = 0; i < planes.Length; i++)
			{
				Plane plane = planes[i];
				Vector3 normal = plane.normal;
				Vector3 rhs = min;
				Vector3 vector = max;
				if (normal.x >= 0f)
				{
					rhs.x = max.x;
					vector.x = min.x;
				}
				if (normal.y >= 0f)
				{
					rhs.y = max.y;
					vector.y = min.y;
				}
				if (normal.z >= 0f)
				{
					rhs.z = max.z;
					vector.z = min.z;
				}
				if (!(Vector3.Dot(normal, rhs) + plane.distance >= 0f))
				{
					return false;
				}
			}
			return bounds.SqrDistance(LastCamPosition) < maxDistanceSqr;
		}

		public static bool CheckBoundsVisibility(Bounds bounds)
		{
			if (LastPlanes != null)
			{
				return CheckBoundsVisibility(LastPlanes, _lastFarPlaneSqr, bounds);
			}
			return true;
		}

		public static void RegisterRootCullable(IRootCullable cullable)
		{
			RootCullables.Add(cullable);
			if (SeedSynchronizer.MapGenerated)
			{
				cullable.SetupCache();
			}
		}

		public static void UnregisterRootCullable(IRootCullable cullable)
		{
			RootCullables.Remove(cullable);
		}

		public static bool TogglePause()
		{
			_pauseCulling = !_pauseCulling;
			return CullingPaused;
		}
	}
}

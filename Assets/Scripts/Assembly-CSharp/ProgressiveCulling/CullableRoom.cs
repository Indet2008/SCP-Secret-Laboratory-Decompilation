using System;
using System.Collections.Generic;
using MapGeneration;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace ProgressiveCulling
{
	public class CullableRoom : CullableBehaviour, IRootCullable, ICullable, IBoundsCullable
	{
		public static readonly List<CullableRoom> ActiveRooms = new List<CullableRoom>();

		private readonly AutoCuller _autoCuller = new AutoCuller();

		private readonly List<ICullable> _subCullables = new List<ICullable>();

		private readonly HashSet<GameObject> _originalActiveChildren = new HashSet<GameObject>();

		private RoomIdentifier _roomIdentifier;

		private bool _cached;

		public Bounds WorldspaceBounds { get; private set; }

		public RootCullablePriority Priority => RootCullablePriority.Rooms;

		public override bool ShouldBeVisible
		{
			get
			{
				if (_cached && RoomPreCuller.ValidateCoords(_roomIdentifier.MainCoords))
				{
					return CullingCamera.CheckBoundsVisibility(WorldspaceBounds);
				}
				return false;
			}
		}

		public event Action OnVisibilityUpdated;

		public void AddChildCullable(ICullable cullable)
		{
			if (_subCullables.AddIfNotContains(cullable) && cullable is IBoundsCullable boundsCullable)
			{
				WorldspaceBounds.Encapsulate(boundsCullable.WorldspaceBounds);
			}
		}

		public void RemoveChildSullable(ICullable cullable)
		{
			_subCullables.Remove(cullable);
		}

		public void SetupCache()
		{
			_autoCuller.Generate(base.gameObject, AllowCullingFilter, CullingMath.GetSafeForDeactivation);
			Bounds worldspaceBounds = _roomIdentifier.WorldspaceBounds;
			foreach (ICullable subCullable in _subCullables)
			{
				if (!(subCullable is IRootCullable) && subCullable is IBoundsCullable boundsCullable)
				{
					worldspaceBounds.Encapsulate(boundsCullable.WorldspaceBounds);
				}
			}
			_cached = true;
			WorldspaceBounds = worldspaceBounds;
			OnVisibilityChanged(ShouldBeVisible);
		}

		protected override void OnVisibilityChanged(bool isVisible)
		{
			_autoCuller.SetVisibility(isVisible);
			if (isVisible)
			{
				UpdateVisible();
				ActiveRooms.Add(this);
			}
			else
			{
				foreach (ICullable subCullable in _subCullables)
				{
					if (!IsNullSafe(subCullable))
					{
						subCullable.SetVisibility(isVisible: false);
					}
				}
				ActiveRooms.Remove(this);
			}
			OnVisibilityUpdated?.Invoke();
		}

		protected override void UpdateVisible()
		{
			base.UpdateVisible();
			for (int num = _subCullables.Count - 1; num >= 0; num--)
			{
				ICullable cullable = _subCullables[num];
				if (IsNullSafe(cullable))
				{
					_subCullables.RemoveAt(num);
				}
				else
				{
					cullable.UpdateState();
				}
			}
		}

		private void ProcessOriginalChild(GameObject go)
		{
			if (go.activeSelf)
			{
				_originalActiveChildren.Add(go);
				Transform transform = go.transform;
				for (int i = 0; i < transform.childCount; i++)
				{
					ProcessOriginalChild(transform.GetChild(i).gameObject);
				}
			}
		}

		private bool IsNullSafe(ICullable cull)
		{
			if (cull != null)
			{
				if (cull is Component component)
				{
					return component == null;
				}
				return false;
			}
			return true;
		}

		private void Awake()
		{
			_roomIdentifier = GetComponent<RoomIdentifier>();
			ProcessOriginalChild(base.gameObject);
			CullingCamera.RegisterRootCullable(this);
		}

		private void OnDestroy()
		{
			CullingCamera.UnregisterRootCullable(this);
			ActiveRooms.Remove(this);
		}

		private bool AllowCullingFilter(GameObject go)
		{
			if (_originalActiveChildren.Contains(go))
			{
				if (go.TryGetComponent<ICullable>(out var component))
				{
					return !_subCullables.Contains(component);
				}
				return true;
			}
			return false;
		}
	}
}

using System.Collections.Generic;
using UnityEngine;

namespace ProgressiveCulling
{
	public class CullableArea : CullableBehaviour, IAutoCullerOverrideComponent, IBoundsCullable, ICullable
	{
		private readonly AutoCuller _autoCuller = new AutoCuller();

		private readonly List<CullableArea> _childAreas = new List<CullableArea>();

		private Bounds[] _worldspaceActivationBounds;

		private Bounds _worldspacePropsBounds;

		[field: SerializeField]
		public Bounds[] ActivationBounds { get; private set; }

		[field: SerializeField]
		public Bounds PropsBounds { get; private set; }

		public bool AllowAutoCulling { get; private set; }

		public Bounds WorldspaceBounds => _worldspacePropsBounds;

		public override bool ShouldBeVisible
		{
			get
			{
				if (!CullingCamera.CheckBoundsVisibility(_worldspacePropsBounds))
				{
					return false;
				}
				if (_worldspaceActivationBounds == null)
				{
					return true;
				}
				Vector3 lastCamPosition = CullingCamera.LastCamPosition;
				Bounds[] worldspaceActivationBounds = _worldspaceActivationBounds;
				foreach (Bounds bounds in worldspaceActivationBounds)
				{
					if (bounds.Contains(lastCamPosition))
					{
						return true;
					}
				}
				return false;
			}
		}

		[ContextMenu("Auto-setup bounds")]
		private void AutoSetupBounds()
		{
			Bounds bounds = new Bounds(base.transform.position, Vector3.zero);
			Renderer[] componentsInChildren = GetComponentsInChildren<Renderer>();
			foreach (Renderer renderer in componentsInChildren)
			{
				bounds.Encapsulate(renderer.bounds);
			}
			PropsBounds = new Bounds(base.transform.InverseTransformPoint(bounds.center), (Quaternion.Inverse(base.transform.rotation) * bounds.size).Abs());
		}

		private Bounds TransformBounds(Bounds bounds)
		{
			Transform obj = base.transform;
			Vector3 center = obj.TransformPoint(bounds.center);
			Vector3 size = (obj.rotation * bounds.size).Abs();
			return new Bounds(center, size);
		}

		private void Start()
		{
			if (base.transform.parent.TryGetComponentInParent<CullableArea>(out var comp))
			{
				comp._childAreas.Add(this);
			}
			else
			{
				CullableRoom componentInParent = GetComponentInParent<CullableRoom>();
				_worldspacePropsBounds = new Bounds(componentInParent.transform.position, Vector3.one);
				componentInParent.AddChildCullable(this);
			}
			_worldspacePropsBounds = TransformBounds(PropsBounds);
			if (ActivationBounds == null || ActivationBounds.Length == 0)
			{
				_worldspaceActivationBounds = null;
			}
			else
			{
				int num = ActivationBounds.Length;
				_worldspaceActivationBounds = new Bounds[num];
				for (int i = 0; i < num; i++)
				{
					_worldspaceActivationBounds[i] = TransformBounds(ActivationBounds[i]);
				}
			}
			GenerateAutoCuller();
			_autoCuller.SetVisibility(ShouldBeVisible);
		}

		private void GenerateAutoCuller()
		{
			AllowAutoCulling = true;
			_autoCuller.Generate(base.gameObject, (GameObject x) => !x.TryGetComponent<CullableArea>(out var component) || component == this, CullingMath.GetSafeForDeactivation);
			AllowAutoCulling = false;
		}

		protected override void OnDrawGizmosSelected()
		{
			if (base.EditorShowGizmos)
			{
				_worldspacePropsBounds = TransformBounds(PropsBounds);
			}
			base.OnDrawGizmosSelected();
			if (base.EditorShowGizmos && ActivationBounds != null)
			{
				Gizmos.color = Color.blue;
				Bounds[] activationBounds = ActivationBounds;
				foreach (Bounds bounds in activationBounds)
				{
					Bounds bounds2 = TransformBounds(bounds);
					Gizmos.DrawWireCube(bounds2.center, bounds2.size);
				}
			}
		}

		protected override void OnVisibilityChanged(bool isVisible)
		{
			_autoCuller.SetVisibility(isVisible);
			foreach (CullableArea childArea in _childAreas)
			{
				childArea.SetVisibility(isVisible && childArea.ShouldBeVisible);
			}
		}

		protected override void UpdateVisible()
		{
			base.UpdateVisible();
			foreach (CullableArea childArea in _childAreas)
			{
				childArea.SetVisibility(childArea.ShouldBeVisible);
			}
		}
	}
}

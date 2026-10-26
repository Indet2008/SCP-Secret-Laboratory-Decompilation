using UnityEngine;

namespace ProgressiveCulling
{
	public abstract class DynamicCullableBase : CullableBehaviour, IRootCullable, ICullable, IBoundsCullable
	{
		private Transform _tr;

		protected abstract float BoundsSize { get; }

		protected virtual Vector3 BoundsOrigin
		{
			get
			{
				if (!(_tr == null))
				{
					return _tr.position;
				}
				return base.transform.position;
			}
		}

		public override bool ShouldBeVisible => CullingCamera.CheckBoundsVisibility(WorldspaceBounds);

		public RootCullablePriority Priority => RootCullablePriority.Dynamic;

		public Bounds WorldspaceBounds => new Bounds(BoundsOrigin, Vector3.one * BoundsSize);

		protected virtual void Awake()
		{
			_tr = base.transform;
			CullingCamera.RegisterRootCullable(this);
		}

		protected virtual void OnDestroy()
		{
			CullingCamera.UnregisterRootCullable(this);
		}

		protected override void OnDrawGizmosSelected()
		{
			_tr = base.transform;
			base.OnDrawGizmosSelected();
		}

		public virtual void SetupCache()
		{
		}
	}
}

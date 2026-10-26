using System;
using Mirror;
using UnityEngine;

namespace ProgressiveCulling
{
	public class CullableSimpleDynamic : DynamicCullableBase
	{
		[SerializeField]
		private float _boundsSize = 1f;

		[SerializeField]
		private float _heightOffset;

		[SerializeField]
		private AutoCuller _culler;

		protected override float BoundsSize => _boundsSize;

		protected override Vector3 BoundsOrigin => base.BoundsOrigin + Vector3.up * _heightOffset;

		public event Action OnCullChanged;

		[ContextMenu("Find cullable children")]
		private void FindCullableChildren()
		{
			_culler.Generate(base.gameObject, AllowCullingFilter, AllowDeactivationFilter);
		}

		protected virtual bool AllowCullingFilter(GameObject go)
		{
			return true;
		}

		protected virtual bool AllowDeactivationFilter(GameObject go)
		{
			if (go == base.gameObject || !go.activeSelf)
			{
				return false;
			}
			Component[] componentsInChildren = go.GetComponentsInChildren<Component>();
			foreach (Component component in componentsInChildren)
			{
				if (component is AudioSource || component is Collider || component is Animator)
				{
					return false;
				}
			}
			return true;
		}

		private void Reset()
		{
			FindCullableChildren();
		}

		protected override void OnVisibilityChanged(bool isVisible)
		{
			_culler.SetVisibility(isVisible);
			OnCullChanged?.Invoke();
		}
	}
}

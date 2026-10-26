using System;
using UnityEngine;

namespace ProgressiveCulling
{
	public class CullableRig : DynamicCullableBase
	{
		[SerializeField]
		private float _boundsSize = 1f;

		[SerializeField]
		private Transform _rootBone;

		[SerializeField]
		private GameObject[] _targetRenderers;

		protected override Vector3 BoundsOrigin
		{
			get
			{
				if (!(_rootBone == null))
				{
					return _rootBone.position;
				}
				return base.transform.position;
			}
		}

		protected override float BoundsSize => _boundsSize;

		public event Action OnVisibleAgain;

		protected override void OnVisibilityChanged(bool isVisible)
		{
			GameObject[] targetRenderers = _targetRenderers;
			foreach (GameObject gameObject in targetRenderers)
			{
				if (!(gameObject == null))
				{
					gameObject.SetActive(isVisible);
				}
			}
			if (isVisible)
			{
				OnVisibleAgain?.Invoke();
			}
		}

		public void SetTargetRenderers(GameObject[] newTargetRenderers)
		{
			_targetRenderers = newTargetRenderers;
		}
	}
}

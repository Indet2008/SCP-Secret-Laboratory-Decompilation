using UnityEngine;

namespace MapGeneration.Clutter
{
	public class ClutterBlocker : MonoBehaviour, IClutterBlocker
	{
		[SerializeField]
		private Bounds _blockingBounds;

		[SerializeField]
		private Transform _targetTransform;

		public Bounds BlockingBounds
		{
			get
			{
				_targetTransform.GetPositionAndRotation(out var position, out var rotation);
				Vector3 vector = rotation * _blockingBounds.center;
				Vector3 size = (rotation * _blockingBounds.size).Abs();
				return new Bounds(position + vector, size);
			}
		}

		private void Awake()
		{
			IClutterBlocker.Instances.Add(this);
		}

		private void OnDestroy()
		{
			IClutterBlocker.Instances.Remove(this);
		}

		private void OnDrawGizmosSelected()
		{
			Gizmos.color = Color.yellow;
			Gizmos.DrawWireCube(BlockingBounds.center, BlockingBounds.size);
		}

		private void OnValidate()
		{
			if (!(_targetTransform != null))
			{
				_targetTransform = base.transform;
			}
		}
	}
}

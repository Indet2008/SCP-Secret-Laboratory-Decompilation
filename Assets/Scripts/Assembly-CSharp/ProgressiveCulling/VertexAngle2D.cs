using UnityEngine;

namespace ProgressiveCulling
{
	public struct VertexAngle2D
	{
		public Vector2 Origin;

		public Vector2 Left;

		public Vector2 Right;

		public VertexAngle2D(Vector3 forward, Vector3 origin, float verticalFov, float aspect)
		{
			Vector3 vector = forward.NormalizeIgnoreY();
			float num = CullingMath.VerticalToHorizontalFov(verticalFov, aspect) * 0.5f;
			Quaternion quaternion = Quaternion.Euler(Vector3.up * num);
			Quaternion quaternion2 = Quaternion.Inverse(quaternion);
			Origin = CullingMath.To2D(origin);
			Left = CullingMath.To2D(quaternion2 * vector);
			Right = CullingMath.To2D(quaternion * vector);
		}

		public VertexAngle2D(Vector3 origin, Vector3 left, Vector3 right)
		{
			Origin = origin;
			Left = left;
			Right = right;
		}

		public VertexAngle2D(Vector2 origin2d, Bounds connectorBounds)
		{
			Vector2 vector = CullingMath.To2D(connectorBounds.min);
			Vector2 vector2 = CullingMath.To2D(connectorBounds.max);
			Origin = origin2d;
			Left = (vector - origin2d).normalized;
			Right = (vector2 - origin2d).normalized;
		}
	}
}

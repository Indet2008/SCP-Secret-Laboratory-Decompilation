using System;
using System.Collections.Generic;
using MapGeneration.Distributors;
using Mirror;
using UnityEngine;

namespace ProgressiveCulling
{
	public static class CullingMath
	{
		private static readonly Plane[] CustomPlanesNonAlloc = new Plane[6];

		private static readonly List<Component> ComponentFetcherNonAlloc = new List<Component>();

		public static Plane[] CalculateFrustumPlanesAspectRatio(float verticalFov, float aspectRatio, float zNear, float zFar, Vector3 pos, Quaternion rot)
		{
			Matrix4x4 matrix4x = Matrix4x4.Perspective(verticalFov, aspectRatio, zNear, zFar);
			Matrix4x4 inverse = Matrix4x4.TRS(pos, rot * Quaternion.Euler(0f, 180f, 0f), Vector3.one).inverse;
			GeometryUtility.CalculateFrustumPlanes(matrix4x * inverse, CustomPlanesNonAlloc);
			return CustomPlanesNonAlloc;
		}

		public static Plane[] CalculateFrustumPlanesFovs(float verticalFov, float horizontalFov, float zNear, float zFar, Vector3 pos, Quaternion rot)
		{
			float num = Mathf.Tan(MathF.PI / 180f * horizontalFov / 2f);
			float num2 = Mathf.Tan(MathF.PI / 180f * verticalFov / 2f);
			return CalculateFrustumPlanesAspectRatio(verticalFov, num / num2, zNear, zFar, pos, rot);
		}

		public static float VerticalToHorizontalFov(float fov, float aspect)
		{
			float num = fov * (MathF.PI / 180f);
			float num2 = 2f * Mathf.Atan(Mathf.Tan(num / 2f) * aspect);
			return 57.29578f * num2;
		}

		public static bool Intersect2DRayAABB(Vector2 min, Vector2 max, Ray2D ray)
		{
			Vector2 direction = ray.direction;
			Vector2 origin = ray.origin;
			float num = float.NegativeInfinity;
			float num2 = float.PositiveInfinity;
			for (int i = 0; i < 2; i++)
			{
				float num3 = direction[i];
				float num4 = origin[i];
				if (num3 != 0f)
				{
					float a = (min[i] - num4) / num3;
					float b = (max[i] - num4) / num3;
					float b2 = Mathf.Min(a, b);
					float b3 = Mathf.Max(a, b);
					num = Mathf.Max(num, b2);
					num2 = Mathf.Min(num2, b3);
					if (num2 < num)
					{
						return false;
					}
				}
				else if (num4 < min[i] || num4 > max[i])
				{
					return false;
				}
			}
			return num2 >= 0f;
		}

		public static bool ContainsBoundsWithinVertex(VertexAngle2D vertex, Bounds worldspaceBounds)
		{
			Vector2 point = To2D(worldspaceBounds.min);
			Vector2 point2 = To2D(worldspaceBounds.max);
			if (!ContainsPointWithinVertex(vertex, point) && !ContainsPointWithinVertex(vertex, point2) && !ContainsPointWithinVertex(vertex, new Vector2(point.x, point2.y)))
			{
				return ContainsPointWithinVertex(vertex, new Vector2(point2.x, point.y));
			}
			return true;
		}

		public static bool ContainsPointWithinVertex(VertexAngle2D vertex, Vector2 point)
		{
			Vector2 b = point - vertex.Origin;
			float num = Cross(vertex.Left, b);
			float num2 = Cross(vertex.Right, b);
			if (num >= 0f)
			{
				return num2 <= 0f;
			}
			return false;
			static float Cross(Vector2 a, Vector2 vector)
			{
				return a.x * vector.y - a.y * vector.x;
			}
		}

		public static Vector3 To3D(Vector2 v2, float height)
		{
			return new Vector3(v2.x, height, v2.y);
		}

		public static Vector2 To2D(Vector3 v3)
		{
			return new Vector2(v3.x, v3.z);
		}

		public static bool TryGetCommon(VertexAngle2D a, VertexAngle2D b, out VertexAngle2D result)
		{
			if (!Ordered(a.Left, a.Right))
			{
				ref Vector2 right = ref a.Right;
				ref Vector2 left = ref a.Left;
				Vector2 left2 = a.Left;
				Vector2 right2 = a.Right;
				right = left2;
				left = right2;
			}
			if (!Ordered(b.Left, b.Right))
			{
				ref Vector2 right = ref b.Right;
				ref Vector2 left3 = ref b.Left;
				Vector2 right2 = b.Left;
				Vector2 left2 = b.Right;
				right = right2;
				left3 = left2;
			}
			Vector2 vector = (Ordered(a.Left, b.Left) ? b.Left : a.Left);
			Vector2 vector2 = (Ordered(a.Right, b.Right) ? a.Right : b.Right);
			if (Ordered(vector, vector2))
			{
				result = new VertexAngle2D(a.Origin, vector, vector2);
				return true;
			}
			result = default;
			return false;
			static bool Ordered(Vector2 vector3, Vector2 vector4)
			{
				return vector3.x * vector4.y - vector3.y * vector4.x >= 0f;
			}
		}

		public static bool GetSafeForDeactivation(GameObject go)
		{
			go.GetComponentsInChildren(includeInactive: true, ComponentFetcherNonAlloc);
			bool flag = false;
			foreach (Component item in ComponentFetcherNonAlloc)
			{
				if (item is NetworkIdentity || item is AudioSource || item is Collider || item is SpawnablesDistributorBase || item is Animator)
				{
					return false;
				}
				if (item is Renderer)
				{
					flag = true;
				}
			}
			if (!flag)
			{
				return false;
			}
			go.GetComponentsInParent(includeInactive: true, ComponentFetcherNonAlloc);
			foreach (Component item2 in ComponentFetcherNonAlloc)
			{
				if (item2 is Clutter || item2 is BreakableWindow)
				{
					return false;
				}
			}
			return true;
		}
	}
}

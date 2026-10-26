using System;
using System.Collections.Generic;
using NorthwoodLib.Pools;
using UnityEngine;

namespace Utils
{
	public readonly struct RelativeBounds : IEquatable<RelativeBounds>
	{
		public readonly Bounds Bounds;

		public readonly Quaternion Rotation;

		public Vector3 Origin => Bounds.center;

		public Vector3 Extends => Bounds.extents;

		public RelativeBounds(Vector3 origin, Vector3 extends, Quaternion rotation)
		{
			Bounds = new Bounds(origin, extends);
			Rotation = rotation;
		}

		public Vector3 WorldToLocal(Vector3 world)
		{
			Vector3 rhs = Rotation * Vector3.right;
			Vector3 rhs2 = Rotation * Vector3.up;
			Vector3 rhs3 = Rotation * Vector3.forward;
			Vector3 lhs = world - Origin;
			float x = Vector3.Dot(lhs, rhs);
			float y = Vector3.Dot(lhs, rhs2);
			float z = Vector3.Dot(lhs, rhs3);
			return new Vector3(x, y, z);
		}

		public Vector3 LocalToWorld(Vector3 local)
		{
			return Origin + Rotation * local;
		}

		public bool Contains(Vector3 position)
		{
			Vector3 vector = WorldToLocal(position);
			if (Mathf.Abs(vector.x) < Extends.x && Mathf.Abs(vector.y) < Extends.y)
			{
				return Mathf.Abs(vector.z) < Extends.z;
			}
			return false;
		}

		public IEnumerable<Vector3> GetWireframePoints()
		{
			List<Vector3> points = ListPool<Vector3>.Shared.Rent();
			points.Add(Origin + new Vector3(0f - Extends.x, 0f - Extends.y, 0f - Extends.z));
			points.Add(Origin + new Vector3(Extends.x, 0f - Extends.y, 0f - Extends.z));
			points.Add(Origin + new Vector3(Extends.x, 0f - Extends.y, Extends.z));
			points.Add(Origin + new Vector3(0f - Extends.x, 0f - Extends.y, Extends.z));
			points.Add(points[0]);
			points.Add(Origin + new Vector3(0f - Extends.x, Extends.y, 0f - Extends.z));
			points.Add(Origin + new Vector3(Extends.x, Extends.y, 0f - Extends.z));
			points.Add(Origin + new Vector3(Extends.x, Extends.y, Extends.z));
			points.Add(Origin + new Vector3(0f - Extends.x, Extends.y, Extends.z));
			points.Add(points[5]);
			foreach (Vector3 item in points)
			{
				yield return WorldToLocal(item);
			}
			for (int i = 0; i < 4; i++)
			{
				yield return WorldToLocal(points[i]);
				yield return WorldToLocal(points[i + 5]);
			}
			ListPool<Vector3>.Shared.Return(points);
		}

		public override bool Equals(object obj)
		{
			if (obj is RelativeBounds other)
			{
				return Equals(other);
			}
			return false;
		}

		public bool Equals(RelativeBounds other)
		{
			if (Origin.Equals(other.Origin) && Extends.Equals(other.Extends))
			{
				return Rotation.Equals(other.Rotation);
			}
			return false;
		}

		public override int GetHashCode()
		{
			return HashCode.Combine(Origin, Extends, Rotation);
		}

		public static bool operator ==(RelativeBounds left, RelativeBounds right)
		{
			return left.Equals(right);
		}

		public static bool operator !=(RelativeBounds left, RelativeBounds right)
		{
			return !(left == right);
		}

		public static explicit operator Bounds(RelativeBounds left)
		{
			return new Bounds(left.Origin, left.Extends);
		}
	}
}

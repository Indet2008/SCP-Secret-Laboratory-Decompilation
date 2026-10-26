namespace Mirror
{
	public struct MinMaxBounds : global::System.IEquatable<global::UnityEngine.Bounds>
	{
		public global::UnityEngine.Vector3 min;

		public global::UnityEngine.Vector3 max;

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public void Encapsulate(global::UnityEngine.Vector3 point)
		{
			min = global::UnityEngine.Vector3.Min(min, point);
			max = global::UnityEngine.Vector3.Max(max, point);
		}

		public void Encapsulate(global::Mirror.MinMaxBounds bounds)
		{
			Encapsulate(bounds.min);
			Encapsulate(bounds.max);
		}

		public static bool operator ==(global::Mirror.MinMaxBounds lhs, global::UnityEngine.Bounds rhs)
		{
			if (lhs.min == rhs.min)
			{
				return lhs.max == rhs.max;
			}
			return false;
		}

		public static bool operator !=(global::Mirror.MinMaxBounds lhs, global::UnityEngine.Bounds rhs)
		{
			return !(lhs == rhs);
		}

		public override bool Equals(object obj)
		{
			if (obj is global::Mirror.MinMaxBounds minMaxBounds && min == minMaxBounds.min)
			{
				return max == minMaxBounds.max;
			}
			return false;
		}

		public bool Equals(global::Mirror.MinMaxBounds other)
		{
			if (min.Equals(other.min))
			{
				return max.Equals(other.max);
			}
			return false;
		}

		public bool Equals(global::UnityEngine.Bounds other)
		{
			if (min.Equals(other.min))
			{
				return max.Equals(other.max);
			}
			return false;
		}

		public override int GetHashCode()
		{
			return global::System.HashCode.Combine(min, max);
		}

		public override string ToString()
		{
			return $"({min}, {max})";
		}
	}
}

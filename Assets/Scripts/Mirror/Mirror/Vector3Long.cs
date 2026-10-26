namespace Mirror
{
	public struct Vector3Long
	{
		public long x;

		public long y;

		public long z;

		public static readonly global::Mirror.Vector3Long zero = new global::Mirror.Vector3Long(0L, 0L, 0L);

		public static readonly global::Mirror.Vector3Long one = new global::Mirror.Vector3Long(1L, 1L, 1L);

		public static readonly global::Mirror.Vector3Long forward = new global::Mirror.Vector3Long(0L, 0L, 1L);

		public static readonly global::Mirror.Vector3Long back = new global::Mirror.Vector3Long(0L, 0L, -1L);

		public static readonly global::Mirror.Vector3Long left = new global::Mirror.Vector3Long(-1L, 0L, 0L);

		public static readonly global::Mirror.Vector3Long right = new global::Mirror.Vector3Long(1L, 0L, 0L);

		public static readonly global::Mirror.Vector3Long up = new global::Mirror.Vector3Long(0L, 1L, 0L);

		public static readonly global::Mirror.Vector3Long down = new global::Mirror.Vector3Long(0L, -1L, 0L);

		public long this[int index]
		{
			[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
			get
			{
				return index switch
				{
					0 => x, 
					1 => y, 
					2 => z, 
					_ => throw new global::System.IndexOutOfRangeException($"Vector3Long[{index}] out of range."), 
				};
			}
			[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
			set
			{
				switch (index)
				{
				case 0:
					x = value;
					break;
				case 1:
					y = value;
					break;
				case 2:
					z = value;
					break;
				default:
					throw new global::System.IndexOutOfRangeException($"Vector3Long[{index}] out of range.");
				}
			}
		}

		public Vector3Long(long x, long y, long z)
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static global::Mirror.Vector3Long operator +(global::Mirror.Vector3Long a, global::Mirror.Vector3Long b)
		{
			return new global::Mirror.Vector3Long(a.x + b.x, a.y + b.y, a.z + b.z);
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static global::Mirror.Vector3Long operator -(global::Mirror.Vector3Long a, global::Mirror.Vector3Long b)
		{
			return new global::Mirror.Vector3Long(a.x - b.x, a.y - b.y, a.z - b.z);
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static global::Mirror.Vector3Long operator -(global::Mirror.Vector3Long v)
		{
			return new global::Mirror.Vector3Long(-v.x, -v.y, -v.z);
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static global::Mirror.Vector3Long operator *(global::Mirror.Vector3Long a, long n)
		{
			return new global::Mirror.Vector3Long(a.x * n, a.y * n, a.z * n);
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static global::Mirror.Vector3Long operator *(long n, global::Mirror.Vector3Long a)
		{
			return new global::Mirror.Vector3Long(a.x * n, a.y * n, a.z * n);
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static bool operator ==(global::Mirror.Vector3Long a, global::Mirror.Vector3Long b)
		{
			if (a.x == b.x && a.y == b.y)
			{
				return a.z == b.z;
			}
			return false;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static bool operator !=(global::Mirror.Vector3Long a, global::Mirror.Vector3Long b)
		{
			return !(a == b);
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public override string ToString()
		{
			return $"({x} {y} {z})";
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public bool Equals(global::Mirror.Vector3Long other)
		{
			if (x == other.x && y == other.y)
			{
				return z == other.z;
			}
			return false;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public override bool Equals(object other)
		{
			if (other is global::Mirror.Vector3Long other2)
			{
				return Equals(other2);
			}
			return false;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public override int GetHashCode()
		{
			return global::System.HashCode.Combine(x, y, z);
		}
	}
}

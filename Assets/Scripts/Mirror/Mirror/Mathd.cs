namespace Mirror
{
	public static class Mathd
	{
		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static double Clamp(double value, double min, double max)
		{
			if (value < min)
			{
				return min;
			}
			if (value > max)
			{
				return max;
			}
			return value;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static double Clamp01(double value)
		{
			return Clamp(value, 0.0, 1.0);
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static double InverseLerp(double a, double b, double value)
		{
			if (a == b)
			{
				return 0.0;
			}
			return Clamp01((value - a) / (b - a));
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static double LerpUnclamped(double a, double b, double t)
		{
			return a + (b - a) * t;
		}
	}
}

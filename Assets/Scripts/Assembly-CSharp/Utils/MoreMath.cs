namespace Utils
{
	public static class MoreMath
	{
		public static double Lerp(double a, double b, double t)
		{
			return a + (b - a) * t;
		}

		public static double InverseLerp(double a, double b, double value)
		{
			return (value - a) / (b - a);
		}

		public static double BezierQuadratic(double a, double b, double c, double t)
		{
			double num = 1.0 - t;
			double num2 = t * t;
			double num3 = num * t;
			return num * num * a + 2.0 * num3 * b + num2 * c;
		}
	}
}

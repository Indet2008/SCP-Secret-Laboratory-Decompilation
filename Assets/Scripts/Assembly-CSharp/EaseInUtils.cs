using System;

public static class EaseInUtils
{
	public static float EaseInOutCubic(float t)
	{
		if (t < 0.5f)
		{
			float num = t * t * t;
			return 4f * num;
		}
		float num2 = -2f * t + 2f;
		float num3 = num2 * num2 * num2;
		return 1f - num3 / 2f;
	}

	public static float ChoppyLoading(double t, double chunkSize = 0.1)
	{
		return (float)(Math.Round(t * t * (3.0 - 2.0 * t) / chunkSize) * chunkSize);
	}
}

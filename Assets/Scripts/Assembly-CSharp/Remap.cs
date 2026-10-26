using UnityEngine;

public class Remap
{
	private readonly float _inMin;

	private readonly float _inMax;

	private readonly float _outMin;

	private readonly float _outMax;

	private readonly bool _clamped;

	public float Get(float f)
	{
		return Evaluate(_inMin, _inMax, _outMin, _outMax, f, _clamped);
	}

	public Remap(float inMin, float inMax, float outMin, float outMax, bool clamped = true)
	{
		_inMin = inMin;
		_inMax = inMax;
		_outMin = outMin;
		_outMax = outMax;
		_clamped = clamped;
	}

	public static float Evaluate(float inMin, float inMax, float outMin, float outMax, float inValue, bool clamped = true)
	{
		float num = ((inMin != inMax) ? ((inValue - inMin) / (inMax - inMin)) : 0f);
		float num2 = outMin + (outMax - outMin) * num;
		if (!clamped)
		{
			return num2;
		}
		float min;
		float max;
		if (outMin < outMax)
		{
			min = outMin;
			max = outMax;
		}
		else
		{
			min = outMax;
			max = outMin;
		}
		return Mathf.Clamp(num2, min, max);
	}
}

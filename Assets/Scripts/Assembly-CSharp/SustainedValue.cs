using System.Diagnostics;

public class SustainedValue
{
	private float _peak;

	private readonly float _susTime;

	private readonly bool _inverse;

	private readonly bool _abs;

	private readonly Stopwatch _lastUpdateSw;

	public float Value
	{
		get
		{
			return _peak;
		}
		set
		{
			float num = ConditionalAbs(value);
			float num2 = ConditionalAbs(_peak);
			bool flag = _susTime > 0f;
			if ((_inverse && num <= num2) || (!_inverse && num >= num2))
			{
				_peak = value;
				if (flag)
				{
					_lastUpdateSw.Restart();
				}
			}
			else if (flag && _lastUpdateSw.Elapsed.TotalSeconds >= (double)_susTime)
			{
				_peak = value;
			}
		}
	}

	public SustainedValue(float initialValue, float sustainTime, bool inverse, bool absolute)
	{
		_peak = initialValue;
		_susTime = sustainTime;
		_inverse = inverse;
		_abs = absolute;
		if (sustainTime > 0f)
		{
			_lastUpdateSw = Stopwatch.StartNew();
		}
	}

	private float ConditionalAbs(float val)
	{
		if (!_abs || !(val < 0f))
		{
			return val;
		}
		return 0f - val;
	}
}

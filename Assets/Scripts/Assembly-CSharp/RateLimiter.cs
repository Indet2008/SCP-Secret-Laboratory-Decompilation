using System.Collections.Generic;
using System.Diagnostics;

public class RateLimiter
{
	private readonly float _instantCooldown;

	private readonly float _windowCooldown;

	private readonly Queue<Stopwatch> _inputs;

	private readonly Stopwatch _instInput;

	private readonly int _windowLength;

	private readonly bool _useWindowLimiter;

	public bool InstantReady
	{
		get
		{
			if (_instantCooldown != 0f && _instInput.IsRunning)
			{
				return _instInput.Elapsed.TotalSeconds >= (double)_instantCooldown;
			}
			return true;
		}
	}

	public bool RateReady
	{
		get
		{
			if (!_useWindowLimiter)
			{
				return true;
			}
			int num = _inputs.Count;
			if (num < _windowLength)
			{
				return true;
			}
			while (num > 0 && _inputs.Peek().Elapsed.TotalSeconds >= (double)_windowCooldown)
			{
				num--;
				_inputs.Dequeue();
			}
			return num < _windowLength;
		}
	}

	public bool AllReady
	{
		get
		{
			if (InstantReady)
			{
				return RateReady;
			}
			return false;
		}
	}

	public RateLimiter(float instantCooldown, int maxInputs, float timeWindow)
	{
		_instantCooldown = instantCooldown;
		_windowCooldown = timeWindow;
		_windowLength = maxInputs;
		_inputs = new Queue<Stopwatch>();
		_instInput = new Stopwatch();
		_useWindowLimiter = true;
	}

	public RateLimiter(float instantCooldown)
	{
		_instantCooldown = instantCooldown;
		_instInput = new Stopwatch();
		_useWindowLimiter = false;
	}

	public void RegisterInput()
	{
		_instInput.Restart();
		if (_useWindowLimiter)
		{
			_inputs.Enqueue(Stopwatch.StartNew());
		}
	}
}

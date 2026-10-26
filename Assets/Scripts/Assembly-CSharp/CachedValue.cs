using System;

public class CachedValue<T>
{
	private bool _cacheSet;

	private T _cachedValue;

	private readonly Func<T> _factory;

	private readonly Func<bool> _updateChecker;

	private readonly bool _usesChecker;

	public T Value
	{
		get
		{
			if (IsDirty || (_usesChecker && _updateChecker()))
			{
				RefreshValue();
			}
			return _cachedValue;
		}
	}

	public bool IsDirty => !_cacheSet;

	public CachedValue(Func<T> factory)
	{
		_factory = factory;
		_usesChecker = false;
		_updateChecker = null;
	}

	public CachedValue(Func<T> factory, Func<bool> checker)
	{
		_factory = factory;
		_usesChecker = true;
		_updateChecker = checker;
	}

	public void RefreshValue()
	{
		_cacheSet = true;
		_cachedValue = _factory();
	}

	public void SetDirty()
	{
		_cacheSet = false;
	}
}

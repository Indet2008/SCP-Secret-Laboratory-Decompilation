using System;

public abstract class HttpCoroutine : IDisposable
{
	public abstract void CheckResult();

	public abstract string GetText();

	public abstract byte[] GetBytes();

	public abstract ReadOnlySpan<byte> GetSpan();

	public abstract float Wait();

	public abstract void Dispose();
}

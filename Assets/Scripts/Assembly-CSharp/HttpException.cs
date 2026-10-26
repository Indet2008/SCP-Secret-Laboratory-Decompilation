using System;

public abstract class HttpException : Exception
{
	protected HttpException(string message)
		: base(message)
	{
		HttpQuery.InvokeExceptionHandler(this);
	}

	protected HttpException(string message, Exception innerException)
		: base(message, innerException)
	{
		HttpQuery.InvokeExceptionHandler(this);
	}
}

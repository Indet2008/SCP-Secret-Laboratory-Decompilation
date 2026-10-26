using System;

public class DotnetHttpException : HttpException
{
	public DotnetHttpException(Exception innerException)
		: base(innerException.Message, innerException)
	{
		HttpQuery.InvokeExceptionHandler(this);
	}
}

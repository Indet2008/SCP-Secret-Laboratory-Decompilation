public sealed class NativeHttpException : HttpException
{
	public int Code { get; }

	public NativeHttpException(int code, string message)
		: base(message)
	{
		Code = code;
	}
}

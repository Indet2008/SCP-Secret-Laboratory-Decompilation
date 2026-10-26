public sealed class NativeHttpException : HttpException
{
	public int Code
	{
		[global::System.Runtime.CompilerServices.CompilerGenerated]
		get
		{
			return default;
		}
	}

	public NativeHttpException(int code, string message)
		: base(message)
	{
	}
}

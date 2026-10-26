namespace Utils.Http.SDR
{
	public sealed class SDRHttpException : HttpException
	{
		public int Code { get; }

		public SDRHttpException(int code, string message)
			: base(message)
		{
			Code = code;
			HttpQuery.InvokeExceptionHandler(this);
		}
	}
}

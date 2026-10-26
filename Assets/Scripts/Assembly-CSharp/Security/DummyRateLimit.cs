namespace Security
{
	public class DummyRateLimit : RateLimit
	{
		public DummyRateLimit()
			: base(0, 0f)
		{
		}
	}
}

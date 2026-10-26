namespace Query
{
	public static class QueryClientFlagUtils
	{
		public static bool HasFlagFast(this QueryHandshake.ClientFlags res, QueryHandshake.ClientFlags flag)
		{
			return (res & flag) == flag;
		}
	}
}

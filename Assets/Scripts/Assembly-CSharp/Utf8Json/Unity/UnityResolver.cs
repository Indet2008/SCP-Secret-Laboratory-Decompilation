namespace Utf8Json.Unity
{
	public class UnityResolver : IJsonFormatterResolver
	{
		private static class FormatterCache<T>
		{
			public static readonly IJsonFormatter<T> formatter;

			static FormatterCache()
			{
				object obj = UnityResolverGetFormatterHelper.GetFormatter(typeof(T));
				if (obj != null)
				{
					formatter = (IJsonFormatter<T>)obj;
				}
			}
		}

		public static readonly IJsonFormatterResolver Instance = new UnityResolver();

		private UnityResolver()
		{
		}

		public IJsonFormatter<T> GetFormatter<T>()
		{
			return FormatterCache<T>.formatter;
		}
	}
}

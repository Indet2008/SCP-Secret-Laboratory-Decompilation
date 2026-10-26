namespace Utf8Json.Resolvers
{
	public class GeneratedResolver : IJsonFormatterResolver
	{
		private static class FormatterCache<T>
		{
			public static readonly IJsonFormatter<T> formatter;

			static FormatterCache()
			{
				object obj = GeneratedResolverGetFormatterHelper.GetFormatter(typeof(T));
				if (obj != null)
				{
					formatter = (IJsonFormatter<T>)obj;
				}
			}
		}

		public static readonly IJsonFormatterResolver Instance = new GeneratedResolver();

		private GeneratedResolver()
		{
		}

		public IJsonFormatter<T> GetFormatter<T>()
		{
			return FormatterCache<T>.formatter;
		}
	}
}

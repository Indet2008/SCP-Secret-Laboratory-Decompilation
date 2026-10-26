using Utf8Json.Resolvers.Internal;

namespace Utf8Json.Resolvers
{
	public sealed class DynamicGenericResolver : IJsonFormatterResolver
	{
		private static class FormatterCache<T>
		{
			public static readonly IJsonFormatter<T> formatter;

			static FormatterCache()
			{
				formatter = (IJsonFormatter<T>)DynamicGenericResolverGetFormatterHelper.GetFormatter(typeof(T));
			}
		}

		public static readonly IJsonFormatterResolver Instance = new DynamicGenericResolver();

		private DynamicGenericResolver()
		{
		}

		public IJsonFormatter<T> GetFormatter<T>()
		{
			return FormatterCache<T>.formatter;
		}
	}
}

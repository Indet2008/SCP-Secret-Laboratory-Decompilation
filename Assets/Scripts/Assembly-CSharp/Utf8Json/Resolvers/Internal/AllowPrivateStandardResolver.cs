using System.Linq;
using Utf8Json.Formatters;

namespace Utf8Json.Resolvers.Internal
{
	internal sealed class AllowPrivateStandardResolver : IJsonFormatterResolver
	{
		private static class FormatterCache<T>
		{
			public static readonly IJsonFormatter<T> formatter;

			static FormatterCache()
			{
				if (typeof(T) == typeof(object))
				{
					formatter = (IJsonFormatter<T>)fallbackFormatter;
				}
				else
				{
					formatter = InnerResolver.Instance.GetFormatter<T>();
				}
			}
		}

		private sealed class InnerResolver : IJsonFormatterResolver
		{
			private static class FormatterCache<T>
			{
				public static readonly IJsonFormatter<T> formatter;

				static FormatterCache()
				{
					IJsonFormatterResolver[] resolvers = InnerResolver.resolvers;
					for (int i = 0; i < resolvers.Length; i++)
					{
						IJsonFormatter<T> jsonFormatter = resolvers[i].GetFormatter<T>();
						if (jsonFormatter != null)
						{
							formatter = jsonFormatter;
							break;
						}
					}
				}
			}

			public static readonly IJsonFormatterResolver Instance = new InnerResolver();

			private static readonly IJsonFormatterResolver[] resolvers = StandardResolverHelper.CompositeResolverBase.Concat(new IJsonFormatterResolver[1] { DynamicObjectResolver.AllowPrivate }).ToArray();

			private InnerResolver()
			{
			}

			public IJsonFormatter<T> GetFormatter<T>()
			{
				return FormatterCache<T>.formatter;
			}
		}

		public static readonly IJsonFormatterResolver Instance = new AllowPrivateStandardResolver();

		private static readonly IJsonFormatter<object> fallbackFormatter = new DynamicObjectTypeFallbackFormatter(InnerResolver.Instance);

		private AllowPrivateStandardResolver()
		{
		}

		public IJsonFormatter<T> GetFormatter<T>()
		{
			return FormatterCache<T>.formatter;
		}
	}
}

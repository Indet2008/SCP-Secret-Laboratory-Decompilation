using System;
using System.Reflection;

namespace Utf8Json.Resolvers
{
	public sealed class AttributeFormatterResolver : IJsonFormatterResolver
	{
		private static class FormatterCache<T>
		{
			public static readonly IJsonFormatter<T> formatter;

			static FormatterCache()
			{
				JsonFormatterAttribute customAttribute = typeof(T).GetTypeInfo().GetCustomAttribute<JsonFormatterAttribute>();
				if (customAttribute == null)
				{
					return;
				}
				try
				{
					if (customAttribute.FormatterType.IsGenericType && !customAttribute.FormatterType.GetTypeInfo().IsConstructedGenericType())
					{
						formatter = (IJsonFormatter<T>)Activator.CreateInstance(customAttribute.FormatterType.MakeGenericType(typeof(T)), customAttribute.Arguments);
					}
					else
					{
						formatter = (IJsonFormatter<T>)Activator.CreateInstance(customAttribute.FormatterType, customAttribute.Arguments);
					}
				}
				catch (Exception innerException)
				{
					throw new InvalidOperationException("Can not create formatter from JsonFormatterAttribute, check the target formatter is public and has constructor with right argument. FormatterType:" + customAttribute.FormatterType.Name, innerException);
				}
			}
		}

		public static IJsonFormatterResolver Instance = new AttributeFormatterResolver();

		private AttributeFormatterResolver()
		{
		}

		public IJsonFormatter<T> GetFormatter<T>()
		{
			return FormatterCache<T>.formatter;
		}
	}
}

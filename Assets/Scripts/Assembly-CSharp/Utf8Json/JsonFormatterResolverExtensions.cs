using System;
using System.Reflection;

namespace Utf8Json
{
	public static class JsonFormatterResolverExtensions
	{
		public static IJsonFormatter<T> GetFormatterWithVerify<T>(this IJsonFormatterResolver resolver)
		{
			IJsonFormatter<T> formatter;
			try
			{
				formatter = resolver.GetFormatter<T>();
			}
			catch (TypeInitializationException innerException)
			{
				while (innerException.InnerException != null)
				{
					innerException = (TypeInitializationException)innerException.InnerException;
				}
				throw innerException;
			}
			if (formatter == null)
			{
				throw new FormatterNotRegisteredException(typeof(T).FullName + " is not registered in this resolver. resolver:" + resolver.GetType().Name);
			}
			return formatter;
		}

		public static object GetFormatterDynamic(this IJsonFormatterResolver resolver, Type type)
		{
			return typeof(IJsonFormatterResolver).GetRuntimeMethod("GetFormatter", Type.EmptyTypes).MakeGenericMethod(type).Invoke(resolver, null);
		}

		public static void DeserializeToWithFallbackReplace<T>(this IJsonFormatterResolver formatterResolver, ref T value, ref JsonReader reader)
		{
			IJsonFormatter<T> formatterWithVerify = formatterResolver.GetFormatterWithVerify<T>();
			if (formatterWithVerify is IOverwriteJsonFormatter<T> overwriteJsonFormatter)
			{
				overwriteJsonFormatter.DeserializeTo(ref value, ref reader, formatterResolver);
			}
			else
			{
				value = formatterWithVerify.Deserialize(ref reader, formatterResolver);
			}
		}
	}
}

namespace Utf8Json.Resolvers.Internal
{
	internal delegate T AnonymousJsonDeserializeFunc<T>(object[] customFormatters, ref JsonReader reader, IJsonFormatterResolver resolver);
}

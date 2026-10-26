namespace Utf8Json.Resolvers.Internal
{
	internal delegate void AnonymousJsonSerializeAction<T>(byte[][] stringByteKeysField, object[] customFormatters, ref JsonWriter writer, T value, IJsonFormatterResolver resolver);
}

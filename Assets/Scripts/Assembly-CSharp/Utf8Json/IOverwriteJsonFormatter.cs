namespace Utf8Json
{
	public interface IOverwriteJsonFormatter<T> : IJsonFormatter<T>, IJsonFormatter
	{
		void DeserializeTo(ref T value, ref JsonReader reader, IJsonFormatterResolver formatterResolver);
	}
}

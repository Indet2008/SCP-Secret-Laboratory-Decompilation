namespace Utf8Json
{
	public interface IJsonFormatterResolver
	{
		IJsonFormatter<T> GetFormatter<T>();
	}
}

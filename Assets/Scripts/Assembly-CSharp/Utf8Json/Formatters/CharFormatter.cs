using System.Globalization;

namespace Utf8Json.Formatters
{
	public sealed class CharFormatter : IJsonFormatter<char>, IJsonFormatter
	{
		public static readonly CharFormatter Default = new CharFormatter();

		public void Serialize(ref JsonWriter writer, char value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteString(value.ToString(CultureInfo.InvariantCulture));
		}

		public char Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			return reader.ReadString()[0];
		}
	}
}

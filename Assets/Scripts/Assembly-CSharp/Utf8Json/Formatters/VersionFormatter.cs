using System;

namespace Utf8Json.Formatters
{
	public sealed class VersionFormatter : IJsonFormatter<Version>, IJsonFormatter
	{
		public static readonly IJsonFormatter<Version> Default = new VersionFormatter();

		public void Serialize(ref JsonWriter writer, Version value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
			}
			else
			{
				writer.WriteString(value.ToString());
			}
		}

		public Version Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			return new Version(reader.ReadString());
		}
	}
}

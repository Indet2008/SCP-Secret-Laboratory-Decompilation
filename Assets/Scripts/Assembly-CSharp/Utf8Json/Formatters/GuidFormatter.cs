using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class GuidFormatter : IJsonFormatter<Guid>, IJsonFormatter, IObjectPropertyNameFormatter<Guid>
	{
		public static readonly IJsonFormatter<Guid> Default = new GuidFormatter();

		public void Serialize(ref JsonWriter writer, Guid value, IJsonFormatterResolver formatterResolver)
		{
			writer.EnsureCapacity(38);
			writer.WriteRawUnsafe(34);
			ArraySegment<byte> buffer = writer.GetBuffer();
			new GuidBits(ref value).Write(buffer.Array, writer.CurrentOffset);
			writer.AdvanceOffset(36);
			writer.WriteRawUnsafe(34);
		}

		public Guid Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			ArraySegment<byte> utf8string = reader.ReadStringSegmentUnsafe();
			return new GuidBits(ref utf8string).Value;
		}

		public void SerializeToPropertyName(ref JsonWriter writer, Guid value, IJsonFormatterResolver formatterResolver)
		{
			Serialize(ref writer, value, formatterResolver);
		}

		public Guid DeserializeFromPropertyName(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			return Deserialize(ref reader, formatterResolver);
		}
	}
}

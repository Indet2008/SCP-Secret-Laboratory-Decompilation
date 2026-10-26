using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class ServerListFormatter : IJsonFormatter<ServerList>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public ServerListFormatter()
		{
			____keyMapping = new AutomataDictionary { 
			{
				JsonWriter.GetEncodedPropertyNameWithoutQuotation("servers"),
				0
			} };
			____stringByteKeys = new byte[1][] { JsonWriter.GetEncodedPropertyNameWithBeginObject("servers") };
		}

		public void Serialize(ref JsonWriter writer, ServerList value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			formatterResolver.GetFormatterWithVerify<ServerListItem[]>().Serialize(ref writer, value.servers, formatterResolver);
			writer.WriteEndObject();
		}

		public ServerList Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			ServerListItem[] servers = null;
			int count = 0;
			reader.ReadIsBeginObjectWithVerify();
			while (!reader.ReadIsEndObjectWithSkipValueSeparator(ref count))
			{
				ArraySegment<byte> key = reader.ReadPropertyNameSegmentRaw();
				if (!____keyMapping.TryGetValueSafe(key, out var value))
				{
					reader.ReadNextBlock();
				}
				else if (value == 0)
				{
					servers = formatterResolver.GetFormatterWithVerify<ServerListItem[]>().Deserialize(ref reader, formatterResolver);
				}
				else
				{
					reader.ReadNextBlock();
				}
			}
			return new ServerList(servers);
		}
	}
}

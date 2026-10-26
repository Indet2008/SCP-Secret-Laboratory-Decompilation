using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class DiscordWebhookFormatter : IJsonFormatter<DiscordWebhook>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public DiscordWebhookFormatter()
		{
			____keyMapping = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("content"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("username"),
					1
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("avatar_url"),
					2
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("tts"),
					3
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("embeds"),
					4
				}
			};
			____stringByteKeys = new byte[5][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("content"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("username"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("avatar_url"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("tts"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("embeds")
			};
		}

		public void Serialize(ref JsonWriter writer, DiscordWebhook value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteString(value.content);
			writer.WriteRaw(____stringByteKeys[1]);
			writer.WriteString(value.username);
			writer.WriteRaw(____stringByteKeys[2]);
			writer.WriteString(value.avatar_url);
			writer.WriteRaw(____stringByteKeys[3]);
			writer.WriteBoolean(value.tts);
			writer.WriteRaw(____stringByteKeys[4]);
			formatterResolver.GetFormatterWithVerify<DiscordEmbed[]>().Serialize(ref writer, value.embeds, formatterResolver);
			writer.WriteEndObject();
		}

		public DiscordWebhook Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			string content = null;
			string username = null;
			string avatar_url = null;
			bool tts = false;
			DiscordEmbed[] embeds = null;
			int count = 0;
			reader.ReadIsBeginObjectWithVerify();
			while (!reader.ReadIsEndObjectWithSkipValueSeparator(ref count))
			{
				ArraySegment<byte> key = reader.ReadPropertyNameSegmentRaw();
				if (!____keyMapping.TryGetValueSafe(key, out var value))
				{
					reader.ReadNextBlock();
					continue;
				}
				switch (value)
				{
				case 0:
					content = reader.ReadString();
					break;
				case 1:
					username = reader.ReadString();
					break;
				case 2:
					avatar_url = reader.ReadString();
					break;
				case 3:
					tts = reader.ReadBoolean();
					break;
				case 4:
					embeds = formatterResolver.GetFormatterWithVerify<DiscordEmbed[]>().Deserialize(ref reader, formatterResolver);
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			return new DiscordWebhook(content, username, avatar_url, tts, embeds);
		}
	}
}

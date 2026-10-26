using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class GlobalBanningResponseFormatter : IJsonFormatter<GlobalBanningResponse>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public GlobalBanningResponseFormatter()
		{
			____keyMapping = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("Success"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("Message"),
					1
				}
			};
			____stringByteKeys = new byte[2][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("Success"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("Message")
			};
		}

		public void Serialize(ref JsonWriter writer, GlobalBanningResponse value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteBoolean(value.Success);
			writer.WriteRaw(____stringByteKeys[1]);
			writer.WriteString(value.Message);
			writer.WriteEndObject();
		}

		public GlobalBanningResponse Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			bool success = false;
			string message = null;
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
					success = reader.ReadBoolean();
					break;
				case 1:
					message = reader.ReadString();
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			return new GlobalBanningResponse(success, message);
		}
	}
}

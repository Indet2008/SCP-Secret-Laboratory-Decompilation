using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class AuthenticatiorAuthRejectFormatter : IJsonFormatter<AuthenticatiorAuthReject>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public AuthenticatiorAuthRejectFormatter()
		{
			____keyMapping = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("Id"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("Reason"),
					1
				}
			};
			____stringByteKeys = new byte[2][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("Id"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("Reason")
			};
		}

		public void Serialize(ref JsonWriter writer, AuthenticatiorAuthReject value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteString(value.Id);
			writer.WriteRaw(____stringByteKeys[1]);
			writer.WriteString(value.Reason);
			writer.WriteEndObject();
		}

		public AuthenticatiorAuthReject Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			string id = null;
			string reason = null;
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
					id = reader.ReadString();
					break;
				case 1:
					reason = reader.ReadString();
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			return new AuthenticatiorAuthReject(id, reason);
		}
	}
}

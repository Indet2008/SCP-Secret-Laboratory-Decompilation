using System;
using System.Collections.Generic;
using Authenticator;
using Utf8Json.Internal;

namespace Utf8Json.Formatters.Authenticator
{
	public sealed class AuthenticatorPlayerObjectsFormatter : IJsonFormatter<AuthenticatorPlayerObjects>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public AuthenticatorPlayerObjectsFormatter()
		{
			____keyMapping = new AutomataDictionary { 
			{
				JsonWriter.GetEncodedPropertyNameWithoutQuotation("objects"),
				0
			} };
			____stringByteKeys = new byte[1][] { JsonWriter.GetEncodedPropertyNameWithBeginObject("objects") };
		}

		public void Serialize(ref JsonWriter writer, AuthenticatorPlayerObjects value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			formatterResolver.GetFormatterWithVerify<List<AuthenticatorPlayerObject>>().Serialize(ref writer, value.objects, formatterResolver);
			writer.WriteEndObject();
		}

		public AuthenticatorPlayerObjects Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			List<AuthenticatorPlayerObject> objects = null;
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
					objects = formatterResolver.GetFormatterWithVerify<List<AuthenticatorPlayerObject>>().Deserialize(ref reader, formatterResolver);
				}
				else
				{
					reader.ReadNextBlock();
				}
			}
			return new AuthenticatorPlayerObjects(objects);
		}
	}
}

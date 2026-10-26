using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class CreditsListFormatter : IJsonFormatter<CreditsList>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public CreditsListFormatter()
		{
			____keyMapping = new AutomataDictionary { 
			{
				JsonWriter.GetEncodedPropertyNameWithoutQuotation("credits"),
				0
			} };
			____stringByteKeys = new byte[1][] { JsonWriter.GetEncodedPropertyNameWithBeginObject("credits") };
		}

		public void Serialize(ref JsonWriter writer, CreditsList value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			formatterResolver.GetFormatterWithVerify<CreditsListCategory[]>().Serialize(ref writer, value.credits, formatterResolver);
			writer.WriteEndObject();
		}

		public CreditsList Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			CreditsListCategory[] credits = null;
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
					credits = formatterResolver.GetFormatterWithVerify<CreditsListCategory[]>().Deserialize(ref reader, formatterResolver);
				}
				else
				{
					reader.ReadNextBlock();
				}
			}
			return new CreditsList(credits);
		}
	}
}

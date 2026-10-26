using System;
using UnityEngine;
using Utf8Json.Internal;

namespace Utf8Json.Unity
{
	public sealed class BoundsFormatter : IJsonFormatter<Bounds>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public BoundsFormatter()
		{
			____keyMapping = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("center"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("size"),
					1
				}
			};
			____stringByteKeys = new byte[2][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("center"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("size")
			};
		}

		public void Serialize(ref JsonWriter writer, Bounds value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			formatterResolver.GetFormatterWithVerify<Vector3>().Serialize(ref writer, value.center, formatterResolver);
			writer.WriteRaw(____stringByteKeys[1]);
			formatterResolver.GetFormatterWithVerify<Vector3>().Serialize(ref writer, value.size, formatterResolver);
			writer.WriteEndObject();
		}

		public Bounds Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			Vector3 center = default;
			Vector3 size = default;
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
					center = formatterResolver.GetFormatterWithVerify<Vector3>().Deserialize(ref reader, formatterResolver);
					break;
				case 1:
					size = formatterResolver.GetFormatterWithVerify<Vector3>().Deserialize(ref reader, formatterResolver);
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			Bounds result = new Bounds(center, size);
			result.center = center;
			result.size = size;
			return result;
		}
	}
}

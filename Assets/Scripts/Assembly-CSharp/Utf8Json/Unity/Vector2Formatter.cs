using System;
using UnityEngine;
using Utf8Json.Internal;

namespace Utf8Json.Unity
{
	public sealed class Vector2Formatter : IJsonFormatter<Vector2>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public Vector2Formatter()
		{
			____keyMapping = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("x"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("y"),
					1
				}
			};
			____stringByteKeys = new byte[2][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("x"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("y")
			};
		}

		public void Serialize(ref JsonWriter writer, Vector2 value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteSingle(value.x);
			writer.WriteRaw(____stringByteKeys[1]);
			writer.WriteSingle(value.y);
			writer.WriteEndObject();
		}

		public Vector2 Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			float x = 0f;
			float y = 0f;
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
					x = reader.ReadSingle();
					break;
				case 1:
					y = reader.ReadSingle();
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			Vector2 result = new Vector2(x, y);
			result.x = x;
			result.y = y;
			return result;
		}
	}
}

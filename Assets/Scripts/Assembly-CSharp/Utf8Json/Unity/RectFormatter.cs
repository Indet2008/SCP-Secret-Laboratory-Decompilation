using System;
using UnityEngine;
using Utf8Json.Internal;

namespace Utf8Json.Unity
{
	public sealed class RectFormatter : IJsonFormatter<Rect>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public RectFormatter()
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
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("width"),
					2
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("height"),
					3
				}
			};
			____stringByteKeys = new byte[4][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("x"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("y"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("width"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("height")
			};
		}

		public void Serialize(ref JsonWriter writer, Rect value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteSingle(value.x);
			writer.WriteRaw(____stringByteKeys[1]);
			writer.WriteSingle(value.y);
			writer.WriteRaw(____stringByteKeys[2]);
			writer.WriteSingle(value.width);
			writer.WriteRaw(____stringByteKeys[3]);
			writer.WriteSingle(value.height);
			writer.WriteEndObject();
		}

		public Rect Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			float x = 0f;
			float y = 0f;
			float width = 0f;
			float height = 0f;
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
				case 2:
					width = reader.ReadSingle();
					break;
				case 3:
					height = reader.ReadSingle();
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			Rect result = new Rect(x, y, width, height);
			result.x = x;
			result.y = y;
			result.width = width;
			result.height = height;
			return result;
		}
	}
}

using System;
using UnityEngine;
using Utf8Json.Internal;

namespace Utf8Json.Unity
{
	public sealed class ColorFormatter : IJsonFormatter<Color>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public ColorFormatter()
		{
			____keyMapping = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("r"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("g"),
					1
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("b"),
					2
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("a"),
					3
				}
			};
			____stringByteKeys = new byte[4][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("r"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("g"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("b"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("a")
			};
		}

		public void Serialize(ref JsonWriter writer, Color value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteSingle(value.r);
			writer.WriteRaw(____stringByteKeys[1]);
			writer.WriteSingle(value.g);
			writer.WriteRaw(____stringByteKeys[2]);
			writer.WriteSingle(value.b);
			writer.WriteRaw(____stringByteKeys[3]);
			writer.WriteSingle(value.a);
			writer.WriteEndObject();
		}

		public Color Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			float r = 0f;
			float g = 0f;
			float b = 0f;
			float a = 0f;
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
					r = reader.ReadSingle();
					break;
				case 1:
					g = reader.ReadSingle();
					break;
				case 2:
					b = reader.ReadSingle();
					break;
				case 3:
					a = reader.ReadSingle();
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			Color result = new Color(r, g, b, a);
			result.r = r;
			result.g = g;
			result.b = b;
			result.a = a;
			return result;
		}
	}
}

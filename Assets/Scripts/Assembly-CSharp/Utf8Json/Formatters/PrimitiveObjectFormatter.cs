using System;
using System.Collections;
using System.Collections.Generic;

namespace Utf8Json.Formatters
{
	public sealed class PrimitiveObjectFormatter : IJsonFormatter<object>, IJsonFormatter
	{
		public static readonly IJsonFormatter<object> Default = new PrimitiveObjectFormatter();

		private static readonly Dictionary<Type, int> typeToJumpCode = new Dictionary<Type, int>
		{
			{
				typeof(bool),
				0
			},
			{
				typeof(char),
				1
			},
			{
				typeof(sbyte),
				2
			},
			{
				typeof(byte),
				3
			},
			{
				typeof(short),
				4
			},
			{
				typeof(ushort),
				5
			},
			{
				typeof(int),
				6
			},
			{
				typeof(uint),
				7
			},
			{
				typeof(long),
				8
			},
			{
				typeof(ulong),
				9
			},
			{
				typeof(float),
				10
			},
			{
				typeof(double),
				11
			},
			{
				typeof(DateTime),
				12
			},
			{
				typeof(string),
				13
			},
			{
				typeof(byte[]),
				14
			}
		};

		public void Serialize(ref JsonWriter writer, object value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
				return;
			}
			Type type = value.GetType();
			if (typeToJumpCode.TryGetValue(type, out var value2))
			{
				switch (value2)
				{
				case 0:
					writer.WriteBoolean((bool)value);
					return;
				case 1:
					CharFormatter.Default.Serialize(ref writer, (char)value, formatterResolver);
					return;
				case 2:
					writer.WriteSByte((sbyte)value);
					return;
				case 3:
					writer.WriteByte((byte)value);
					return;
				case 4:
					writer.WriteInt16((short)value);
					return;
				case 5:
					writer.WriteUInt16((ushort)value);
					return;
				case 6:
					writer.WriteInt32((int)value);
					return;
				case 7:
					writer.WriteUInt32((uint)value);
					return;
				case 8:
					writer.WriteInt64((long)value);
					return;
				case 9:
					writer.WriteUInt64((ulong)value);
					return;
				case 10:
					writer.WriteSingle((float)value);
					return;
				case 11:
					writer.WriteDouble((double)value);
					return;
				case 12:
					ISO8601DateTimeFormatter.Default.Serialize(ref writer, (DateTime)value, formatterResolver);
					return;
				case 13:
					writer.WriteString((string)value);
					return;
				case 14:
					ByteArrayFormatter.Default.Serialize(ref writer, (byte[])value, formatterResolver);
					return;
				}
			}
			if (type.IsEnum)
			{
				writer.WriteString(type.ToString());
				return;
			}
			if (value is IDictionary dictionary)
			{
				int num = 0;
				writer.WriteBeginObject();
				foreach (DictionaryEntry item in dictionary)
				{
					if (num != 0)
					{
						writer.WriteValueSeparator();
					}
					writer.WritePropertyName((string)item.Key);
					Serialize(ref writer, item.Value, formatterResolver);
				}
				writer.WriteEndObject();
				return;
			}
			if (value is ICollection collection)
			{
				int num2 = 0;
				writer.WriteBeginArray();
				foreach (object item2 in collection)
				{
					if (num2 != 0)
					{
						writer.WriteValueSeparator();
					}
					Serialize(ref writer, item2, formatterResolver);
				}
				writer.WriteEndArray();
				return;
			}
			throw new InvalidOperationException("Not supported primitive object resolver. type:" + type.Name);
		}

		public object Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			JsonToken currentJsonToken = reader.GetCurrentJsonToken();
			switch (currentJsonToken)
			{
			case JsonToken.BeginObject:
			{
				Dictionary<string, object> dictionary = new Dictionary<string, object>();
				reader.ReadIsBeginObjectWithVerify();
				int count2 = 0;
				while (!reader.ReadIsEndObjectWithSkipValueSeparator(ref count2))
				{
					string key = reader.ReadPropertyName();
					object value = Deserialize(ref reader, formatterResolver);
					dictionary.Add(key, value);
				}
				return dictionary;
			}
			case JsonToken.BeginArray:
			{
				List<object> list = new List<object>(4);
				reader.ReadIsBeginArrayWithVerify();
				int count = 0;
				while (!reader.ReadIsEndArrayWithSkipValueSeparator(ref count))
				{
					list.Add(Deserialize(ref reader, formatterResolver));
				}
				return list;
			}
			case JsonToken.Number:
				return reader.ReadDouble();
			case JsonToken.String:
				return reader.ReadString();
			case JsonToken.True:
				return reader.ReadBoolean();
			case JsonToken.False:
				return reader.ReadBoolean();
			case JsonToken.EndObject:
			case JsonToken.EndArray:
			case JsonToken.ValueSeparator:
			case JsonToken.NameSeparator:
				throw new InvalidOperationException("Invalid Json Token:" + currentJsonToken);
			case JsonToken.Null:
				reader.ReadIsNull();
				return null;
			default:
				return null;
			}
		}
	}
}

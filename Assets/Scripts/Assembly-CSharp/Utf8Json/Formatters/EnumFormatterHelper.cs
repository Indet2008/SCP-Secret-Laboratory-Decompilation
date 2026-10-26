using System;

namespace Utf8Json.Formatters
{
	public static class EnumFormatterHelper
	{
		public static object GetSerializeDelegate(Type type, out bool isBoxed)
		{
			Type underlyingType = Enum.GetUnderlyingType(type);
			isBoxed = true;
			if (underlyingType == typeof(byte))
			{
				return (JsonSerializeAction<object>)delegate(ref JsonWriter writer, object value, IJsonFormatterResolver _)
				{
					writer.WriteByte((byte)value);
				};
			}
			if (underlyingType == typeof(sbyte))
			{
				return (JsonSerializeAction<object>)delegate(ref JsonWriter writer, object value, IJsonFormatterResolver _)
				{
					writer.WriteSByte((sbyte)value);
				};
			}
			if (underlyingType == typeof(short))
			{
				return (JsonSerializeAction<object>)delegate(ref JsonWriter writer, object value, IJsonFormatterResolver _)
				{
					writer.WriteInt16((short)value);
				};
			}
			if (underlyingType == typeof(ushort))
			{
				return (JsonSerializeAction<object>)delegate(ref JsonWriter writer, object value, IJsonFormatterResolver _)
				{
					writer.WriteUInt16((ushort)value);
				};
			}
			if (underlyingType == typeof(int))
			{
				return (JsonSerializeAction<object>)delegate(ref JsonWriter writer, object value, IJsonFormatterResolver _)
				{
					writer.WriteInt32((int)value);
				};
			}
			if (underlyingType == typeof(uint))
			{
				return (JsonSerializeAction<object>)delegate(ref JsonWriter writer, object value, IJsonFormatterResolver _)
				{
					writer.WriteUInt32((uint)value);
				};
			}
			if (underlyingType == typeof(long))
			{
				return (JsonSerializeAction<object>)delegate(ref JsonWriter writer, object value, IJsonFormatterResolver _)
				{
					writer.WriteInt64((long)value);
				};
			}
			if (underlyingType == typeof(ulong))
			{
				return (JsonSerializeAction<object>)delegate(ref JsonWriter writer, object value, IJsonFormatterResolver _)
				{
					writer.WriteUInt64((ulong)value);
				};
			}
			throw new InvalidOperationException("Type is not Enum. Type:" + type);
		}

		public static object GetDeserializeDelegate(Type type, out bool isBoxed)
		{
			Type underlyingType = Enum.GetUnderlyingType(type);
			isBoxed = true;
			if (underlyingType == typeof(byte))
			{
				return (JsonDeserializeFunc<object>)delegate(ref JsonReader reader, IJsonFormatterResolver _)
				{
					return reader.ReadByte();
				};
			}
			if (underlyingType == typeof(sbyte))
			{
				return (JsonDeserializeFunc<object>)delegate(ref JsonReader reader, IJsonFormatterResolver _)
				{
					return reader.ReadSByte();
				};
			}
			if (underlyingType == typeof(short))
			{
				return (JsonDeserializeFunc<object>)delegate(ref JsonReader reader, IJsonFormatterResolver _)
				{
					return reader.ReadInt16();
				};
			}
			if (underlyingType == typeof(ushort))
			{
				return (JsonDeserializeFunc<object>)delegate(ref JsonReader reader, IJsonFormatterResolver _)
				{
					return reader.ReadUInt16();
				};
			}
			if (underlyingType == typeof(int))
			{
				return (JsonDeserializeFunc<object>)delegate(ref JsonReader reader, IJsonFormatterResolver _)
				{
					return reader.ReadInt32();
				};
			}
			if (underlyingType == typeof(uint))
			{
				return (JsonDeserializeFunc<object>)delegate(ref JsonReader reader, IJsonFormatterResolver _)
				{
					return reader.ReadUInt32();
				};
			}
			if (underlyingType == typeof(long))
			{
				return (JsonDeserializeFunc<object>)delegate(ref JsonReader reader, IJsonFormatterResolver _)
				{
					return reader.ReadInt64();
				};
			}
			if (underlyingType == typeof(ulong))
			{
				return (JsonDeserializeFunc<object>)delegate(ref JsonReader reader, IJsonFormatterResolver _)
				{
					return reader.ReadUInt64();
				};
			}
			throw new InvalidOperationException("Type is not Enum. Type:" + type);
		}
	}
}

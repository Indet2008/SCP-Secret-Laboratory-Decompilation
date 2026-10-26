using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using Utf8Json.Formatters;

namespace Utf8Json.Resolvers
{
	public sealed class BuiltinResolver : IJsonFormatterResolver
	{
		private static class FormatterCache<T>
		{
			public static readonly IJsonFormatter<T> formatter;

			static FormatterCache()
			{
				formatter = (IJsonFormatter<T>)BuiltinResolverGetFormatterHelper.GetFormatter(typeof(T));
			}
		}

		internal static class BuiltinResolverGetFormatterHelper
		{
			private static readonly Dictionary<Type, object> formatterMap = new Dictionary<Type, object>
			{
				{
					typeof(short),
					Int16Formatter.Default
				},
				{
					typeof(int),
					Int32Formatter.Default
				},
				{
					typeof(long),
					Int64Formatter.Default
				},
				{
					typeof(ushort),
					UInt16Formatter.Default
				},
				{
					typeof(uint),
					UInt32Formatter.Default
				},
				{
					typeof(ulong),
					UInt64Formatter.Default
				},
				{
					typeof(float),
					SingleFormatter.Default
				},
				{
					typeof(double),
					DoubleFormatter.Default
				},
				{
					typeof(bool),
					BooleanFormatter.Default
				},
				{
					typeof(byte),
					ByteFormatter.Default
				},
				{
					typeof(sbyte),
					SByteFormatter.Default
				},
				{
					typeof(short?),
					NullableInt16Formatter.Default
				},
				{
					typeof(int?),
					NullableInt32Formatter.Default
				},
				{
					typeof(long?),
					NullableInt64Formatter.Default
				},
				{
					typeof(ushort?),
					NullableUInt16Formatter.Default
				},
				{
					typeof(uint?),
					NullableUInt32Formatter.Default
				},
				{
					typeof(ulong?),
					NullableUInt64Formatter.Default
				},
				{
					typeof(float?),
					NullableSingleFormatter.Default
				},
				{
					typeof(double?),
					NullableDoubleFormatter.Default
				},
				{
					typeof(bool?),
					NullableBooleanFormatter.Default
				},
				{
					typeof(byte?),
					NullableByteFormatter.Default
				},
				{
					typeof(sbyte?),
					NullableSByteFormatter.Default
				},
				{
					typeof(DateTime),
					ISO8601DateTimeFormatter.Default
				},
				{
					typeof(TimeSpan),
					ISO8601TimeSpanFormatter.Default
				},
				{
					typeof(DateTimeOffset),
					ISO8601DateTimeOffsetFormatter.Default
				},
				{
					typeof(DateTime?),
					new StaticNullableFormatter<DateTime>(ISO8601DateTimeFormatter.Default)
				},
				{
					typeof(TimeSpan?),
					new StaticNullableFormatter<TimeSpan>(ISO8601TimeSpanFormatter.Default)
				},
				{
					typeof(DateTimeOffset?),
					new StaticNullableFormatter<DateTimeOffset>(ISO8601DateTimeOffsetFormatter.Default)
				},
				{
					typeof(string),
					NullableStringFormatter.Default
				},
				{
					typeof(char),
					CharFormatter.Default
				},
				{
					typeof(char?),
					NullableCharFormatter.Default
				},
				{
					typeof(decimal),
					DecimalFormatter.Default
				},
				{
					typeof(decimal?),
					new StaticNullableFormatter<decimal>(DecimalFormatter.Default)
				},
				{
					typeof(Guid),
					GuidFormatter.Default
				},
				{
					typeof(Guid?),
					new StaticNullableFormatter<Guid>(GuidFormatter.Default)
				},
				{
					typeof(Uri),
					UriFormatter.Default
				},
				{
					typeof(Version),
					VersionFormatter.Default
				},
				{
					typeof(StringBuilder),
					StringBuilderFormatter.Default
				},
				{
					typeof(BitArray),
					BitArrayFormatter.Default
				},
				{
					typeof(Type),
					TypeFormatter.Default
				},
				{
					typeof(byte[]),
					ByteArrayFormatter.Default
				},
				{
					typeof(short[]),
					Int16ArrayFormatter.Default
				},
				{
					typeof(int[]),
					Int32ArrayFormatter.Default
				},
				{
					typeof(long[]),
					Int64ArrayFormatter.Default
				},
				{
					typeof(ushort[]),
					UInt16ArrayFormatter.Default
				},
				{
					typeof(uint[]),
					UInt32ArrayFormatter.Default
				},
				{
					typeof(ulong[]),
					UInt64ArrayFormatter.Default
				},
				{
					typeof(float[]),
					SingleArrayFormatter.Default
				},
				{
					typeof(double[]),
					DoubleArrayFormatter.Default
				},
				{
					typeof(bool[]),
					BooleanArrayFormatter.Default
				},
				{
					typeof(sbyte[]),
					SByteArrayFormatter.Default
				},
				{
					typeof(char[]),
					CharArrayFormatter.Default
				},
				{
					typeof(string[]),
					NullableStringArrayFormatter.Default
				},
				{
					typeof(List<short>),
					new ListFormatter<short>()
				},
				{
					typeof(List<int>),
					new ListFormatter<int>()
				},
				{
					typeof(List<long>),
					new ListFormatter<long>()
				},
				{
					typeof(List<ushort>),
					new ListFormatter<ushort>()
				},
				{
					typeof(List<uint>),
					new ListFormatter<uint>()
				},
				{
					typeof(List<ulong>),
					new ListFormatter<ulong>()
				},
				{
					typeof(List<float>),
					new ListFormatter<float>()
				},
				{
					typeof(List<double>),
					new ListFormatter<double>()
				},
				{
					typeof(List<bool>),
					new ListFormatter<bool>()
				},
				{
					typeof(List<byte>),
					new ListFormatter<byte>()
				},
				{
					typeof(List<sbyte>),
					new ListFormatter<sbyte>()
				},
				{
					typeof(List<DateTime>),
					new ListFormatter<DateTime>()
				},
				{
					typeof(List<char>),
					new ListFormatter<char>()
				},
				{
					typeof(List<string>),
					new ListFormatter<string>()
				},
				{
					typeof(ArraySegment<byte>),
					ByteArraySegmentFormatter.Default
				},
				{
					typeof(ArraySegment<byte>?),
					new StaticNullableFormatter<ArraySegment<byte>>(ByteArraySegmentFormatter.Default)
				}
			};

			internal static object GetFormatter(Type t)
			{
				if (formatterMap.TryGetValue(t, out var value))
				{
					return value;
				}
				return null;
			}
		}

		public static readonly IJsonFormatterResolver Instance = new BuiltinResolver();

		private BuiltinResolver()
		{
		}

		public IJsonFormatter<T> GetFormatter<T>()
		{
			return FormatterCache<T>.formatter;
		}
	}
}

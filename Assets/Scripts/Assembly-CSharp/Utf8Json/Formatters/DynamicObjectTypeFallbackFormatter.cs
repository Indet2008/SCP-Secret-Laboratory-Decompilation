using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Emit;
using Utf8Json.Internal;
using Utf8Json.Internal.Emit;
using Utf8Json.Resolvers.Internal;

namespace Utf8Json.Formatters
{
	public sealed class DynamicObjectTypeFallbackFormatter : IJsonFormatter<object>, IJsonFormatter
	{
		private delegate void SerializeMethod(object dynamicFormatter, ref JsonWriter writer, object value, IJsonFormatterResolver formatterResolver);

		private readonly ThreadsafeTypeKeyHashTable<KeyValuePair<object, SerializeMethod>> serializers = new ThreadsafeTypeKeyHashTable<KeyValuePair<object, SerializeMethod>>();

		private readonly IJsonFormatterResolver[] innerResolvers;

		public DynamicObjectTypeFallbackFormatter(params IJsonFormatterResolver[] innerResolvers)
		{
			this.innerResolvers = innerResolvers;
		}

		public void Serialize(ref JsonWriter writer, object value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
				return;
			}
			Type type = value.GetType();
			if (type == typeof(object))
			{
				writer.WriteBeginObject();
				writer.WriteEndObject();
				return;
			}
			if (!serializers.TryGetValue(type, out var value2))
			{
				lock (serializers)
				{
					if (!serializers.TryGetValue(type, out value2))
					{
						object obj = null;
						IJsonFormatterResolver[] array = innerResolvers;
						for (int i = 0; i < array.Length; i++)
						{
							obj = array[i].GetFormatterDynamic(type);
							if (obj != null)
							{
								break;
							}
						}
						if (obj == null)
						{
							throw new FormatterNotRegisteredException(type.FullName + " is not registered in this resolver. resolvers:" + string.Join(", ", innerResolvers.Select((IJsonFormatterResolver x) => x.GetType().Name).ToArray()));
						}
						Type type2 = type;
						DynamicMethod dynamicMethod = new DynamicMethod("Serialize", null, new Type[4]
						{
							typeof(object),
							typeof(JsonWriter).MakeByRefType(),
							typeof(object),
							typeof(IJsonFormatterResolver)
						}, type.Module, skipVisibility: true);
						ILGenerator iLGenerator = dynamicMethod.GetILGenerator();
						iLGenerator.EmitLdarg(0);
						iLGenerator.Emit(OpCodes.Castclass, typeof(IJsonFormatter<>).MakeGenericType(type2));
						iLGenerator.EmitLdarg(1);
						iLGenerator.EmitLdarg(2);
						iLGenerator.EmitUnboxOrCast(type2);
						iLGenerator.EmitLdarg(3);
						iLGenerator.EmitCall(DynamicObjectTypeBuilder.EmitInfo.Serialize(type2));
						iLGenerator.Emit(OpCodes.Ret);
						value2 = new KeyValuePair<object, SerializeMethod>(obj, (SerializeMethod)dynamicMethod.CreateDelegate(typeof(SerializeMethod)));
						serializers.TryAdd(type2, value2);
					}
				}
			}
			value2.Value(value2.Key, ref writer, value, formatterResolver);
		}

		public object Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			return PrimitiveObjectFormatter.Default.Deserialize(ref reader, formatterResolver);
		}
	}
}

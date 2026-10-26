using System;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.CompilerServices;

namespace Utf8Json.Internal
{
	internal static class ReflectionExtensions
	{
		public static bool IsNullable(this TypeInfo type)
		{
			if (type.IsGenericType)
			{
				return type.GetGenericTypeDefinition() == typeof(Nullable<>);
			}
			return false;
		}

		public static bool IsPublic(this TypeInfo type)
		{
			return type.IsPublic;
		}

		public static bool IsAnonymous(this TypeInfo type)
		{
			if (type.GetCustomAttribute<CompilerGeneratedAttribute>() != null && type.Name.Contains("AnonymousType") && (type.Name.StartsWith("<>") || type.Name.StartsWith("VB$")))
			{
				return (type.Attributes & TypeAttributes.NotPublic) == 0;
			}
			return false;
		}

		public static IEnumerable<PropertyInfo> GetAllProperties(this Type type)
		{
			return GetAllPropertiesCore(type, new HashSet<string>());
		}

		private static IEnumerable<PropertyInfo> GetAllPropertiesCore(Type type, HashSet<string> nameCheck)
		{
			foreach (PropertyInfo runtimeProperty in type.GetRuntimeProperties())
			{
				if (nameCheck.Add(runtimeProperty.Name))
				{
					yield return runtimeProperty;
				}
			}
			if (!(type.BaseType != null))
			{
				yield break;
			}
			foreach (PropertyInfo item in GetAllPropertiesCore(type.BaseType, nameCheck))
			{
				yield return item;
			}
		}

		public static IEnumerable<FieldInfo> GetAllFields(this Type type)
		{
			return GetAllFieldsCore(type, new HashSet<string>());
		}

		private static IEnumerable<FieldInfo> GetAllFieldsCore(Type type, HashSet<string> nameCheck)
		{
			foreach (FieldInfo runtimeField in type.GetRuntimeFields())
			{
				if (nameCheck.Add(runtimeField.Name))
				{
					yield return runtimeField;
				}
			}
			if (!(type.BaseType != null))
			{
				yield break;
			}
			foreach (FieldInfo item in GetAllFieldsCore(type.BaseType, nameCheck))
			{
				yield return item;
			}
		}
	}
}

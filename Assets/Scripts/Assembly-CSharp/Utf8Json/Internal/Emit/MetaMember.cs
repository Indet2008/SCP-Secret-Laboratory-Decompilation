using System;
using System.Linq;
using System.Reflection;
using System.Reflection.Emit;

namespace Utf8Json.Internal.Emit
{
	internal class MetaMember
	{
		private MethodInfo getMethod;

		private MethodInfo setMethod;

		public string Name { get; private set; }

		public string MemberName { get; private set; }

		public bool IsProperty => PropertyInfo != null;

		public bool IsField => FieldInfo != null;

		public bool IsWritable { get; private set; }

		public bool IsReadable { get; private set; }

		public Type Type { get; private set; }

		public FieldInfo FieldInfo { get; private set; }

		public PropertyInfo PropertyInfo { get; private set; }

		public MethodInfo ShouldSerializeMethodInfo { get; private set; }

		protected MetaMember(Type type, string name, string memberName, bool isWritable, bool isReadable)
		{
			Name = name;
			MemberName = memberName;
			Type = type;
			IsWritable = isWritable;
			IsReadable = isReadable;
		}

		public MetaMember(FieldInfo info, string name, bool allowPrivate)
		{
			Name = name;
			MemberName = info.Name;
			FieldInfo = info;
			Type = info.FieldType;
			IsReadable = allowPrivate || info.IsPublic;
			IsWritable = allowPrivate || (info.IsPublic && !info.IsInitOnly);
			ShouldSerializeMethodInfo = GetShouldSerialize(info);
		}

		public MetaMember(PropertyInfo info, string name, bool allowPrivate)
		{
			getMethod = info.GetGetMethod(nonPublic: true);
			setMethod = info.GetSetMethod(nonPublic: true);
			Name = name;
			MemberName = info.Name;
			PropertyInfo = info;
			Type = info.PropertyType;
			IsReadable = getMethod != null && (allowPrivate || getMethod.IsPublic) && !getMethod.IsStatic;
			IsWritable = setMethod != null && (allowPrivate || setMethod.IsPublic) && !setMethod.IsStatic;
			ShouldSerializeMethodInfo = GetShouldSerialize(info);
		}

		private static MethodInfo GetShouldSerialize(MemberInfo info)
		{
			string shouldSerialize = "ShouldSerialize" + info.Name;
			return (from x in info.DeclaringType.GetMethods(BindingFlags.Instance | BindingFlags.Public)
				where x.Name == shouldSerialize && x.ReturnType == typeof(bool) && x.GetParameters().Length == 0
				select x).FirstOrDefault();
		}

		public T GetCustomAttribute<T>(bool inherit) where T : Attribute
		{
			if (IsProperty)
			{
				return PropertyInfo.GetCustomAttribute<T>(inherit);
			}
			if (FieldInfo != null)
			{
				return FieldInfo.GetCustomAttribute<T>(inherit);
			}
			return null;
		}

		public virtual void EmitLoadValue(ILGenerator il)
		{
			if (IsProperty)
			{
				il.EmitCall(getMethod);
			}
			else
			{
				il.Emit(OpCodes.Ldfld, FieldInfo);
			}
		}

		public virtual void EmitStoreValue(ILGenerator il)
		{
			if (IsProperty)
			{
				il.EmitCall(setMethod);
			}
			else
			{
				il.Emit(OpCodes.Stfld, FieldInfo);
			}
		}
	}
}

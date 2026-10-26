using System;

public static class EnumUtils<T> where T : struct, Enum
{
	public static readonly T[] Values = Enum.GetValues(typeof(T)).ToArray<T>();

	public static readonly string[] Names = Enum.GetNames(typeof(T));

	public static readonly Type UnderlyingType = Enum.GetUnderlyingType(typeof(T));

	public static readonly TypeCode TypeCode = Type.GetTypeCode(Enum.GetUnderlyingType(typeof(T)));
}

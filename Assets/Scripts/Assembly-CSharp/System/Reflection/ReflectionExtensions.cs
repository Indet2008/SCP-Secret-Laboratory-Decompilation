namespace System.Reflection
{
	internal static class ReflectionExtensions
	{
		public static bool IsConstructedGenericType(this TypeInfo type)
		{
			return type.IsConstructedGenericType;
		}
	}
}

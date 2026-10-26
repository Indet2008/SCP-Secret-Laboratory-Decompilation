using Utf8Json.Resolvers.Internal;

namespace Utf8Json.Resolvers
{
	public static class EnumResolver
	{
		public static readonly IJsonFormatterResolver Default = EnumDefaultResolver.Instance;

		public static readonly IJsonFormatterResolver UnderlyingValue = EnumUnderlyingValueResolver.Instance;
	}
}

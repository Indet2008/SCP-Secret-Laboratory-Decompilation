using Utf8Json.Unity;

namespace Utf8Json.Resolvers.Internal
{
	internal static class StandardResolverHelper
	{
		internal static readonly IJsonFormatterResolver[] CompositeResolverBase = new IJsonFormatterResolver[5]
		{
			BuiltinResolver.Instance,
			UnityResolver.Instance,
			EnumResolver.Default,
			DynamicGenericResolver.Instance,
			AttributeFormatterResolver.Instance
		};
	}
}

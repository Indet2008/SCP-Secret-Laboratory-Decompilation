using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace Serialization
{
	public static class YamlParser
	{
		public static ISerializer Serializer { get; } = new SerializerBuilder().WithEmissionPhaseObjectGraphVisitor((EmissionPhaseObjectGraphVisitorArgs visitor) => new CommentsObjectGraphVisitor(visitor.InnerVisitor)).WithTypeInspector((ITypeInspector typeInspector) => new CommentGatheringTypeInspector(typeInspector)).WithNamingConvention(UnderscoredNamingConvention.Instance)
			.DisableAliases()
			.IgnoreFields()
			.Build();

		public static IDeserializer Deserializer { get; } = new DeserializerBuilder().WithNamingConvention(UnderscoredNamingConvention.Instance).IgnoreUnmatchedProperties().IgnoreFields()
			.Build();
	}
}

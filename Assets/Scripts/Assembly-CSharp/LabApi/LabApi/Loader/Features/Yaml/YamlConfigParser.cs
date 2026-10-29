namespace LabApi.Loader.Features.Yaml
{
	public static class YamlConfigParser
	{
		public static global::YamlDotNet.Serialization.ISerializer Serializer { get; } = new global::YamlDotNet.Serialization.SerializerBuilder().WithEmissionPhaseObjectGraphVisitor((global::YamlDotNet.Serialization.EmissionPhaseObjectGraphVisitorArgs visitor) => new global::Serialization.CommentsObjectGraphVisitor(visitor.InnerVisitor)).WithTypeInspector((global::YamlDotNet.Serialization.ITypeInspector typeInspector) => new global::Serialization.CommentGatheringTypeInspector(typeInspector)).WithNamingConvention(global::YamlDotNet.Serialization.NamingConventions.UnderscoredNamingConvention.Instance)
			.DisableAliases()
			.IgnoreFields()
			.WithTypeConverter(new global::LabApi.Loader.Features.Yaml.CustomConverters.CustomVectorConverter())
			.WithTypeConverter(new global::LabApi.Loader.Features.Yaml.CustomConverters.CustomColor32Converter())
			.WithTypeConverter(new global::LabApi.Loader.Features.Yaml.CustomConverters.CustomColorConverter())
			.WithTypeConverter(new global::LabApi.Loader.Features.Yaml.CustomConverters.CustomQuaternionConverter())
			.Build();

		public static global::YamlDotNet.Serialization.IDeserializer Deserializer { get; } = new global::YamlDotNet.Serialization.DeserializerBuilder().WithNamingConvention(global::YamlDotNet.Serialization.NamingConventions.UnderscoredNamingConvention.Instance).IgnoreUnmatchedProperties().IgnoreFields()
			.WithTypeConverter(new global::LabApi.Loader.Features.Yaml.CustomConverters.CustomVectorConverter())
			.WithTypeConverter(new global::LabApi.Loader.Features.Yaml.CustomConverters.CustomColor32Converter())
			.WithTypeConverter(new global::LabApi.Loader.Features.Yaml.CustomConverters.CustomColorConverter())
			.WithTypeConverter(new global::LabApi.Loader.Features.Yaml.CustomConverters.CustomQuaternionConverter())
			.Build();
	}
}

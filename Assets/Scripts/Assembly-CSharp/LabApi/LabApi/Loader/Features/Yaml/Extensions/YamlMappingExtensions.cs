namespace LabApi.Loader.Features.Yaml.Extensions
{
	public static class YamlMappingExtensions
	{
		public static void EmitMapping(this global::YamlDotNet.Core.IEmitter emitter, string key, string value)
		{
			emitter.Emit(new global::YamlDotNet.Core.Events.Scalar(key));
			emitter.Emit(new global::YamlDotNet.Core.Events.Scalar(value));
		}

		public static bool TryReadMapping(this global::YamlDotNet.Core.IParser parser, out string key, out string value)
		{
			key = string.Empty;
			value = string.Empty;
			if (!global::YamlDotNet.Core.ParserExtensions.TryConsume<global::YamlDotNet.Core.Events.Scalar>(parser, out var @event) || !global::YamlDotNet.Core.ParserExtensions.TryConsume<global::YamlDotNet.Core.Events.Scalar>(parser, out var event2))
			{
				return false;
			}
			key = @event.Value.Trim();
			value = event2.Value.Trim();
			return true;
		}
	}
}

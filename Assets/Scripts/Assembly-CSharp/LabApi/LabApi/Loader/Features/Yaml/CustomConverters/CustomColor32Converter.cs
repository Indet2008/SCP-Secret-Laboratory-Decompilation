namespace LabApi.Loader.Features.Yaml.CustomConverters
{
	public class CustomColor32Converter : global::YamlDotNet.Serialization.IYamlTypeConverter
	{
		public object ReadYaml(global::YamlDotNet.Core.IParser parser, global::System.Type type)
		{
			string value = global::YamlDotNet.Core.ParserExtensions.Consume<global::YamlDotNet.Core.Events.Scalar>(parser).Value;
			if (!global::UnityEngine.ColorUtility.TryParseHtmlString(value, out var color))
			{
				throw new global::System.ArgumentException("Unable to parse Color32 value of " + value);
			}
			return (global::UnityEngine.Color32)color;
		}

		public void WriteYaml(global::YamlDotNet.Core.IEmitter emitter, object? value, global::System.Type type)
		{
			emitter.Emit(new global::YamlDotNet.Core.Events.Scalar(((global::UnityEngine.Color32?)value)?.ToHex() ?? global::UnityEngine.Color.white.ToHex()));
		}

		public bool Accepts(global::System.Type type)
		{
			return type == typeof(global::UnityEngine.Color32);
		}
	}
}

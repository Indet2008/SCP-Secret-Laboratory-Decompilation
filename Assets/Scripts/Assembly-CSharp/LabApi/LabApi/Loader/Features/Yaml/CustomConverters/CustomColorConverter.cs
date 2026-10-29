namespace LabApi.Loader.Features.Yaml.CustomConverters
{
	public class CustomColorConverter : global::YamlDotNet.Serialization.IYamlTypeConverter
	{
		public object? ReadYaml(global::YamlDotNet.Core.IParser parser, global::System.Type type)
		{
			global::YamlDotNet.Core.ParserExtensions.Consume<global::YamlDotNet.Core.Events.MappingStart>(parser);
			global::System.Collections.Generic.Dictionary<string, float> dictionary = global::UnityEngine.Pool.CollectionPool<global::System.Collections.Generic.Dictionary<string, float>, global::System.Collections.Generic.KeyValuePair<string, float>>.Get();
			try
			{
				for (int i = 0; i <= 3; i++)
				{
					if (!global::LabApi.Loader.Features.Yaml.Extensions.YamlMappingExtensions.TryReadMapping(parser, out string key, out string value))
					{
						throw new global::System.ArgumentException(string.Format("Unable to parse {0}, no component at index {1} provided", "Color", i));
					}
					bool flag;
					switch (key)
					{
					case "r":
					case "g":
					case "b":
					case "a":
						flag = true;
						break;
					default:
						flag = false;
						break;
					}
					if (!flag)
					{
						throw new global::System.ArgumentException("Unable to parse Color, invalid component name " + key + ". Only 'r', 'g', 'b' and 'a' are allowed");
					}
					dictionary[key] = float.Parse(value, global::System.Globalization.CultureInfo.InvariantCulture);
				}
				global::YamlDotNet.Core.ParserExtensions.Consume<global::YamlDotNet.Core.Events.MappingEnd>(parser);
				return new global::UnityEngine.Color(dictionary["r"], dictionary["g"], dictionary["b"], dictionary["a"]);
			}
			finally
			{
				global::UnityEngine.Pool.CollectionPool<global::System.Collections.Generic.Dictionary<string, float>, global::System.Collections.Generic.KeyValuePair<string, float>>.Release(dictionary);
			}
		}

		public void WriteYaml(global::YamlDotNet.Core.IEmitter emitter, object? value, global::System.Type type)
		{
			global::UnityEngine.Color color = ((global::UnityEngine.Color?)value) ?? global::UnityEngine.Color.white;
			emitter.Emit(new global::YamlDotNet.Core.Events.MappingStart(global::YamlDotNet.Core.AnchorName.Empty, global::YamlDotNet.Core.TagName.Empty, isImplicit: true, global::YamlDotNet.Core.Events.MappingStyle.Block));
			global::LabApi.Loader.Features.Yaml.Extensions.YamlMappingExtensions.EmitMapping(emitter, "r", color.r.ToString(global::System.Globalization.CultureInfo.InvariantCulture));
			global::LabApi.Loader.Features.Yaml.Extensions.YamlMappingExtensions.EmitMapping(emitter, "g", color.g.ToString(global::System.Globalization.CultureInfo.InvariantCulture));
			global::LabApi.Loader.Features.Yaml.Extensions.YamlMappingExtensions.EmitMapping(emitter, "b", color.b.ToString(global::System.Globalization.CultureInfo.InvariantCulture));
			global::LabApi.Loader.Features.Yaml.Extensions.YamlMappingExtensions.EmitMapping(emitter, "a", color.a.ToString(global::System.Globalization.CultureInfo.InvariantCulture));
			emitter.Emit(new global::YamlDotNet.Core.Events.MappingEnd());
		}

		public bool Accepts(global::System.Type type)
		{
			return type == typeof(global::UnityEngine.Color);
		}
	}
}

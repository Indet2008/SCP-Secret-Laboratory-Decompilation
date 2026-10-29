namespace LabApi.Loader.Features.Yaml.CustomConverters
{
	public class CustomQuaternionConverter : global::YamlDotNet.Serialization.IYamlTypeConverter
	{
		public object? ReadYaml(global::YamlDotNet.Core.IParser parser, global::System.Type type)
		{
			global::YamlDotNet.Core.ParserExtensions.Consume<global::YamlDotNet.Core.Events.MappingStart>(parser);
			global::System.Collections.Generic.Dictionary<string, float> dictionary = global::UnityEngine.Pool.CollectionPool<global::System.Collections.Generic.Dictionary<string, float>, global::System.Collections.Generic.KeyValuePair<string, float>>.Get();
			try
			{
				for (int i = 0; i <= 2; i++)
				{
					if (!global::LabApi.Loader.Features.Yaml.Extensions.YamlMappingExtensions.TryReadMapping(parser, out string key, out string value))
					{
						throw new global::System.ArgumentException(string.Format("Unable to parse {0}, no component at index {1} provided", "Quaternion", i));
					}
					bool flag;
					switch (key)
					{
					case "x":
					case "y":
					case "z":
						flag = true;
						break;
					default:
						flag = false;
						break;
					}
					if (!flag)
					{
						throw new global::System.ArgumentException("Unable to parse Quaternion, invalid component name " + key + ". Only 'x', 'y' and 'z' euler angles are allowed");
					}
					dictionary[key] = float.Parse(value, global::System.Globalization.CultureInfo.InvariantCulture);
				}
				global::YamlDotNet.Core.ParserExtensions.Consume<global::YamlDotNet.Core.Events.MappingEnd>(parser);
				return global::UnityEngine.Quaternion.Euler(dictionary["x"], dictionary["y"], dictionary["z"]);
			}
			catch (global::System.ArgumentException)
			{
				throw;
			}
			finally
			{
				global::UnityEngine.Pool.CollectionPool<global::System.Collections.Generic.Dictionary<string, float>, global::System.Collections.Generic.KeyValuePair<string, float>>.Release(dictionary);
			}
		}

		public void WriteYaml(global::YamlDotNet.Core.IEmitter emitter, object? value, global::System.Type type)
		{
			global::UnityEngine.Vector3 vector = ((global::UnityEngine.Quaternion?)value)?.eulerAngles ?? global::UnityEngine.Vector3.zero;
			emitter.Emit(new global::YamlDotNet.Core.Events.MappingStart(global::YamlDotNet.Core.AnchorName.Empty, global::YamlDotNet.Core.TagName.Empty, isImplicit: true, global::YamlDotNet.Core.Events.MappingStyle.Block));
			global::LabApi.Loader.Features.Yaml.Extensions.YamlMappingExtensions.EmitMapping(emitter, "x", vector.x.ToString(global::System.Globalization.CultureInfo.InvariantCulture));
			global::LabApi.Loader.Features.Yaml.Extensions.YamlMappingExtensions.EmitMapping(emitter, "y", vector.y.ToString(global::System.Globalization.CultureInfo.InvariantCulture));
			global::LabApi.Loader.Features.Yaml.Extensions.YamlMappingExtensions.EmitMapping(emitter, "z", vector.z.ToString(global::System.Globalization.CultureInfo.InvariantCulture));
			emitter.Emit(new global::YamlDotNet.Core.Events.MappingEnd());
		}

		public bool Accepts(global::System.Type type)
		{
			return type == typeof(global::UnityEngine.Quaternion);
		}
	}
}

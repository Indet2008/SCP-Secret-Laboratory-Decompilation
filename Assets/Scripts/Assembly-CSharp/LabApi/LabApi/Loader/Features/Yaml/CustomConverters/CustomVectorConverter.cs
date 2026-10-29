namespace LabApi.Loader.Features.Yaml.CustomConverters
{
	public class CustomVectorConverter : global::YamlDotNet.Serialization.IYamlTypeConverter
	{
		public object? ReadYaml(global::YamlDotNet.Core.IParser parser, global::System.Type type)
		{
			global::YamlDotNet.Core.ParserExtensions.Consume<global::YamlDotNet.Core.Events.MappingStart>(parser);
			global::System.Collections.Generic.Dictionary<string, float> dictionary = global::UnityEngine.Pool.CollectionPool<global::System.Collections.Generic.Dictionary<string, float>, global::System.Collections.Generic.KeyValuePair<string, float>>.Get();
			int num = 0;
			try
			{
				global::YamlDotNet.Core.Events.MappingEnd @event;
				while (!global::YamlDotNet.Core.ParserExtensions.TryConsume<global::YamlDotNet.Core.Events.MappingEnd>(parser, out @event))
				{
					if (!global::LabApi.Loader.Features.Yaml.Extensions.YamlMappingExtensions.TryReadMapping(parser, out string key, out string value))
					{
						throw new global::System.ArgumentException($"Unable to parse Vector, no component at index {num} provided");
					}
					bool flag;
					switch (key)
					{
					case "x":
					case "y":
					case "z":
					case "w":
						flag = true;
						break;
					default:
						flag = false;
						break;
					}
					if (!flag)
					{
						throw new global::System.ArgumentException("Unable to parse Vector, invalid component name " + key + ". Only 'x' 'y' 'z' and 'w' are allowed");
					}
					if (dictionary.ContainsKey(key))
					{
						throw new global::System.ArgumentException("Unable to parse Vector, duplicate component " + key);
					}
					dictionary[key] = float.Parse(value, global::System.Globalization.CultureInfo.InvariantCulture);
					num++;
				}
				object obj = dictionary.Count switch
				{
					2 => new global::UnityEngine.Vector2(dictionary["x"], dictionary["y"]), 
					3 => new global::UnityEngine.Vector3(dictionary["x"], dictionary["y"], dictionary["z"]), 
					4 => new global::UnityEngine.Vector4(dictionary["x"], dictionary["y"], dictionary["z"], dictionary["w"]), 
					_ => throw new global::System.ArgumentException($"Unable to deserialize vector with {dictionary.Count} components"), 
				};
				global::System.Type type2 = obj.GetType();
				if (type2 != type)
				{
					throw new global::System.ArgumentException("Attempting to deserialize " + type2.Name + " for config type of " + type.Name);
				}
				return obj;
			}
			finally
			{
				global::UnityEngine.Pool.CollectionPool<global::System.Collections.Generic.Dictionary<string, float>, global::System.Collections.Generic.KeyValuePair<string, float>>.Release(dictionary);
			}
		}

		public void WriteYaml(global::YamlDotNet.Core.IEmitter emitter, object? value, global::System.Type _)
		{
			emitter.Emit(new global::YamlDotNet.Core.Events.MappingStart(global::YamlDotNet.Core.AnchorName.Empty, global::YamlDotNet.Core.TagName.Empty, isImplicit: true, global::YamlDotNet.Core.Events.MappingStyle.Block));
			if (!(value is global::UnityEngine.Vector2 vector))
			{
				if (!(value is global::UnityEngine.Vector3 vector2))
				{
					if (value is global::UnityEngine.Vector4 vector3)
					{
						global::LabApi.Loader.Features.Yaml.Extensions.YamlMappingExtensions.EmitMapping(emitter, "x", vector3.x.ToString(global::System.Globalization.CultureInfo.InvariantCulture));
						global::LabApi.Loader.Features.Yaml.Extensions.YamlMappingExtensions.EmitMapping(emitter, "y", vector3.y.ToString(global::System.Globalization.CultureInfo.InvariantCulture));
						global::LabApi.Loader.Features.Yaml.Extensions.YamlMappingExtensions.EmitMapping(emitter, "z", vector3.z.ToString(global::System.Globalization.CultureInfo.InvariantCulture));
						global::LabApi.Loader.Features.Yaml.Extensions.YamlMappingExtensions.EmitMapping(emitter, "w", vector3.z.ToString(global::System.Globalization.CultureInfo.InvariantCulture));
					}
				}
				else
				{
					global::LabApi.Loader.Features.Yaml.Extensions.YamlMappingExtensions.EmitMapping(emitter, "x", vector2.x.ToString(global::System.Globalization.CultureInfo.InvariantCulture));
					global::LabApi.Loader.Features.Yaml.Extensions.YamlMappingExtensions.EmitMapping(emitter, "y", vector2.y.ToString(global::System.Globalization.CultureInfo.InvariantCulture));
					global::LabApi.Loader.Features.Yaml.Extensions.YamlMappingExtensions.EmitMapping(emitter, "z", vector2.z.ToString(global::System.Globalization.CultureInfo.InvariantCulture));
				}
			}
			else
			{
				global::LabApi.Loader.Features.Yaml.Extensions.YamlMappingExtensions.EmitMapping(emitter, "x", vector.x.ToString(global::System.Globalization.CultureInfo.InvariantCulture));
				global::LabApi.Loader.Features.Yaml.Extensions.YamlMappingExtensions.EmitMapping(emitter, "y", vector.y.ToString(global::System.Globalization.CultureInfo.InvariantCulture));
			}
			emitter.Emit(new global::YamlDotNet.Core.Events.MappingEnd());
		}

		public bool Accepts(global::System.Type type)
		{
			if (!(type == typeof(global::UnityEngine.Vector2)) && !(type == typeof(global::UnityEngine.Vector3)))
			{
				return type == typeof(global::UnityEngine.Vector4);
			}
			return true;
		}
	}
}

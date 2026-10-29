namespace LabApi.Loader.Features.Misc
{
	public static class AssemblyUtils
	{
		private const string LoggerPrefix = "[ASSEMBLY_LOADER]";

		public static bool HasMissingDependencies(global::System.Reflection.Assembly assembly, string assemblyPath, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(false)] out global::System.Type[]? types)
		{
			string[] array = global::System.Linq.Enumerable.ToArray(GetMissingDependencies(assembly));
			try
			{
				if (array.Length != 0)
				{
					ResolveEmbeddedResources(assembly);
				}
				types = assembly.GetTypes();
				return false;
			}
			catch (global::System.Exception ex)
			{
				global::LabApi.Features.Console.Logger.Error("[ASSEMBLY_LOADER] Couldn't load the assembly inside '" + assemblyPath + "'");
				if (array.Length != 0)
				{
					global::LabApi.Features.Console.Logger.Error("[ASSEMBLY_LOADER] Missing dependencies:\n" + string.Join("\n", global::System.Linq.Enumerable.Select(array, (string x) => "-\t " + x)));
				}
				global::LabApi.Features.Console.Logger.Error(ex.ToString());
				types = null;
				return true;
			}
		}

		public static global::System.Collections.Generic.IEnumerable<string> GetLoadedAssemblies()
		{
			return global::System.Linq.Enumerable.Select(global::System.AppDomain.CurrentDomain.GetAssemblies(), NameSelector);
			static string NameSelector(global::System.Reflection.Assembly assembly)
			{
				return FormatAssemblyName(assembly.GetName());
			}
		}

		public static global::System.Collections.Generic.IEnumerable<string> GetMissingDependencies(global::System.Reflection.Assembly assembly)
		{
			global::System.Collections.Generic.HashSet<string> loadedAssemblies = global::System.Linq.Enumerable.ToHashSet(GetLoadedAssemblies());
			return global::System.Linq.Enumerable.Where(global::System.Linq.Enumerable.Select(assembly.GetReferencedAssemblies(), FormatAssemblyName), (string name) => !loadedAssemblies.Contains(name));
		}

		public static void ResolveEmbeddedResources(global::System.Reflection.Assembly assembly)
		{
			string[] manifestResourceNames = assembly.GetManifestResourceNames();
			foreach (string text in manifestResourceNames)
			{
				if (text.EndsWith(".dll", global::System.StringComparison.OrdinalIgnoreCase))
				{
					LoadEmbeddedDll(assembly, text);
				}
				else if (text.EndsWith(".dll.compressed", global::System.StringComparison.OrdinalIgnoreCase))
				{
					LoadCompressedEmbeddedDll(assembly, text);
				}
			}
		}

		public static void LoadEmbeddedDll(global::System.Reflection.Assembly target, string name)
		{
			if (TryGetDataStream(target, name, out global::System.IO.Stream dataStream))
			{
				string tempFileName = global::System.IO.Path.GetTempFileName();
				using (global::System.IO.FileStream destination = global::System.IO.File.Create(tempFileName))
				{
					dataStream.CopyTo(destination);
				}
				LoadAssemblyIfMissing(tempFileName);
			}
		}

		public static void LoadCompressedEmbeddedDll(global::System.Reflection.Assembly target, string name)
		{
			if (!TryGetDataStream(target, name, out global::System.IO.Stream dataStream))
			{
				return;
			}
			string tempFileName = global::System.IO.Path.GetTempFileName();
			using (global::System.IO.Compression.DeflateStream deflateStream = new global::System.IO.Compression.DeflateStream(dataStream, global::System.IO.Compression.CompressionMode.Decompress))
			{
				using global::System.IO.FileStream destination = global::System.IO.File.Create(tempFileName);
				deflateStream.CopyTo(destination);
			}
			LoadAssemblyIfMissing(tempFileName);
		}

		public static bool TryGetDataStream(global::System.Reflection.Assembly target, string name, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::System.IO.Stream? dataStream)
		{
			dataStream = target.GetManifestResourceStream(name);
			if (dataStream != null)
			{
				return true;
			}
			global::LabApi.Features.Console.Logger.Error("[ASSEMBLY_LOADER] Unable to resolve " + name + " Stream was null");
			return false;
		}

		public static bool TryGetLoadedAssembly(this global::LabApi.Loader.Features.Plugins.Plugin plugin, out global::System.Reflection.Assembly assembly)
		{
			return global::LabApi.Loader.PluginLoader.Plugins.TryGetValue(plugin, out assembly);
		}

		private static string FormatAssemblyName(global::System.Reflection.AssemblyName assemblyName)
		{
			return $"{assemblyName.Name} v{assemblyName.Version}";
		}

		private static void LoadAssemblyIfMissing(string path)
		{
			try
			{
				global::System.Reflection.AssemblyName name = global::System.Reflection.AssemblyName.GetAssemblyName(path);
				if (name != null && global::System.Linq.Enumerable.All(global::System.AppDomain.CurrentDomain.GetAssemblies(), (global::System.Reflection.Assembly e) => e.GetName().Name != name.Name))
				{
					global::LabApi.Loader.PluginLoader.Dependencies.Add(global::System.Reflection.Assembly.Load(global::System.IO.File.ReadAllBytes(path)));
				}
			}
			finally
			{
				global::System.IO.File.Delete(path);
			}
		}
	}
}

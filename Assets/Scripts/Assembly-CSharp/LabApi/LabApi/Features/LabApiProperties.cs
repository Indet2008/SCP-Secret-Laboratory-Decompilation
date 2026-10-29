namespace LabApi.Features
{
	public static class LabApiProperties
	{
		public static readonly string CompiledVersion = GetCompiledVersion();

		public static readonly global::System.Version CurrentVersion = global::System.Version.Parse(CompiledVersion);

		private static string GetCompiledVersion()
		{
			global::System.Reflection.AssemblyInformationalVersionAttribute customAttribute = global::System.Reflection.CustomAttributeExtensions.GetCustomAttribute<global::System.Reflection.AssemblyInformationalVersionAttribute>(global::System.Reflection.Assembly.GetExecutingAssembly());
			if (customAttribute == null)
			{
				return "0.0.0.0";
			}
			string obj = customAttribute.InformationalVersion ?? "0.0.0.0";
			return obj[..obj.IndexOf('+')];
		}
	}
}

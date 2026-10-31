using System;
using System.Reflection;
using System.Reflection.Emit;

namespace Utf8Json.Internal.Emit
{
	internal class DynamicAssembly
	{
		private readonly AssemblyBuilder assemblyBuilder;

		private readonly ModuleBuilder moduleBuilder;

		private readonly object gate = new object();

#if ENABLE_IL2CPP
		public static bool IsSupported { get; private set; } = false;
#else
		public static bool IsSupported { get; private set; } = true;
#endif

		public TypeBuilder DefineType(string name, TypeAttributes attr)
		{
			lock (gate)
			{
				return moduleBuilder.DefineType(name, attr);
			}
		}

		public TypeBuilder DefineType(string name, TypeAttributes attr, Type parent)
		{
			lock (gate)
			{
				return moduleBuilder.DefineType(name, attr, parent);
			}
		}

		public TypeBuilder DefineType(string name, TypeAttributes attr, Type parent, Type[] interfaces)
		{
			lock (gate)
			{
				return moduleBuilder.DefineType(name, attr, parent, interfaces);
			}
		}

		public DynamicAssembly(string moduleName)
		{
			// IL2CPP has no Reflection.Emit; the dynamic resolvers then return no formatter and the next resolver is tried.
			try
			{
				assemblyBuilder = AppDomain.CurrentDomain.DefineDynamicAssembly(new AssemblyName(moduleName), AssemblyBuilderAccess.Run);
				moduleBuilder = assemblyBuilder.DefineDynamicModule(moduleName);
			}
			catch (PlatformNotSupportedException)
			{
				IsSupported = false;
			}
		}
	}
}

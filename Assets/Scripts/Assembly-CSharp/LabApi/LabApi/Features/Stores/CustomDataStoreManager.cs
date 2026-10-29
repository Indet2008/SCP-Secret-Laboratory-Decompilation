namespace LabApi.Features.Stores
{
	public static class CustomDataStoreManager
	{
		private static readonly global::System.Collections.Generic.List<global::System.Type> RegisteredStores = new global::System.Collections.Generic.List<global::System.Type>();

		private static readonly global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Reflection.MethodInfo> GetOrAddMethods = new global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Reflection.MethodInfo>();

		private static readonly global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Reflection.MethodInfo> DestroyMethods = new global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Reflection.MethodInfo>();

		private static readonly global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Reflection.MethodInfo> DestroyAllMethods = new global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Reflection.MethodInfo>();

		public static bool RegisterStore<T>() where T : global::LabApi.Features.Stores.CustomDataStore
		{
			global::System.Type typeFromHandle = typeof(T);
			if (RegisteredStores.Contains(typeFromHandle))
			{
				return false;
			}
			global::System.Reflection.MethodInfo method = typeof(global::LabApi.Features.Stores.CustomDataStore).GetMethod("GetOrAdd", global::System.Reflection.BindingFlags.Static | global::System.Reflection.BindingFlags.Public | global::System.Reflection.BindingFlags.NonPublic);
			if (method == null)
			{
				return false;
			}
			method = method.MakeGenericMethod(typeFromHandle);
			GetOrAddMethods.Add(typeFromHandle, method);
			global::System.Reflection.MethodInfo method2 = typeof(global::LabApi.Features.Stores.CustomDataStore).GetMethod("Destroy", global::System.Reflection.BindingFlags.Static | global::System.Reflection.BindingFlags.Public | global::System.Reflection.BindingFlags.NonPublic);
			if (method2 == null)
			{
				return false;
			}
			method2 = method2.MakeGenericMethod(typeFromHandle);
			DestroyMethods.Add(typeFromHandle, method2);
			global::System.Reflection.MethodInfo method3 = typeof(global::LabApi.Features.Stores.CustomDataStore).GetMethod("DestroyAll", global::System.Reflection.BindingFlags.Static | global::System.Reflection.BindingFlags.Public | global::System.Reflection.BindingFlags.NonPublic);
			if (method3 == null)
			{
				return false;
			}
			method3 = method3.MakeGenericMethod(typeFromHandle);
			DestroyAllMethods.Add(typeFromHandle, method3);
			RegisteredStores.Add(typeFromHandle);
			return true;
		}

		public static void UnregisterStore<T>() where T : global::LabApi.Features.Stores.CustomDataStore
		{
			global::System.Type typeFromHandle = typeof(T);
			if (DestroyAllMethods.TryGetValue(typeFromHandle, out global::System.Reflection.MethodInfo value))
			{
				value.Invoke(null, null);
			}
			DestroyAllMethods.Remove(typeFromHandle);
			RegisteredStores.Remove(typeFromHandle);
			GetOrAddMethods.Remove(typeFromHandle);
			DestroyMethods.Remove(typeFromHandle);
		}

		internal static void AddPlayer(global::LabApi.Features.Wrappers.Player player)
		{
			foreach (global::System.Type registeredStore in RegisteredStores)
			{
				GetOrAddMethods[registeredStore].Invoke(null, new object[1] { player });
			}
		}

		internal static void RemovePlayer(global::LabApi.Features.Wrappers.Player player)
		{
			foreach (global::System.Type registeredStore in RegisteredStores)
			{
				DestroyMethods[registeredStore].Invoke(null, new object[1] { player });
			}
		}

		internal static bool IsRegistered(global::System.Type type)
		{
			return RegisteredStores.Contains(type);
		}

		internal static bool IsRegistered<T>()
		{
			return IsRegistered(typeof(T));
		}
	}
}

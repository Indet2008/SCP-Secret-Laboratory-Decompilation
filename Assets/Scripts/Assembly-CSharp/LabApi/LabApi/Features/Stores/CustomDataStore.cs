namespace LabApi.Features.Stores
{
	public abstract class CustomDataStore
	{
		private static readonly global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Collections.Generic.Dictionary<global::LabApi.Features.Wrappers.Player, global::LabApi.Features.Stores.CustomDataStore>> StoreInstances = new global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Collections.Generic.Dictionary<global::LabApi.Features.Wrappers.Player, global::LabApi.Features.Stores.CustomDataStore>>();

		public global::LabApi.Features.Wrappers.Player Owner { get; internal set; }

		public static TStore GetOrAdd<TStore>(global::LabApi.Features.Wrappers.Player player) where TStore : global::LabApi.Features.Stores.CustomDataStore
		{
			global::System.Type typeFromHandle = typeof(TStore);
			if (!global::LabApi.Features.Stores.CustomDataStoreManager.IsRegistered<TStore>())
			{
				global::LabApi.Features.Stores.CustomDataStoreManager.RegisterStore<TStore>();
			}
			if (!StoreInstances.TryGetValue(typeFromHandle, out global::System.Collections.Generic.Dictionary<global::LabApi.Features.Wrappers.Player, global::LabApi.Features.Stores.CustomDataStore> value))
			{
				value = new global::System.Collections.Generic.Dictionary<global::LabApi.Features.Wrappers.Player, global::LabApi.Features.Stores.CustomDataStore>();
				StoreInstances[typeFromHandle] = value;
			}
			if (value.TryGetValue(player, out var value2))
			{
				return (TStore)value2;
			}
			object[] args = new object[1] { player };
			value2 = (value[player] = (TStore)global::System.Activator.CreateInstance(typeFromHandle, args));
			return (TStore)value2;
		}

		internal static void Destroy<TStore>(global::LabApi.Features.Wrappers.Player player) where TStore : global::LabApi.Features.Stores.CustomDataStore
		{
			if (StoreInstances.TryGetValue(typeof(TStore), out global::System.Collections.Generic.Dictionary<global::LabApi.Features.Wrappers.Player, global::LabApi.Features.Stores.CustomDataStore> value) && value.TryGetValue(player, out var value2))
			{
				value2.Destroy();
			}
		}

		internal static void DestroyAll<TStore>()
		{
			global::System.Collections.Generic.List<global::LabApi.Features.Stores.CustomDataStore> list = global::NorthwoodLib.Pools.ListPool<global::LabApi.Features.Stores.CustomDataStore>.Shared.Rent(global::System.Linq.Enumerable.SelectMany<global::System.Collections.Generic.KeyValuePair<global::System.Type, global::System.Collections.Generic.Dictionary<global::LabApi.Features.Wrappers.Player, global::LabApi.Features.Stores.CustomDataStore>>, global::LabApi.Features.Stores.CustomDataStore>(StoreInstances, (global::System.Collections.Generic.KeyValuePair<global::System.Type, global::System.Collections.Generic.Dictionary<global::LabApi.Features.Wrappers.Player, global::LabApi.Features.Stores.CustomDataStore>> entry) => global::System.Linq.Enumerable.Select(global::System.Linq.Enumerable.Where(entry.Value, (global::System.Collections.Generic.KeyValuePair<global::LabApi.Features.Wrappers.Player, global::LabApi.Features.Stores.CustomDataStore> playerStore) => playerStore.Value.GetType() == typeof(TStore)), (global::System.Collections.Generic.KeyValuePair<global::LabApi.Features.Wrappers.Player, global::LabApi.Features.Stores.CustomDataStore> playerStore) => playerStore.Value)));
			foreach (global::LabApi.Features.Stores.CustomDataStore item in list)
			{
				item.Destroy();
			}
			global::NorthwoodLib.Pools.ListPool<global::LabApi.Features.Stores.CustomDataStore>.Shared.Return(list);
		}

		protected CustomDataStore(global::LabApi.Features.Wrappers.Player owner)
		{
			Owner = owner;
			InternalOnInstanceCreated();
		}

		internal void Destroy()
		{
			OnInstanceDestroyed();
			StoreInstances[GetType()].Remove(Owner);
		}

		protected virtual void OnInstanceCreated()
		{
		}

		protected virtual void OnInstanceDestroyed()
		{
		}

		private void InternalOnInstanceCreated()
		{
			OnInstanceCreated();
		}
	}
	public abstract class CustomDataStore<TStore> : global::LabApi.Features.Stores.CustomDataStore where TStore : global::LabApi.Features.Stores.CustomDataStore<TStore>
	{
		public static TStore Get(global::LabApi.Features.Wrappers.Player player)
		{
			return global::LabApi.Features.Stores.CustomDataStore.GetOrAdd<TStore>(player);
		}

		protected CustomDataStore(global::LabApi.Features.Wrappers.Player owner)
			: base(owner)
		{
		}
	}
}

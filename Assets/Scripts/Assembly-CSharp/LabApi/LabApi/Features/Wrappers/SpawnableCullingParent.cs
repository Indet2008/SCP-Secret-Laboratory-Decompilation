namespace LabApi.Features.Wrappers
{
	public class SpawnableCullingParent
	{
		public static global::System.Collections.Generic.Dictionary<global::AdminToys.SpawnableCullingParent, global::LabApi.Features.Wrappers.SpawnableCullingParent> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::AdminToys.SpawnableCullingParent, global::LabApi.Features.Wrappers.SpawnableCullingParent>();

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.SpawnableCullingParent> List => Dictionary.Values;

		public global::AdminToys.SpawnableCullingParent Base { get; }

		public global::UnityEngine.GameObject GameObject => Base.gameObject;

		public global::UnityEngine.Transform Transform => Base.transform;

		public bool IsDestroyed => Base == null;

		public global::UnityEngine.Vector3 Position
		{
			get
			{
				return Base.NetworkBoundsPosition;
			}
			set
			{
				Base.NetworkBoundsPosition = value;
			}
		}

		public global::UnityEngine.Vector3 Size
		{
			get
			{
				return Base.NetworkBoundsSize;
			}
			set
			{
				Base.NetworkBoundsSize = value;
			}
		}

		public static global::LabApi.Features.Wrappers.SpawnableCullingParent Create(global::UnityEngine.Vector3 position, global::UnityEngine.Vector3 size, bool networkSpawn = true)
		{
			if (global::LabApi.Features.Wrappers.AdminToy.PrefabCache<global::AdminToys.SpawnableCullingParent>.Prefab == null)
			{
				global::AdminToys.SpawnableCullingParent component = null;
				using (global::System.Collections.Generic.Dictionary<uint, global::UnityEngine.GameObject>.ValueCollection.Enumerator enumerator = global::Mirror.NetworkClient.prefabs.Values.GetEnumerator())
				{
					while (enumerator.MoveNext() && !enumerator.Current.TryGetComponent<global::AdminToys.SpawnableCullingParent>(out component))
					{
					}
				}
				if (component == null)
				{
					throw new global::System.InvalidOperationException($"No prefab in NetworkClient.prefabs has component type {(typeof(global::AdminToys.SpawnableCullingParent))}");
				}
				global::LabApi.Features.Wrappers.AdminToy.PrefabCache<global::AdminToys.SpawnableCullingParent>.Prefab = component;
			}
			global::AdminToys.SpawnableCullingParent spawnableCullingParent = global::UnityEngine.Object.Instantiate(global::LabApi.Features.Wrappers.AdminToy.PrefabCache<global::AdminToys.SpawnableCullingParent>.Prefab, position, global::UnityEngine.Quaternion.identity);
			spawnableCullingParent.NetworkBoundsPosition = position;
			spawnableCullingParent.NetworkBoundsSize = size;
			if (networkSpawn)
			{
				global::Mirror.NetworkServer.Spawn(spawnableCullingParent.gameObject);
			}
			return Get(spawnableCullingParent);
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("cullingBase")]
		public static global::LabApi.Features.Wrappers.SpawnableCullingParent? Get(global::AdminToys.SpawnableCullingParent? cullingBase)
		{
			if (cullingBase == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(cullingBase, out global::LabApi.Features.Wrappers.SpawnableCullingParent value))
			{
				return new global::LabApi.Features.Wrappers.SpawnableCullingParent(cullingBase);
			}
			return value;
		}

		public static bool TryGet(global::AdminToys.SpawnableCullingParent? adminToyBase, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.SpawnableCullingParent? adminToy)
		{
			adminToy = Get(adminToyBase);
			return adminToy != null;
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void Initialize()
		{
			global::AdminToys.SpawnableCullingParent.OnAdded += AddCullableParent;
			global::AdminToys.SpawnableCullingParent.OnRemoved += RemoveCullableParent;
		}

		private static void AddCullableParent(global::AdminToys.SpawnableCullingParent cullableParent)
		{
			try
			{
				if (!Dictionary.ContainsKey(cullableParent))
				{
					new global::LabApi.Features.Wrappers.SpawnableCullingParent(cullableParent);
				}
			}
			catch (global::System.Exception arg)
			{
				global::LabApi.Features.Console.Logger.InternalError($"Failed to handle cullable parent creation with error: {arg}");
			}
		}

		private static void RemoveCullableParent(global::AdminToys.SpawnableCullingParent cullableParent)
		{
			try
			{
				Dictionary.Remove(cullableParent);
			}
			catch (global::System.Exception arg)
			{
				global::LabApi.Features.Console.Logger.InternalError($"Failed to handle cullable parent destruction with error: {arg}");
			}
		}

		protected SpawnableCullingParent(global::AdminToys.SpawnableCullingParent cullingBase)
		{
			Dictionary.Add(cullingBase, this);
			Base = cullingBase;
		}

		public void Spawn()
		{
			global::Mirror.NetworkServer.Spawn(GameObject);
		}

		public void Destroy()
		{
			global::Mirror.NetworkServer.Destroy(GameObject);
		}
	}
}

namespace LabApi.Features.Wrappers
{
	public class PrimitiveObjectToy : global::LabApi.Features.Wrappers.AdminToy
	{
		public new static global::System.Collections.Generic.Dictionary<global::AdminToys.PrimitiveObjectToy, global::LabApi.Features.Wrappers.PrimitiveObjectToy> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::AdminToys.PrimitiveObjectToy, global::LabApi.Features.Wrappers.PrimitiveObjectToy>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.PrimitiveObjectToy> List => Dictionary.Values;

		public new global::AdminToys.PrimitiveObjectToy Base { get; }

		public global::UnityEngine.PrimitiveType Type
		{
			get
			{
				return Base.PrimitiveType;
			}
			set
			{
				Base.NetworkPrimitiveType = value;
			}
		}

		public global::UnityEngine.Color Color
		{
			get
			{
				return Base.MaterialColor;
			}
			set
			{
				Base.NetworkMaterialColor = value;
			}
		}

		public global::AdminToys.PrimitiveFlags Flags
		{
			get
			{
				return Base.PrimitiveFlags;
			}
			set
			{
				Base.NetworkPrimitiveFlags = value;
			}
		}

		public static global::LabApi.Features.Wrappers.PrimitiveObjectToy Create(global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(global::UnityEngine.Vector3.zero, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.PrimitiveObjectToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(position, global::UnityEngine.Quaternion.identity, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.PrimitiveObjectToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(position, rotation, global::UnityEngine.Vector3.one, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.PrimitiveObjectToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Vector3 scale, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			global::LabApi.Features.Wrappers.PrimitiveObjectToy primitiveObjectToy = Get(global::LabApi.Features.Wrappers.AdminToy.Create<global::AdminToys.PrimitiveObjectToy>(position, rotation, scale, parent));
			if (networkSpawn)
			{
				primitiveObjectToy.Spawn();
			}
			return primitiveObjectToy;
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("primitiveObjectToy")]
		public static global::LabApi.Features.Wrappers.PrimitiveObjectToy? Get(global::AdminToys.PrimitiveObjectToy? primitiveObjectToy)
		{
			if (primitiveObjectToy == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(primitiveObjectToy, out global::LabApi.Features.Wrappers.PrimitiveObjectToy value))
			{
				return (global::LabApi.Features.Wrappers.PrimitiveObjectToy)global::LabApi.Features.Wrappers.AdminToy.CreateAdminToyWrapper(primitiveObjectToy);
			}
			return value;
		}

		public static bool TryGet(global::AdminToys.PrimitiveObjectToy? basePrimitiveObjectToy, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.PrimitiveObjectToy? primitiveObjectToy)
		{
			primitiveObjectToy = Get(basePrimitiveObjectToy);
			return primitiveObjectToy != null;
		}

		internal PrimitiveObjectToy(global::AdminToys.PrimitiveObjectToy basePrimitiveObjectToy)
			: base(basePrimitiveObjectToy)
		{
			Base = basePrimitiveObjectToy;
			if (base.CanCache)
			{
				Dictionary.Add(basePrimitiveObjectToy, this);
			}
		}

		public override string ToString()
		{
			return $"[PrimitiveObjectToy: Type={Type}, Color={Color}, Flags={Flags}]";
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}

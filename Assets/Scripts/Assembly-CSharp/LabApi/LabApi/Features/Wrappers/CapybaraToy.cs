namespace LabApi.Features.Wrappers
{
	public class CapybaraToy : global::LabApi.Features.Wrappers.AdminToy
	{
		public new static global::System.Collections.Generic.Dictionary<global::AdminToys.CapybaraToy, global::LabApi.Features.Wrappers.CapybaraToy> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::AdminToys.CapybaraToy, global::LabApi.Features.Wrappers.CapybaraToy>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.CapybaraToy> List => Dictionary.Values;

		public new global::AdminToys.CapybaraToy Base { get; }

		public bool CollidersEnabled
		{
			get
			{
				return Base.CollisionsEnabled;
			}
			set
			{
				Base.CollisionsEnabled = value;
			}
		}

		public static global::LabApi.Features.Wrappers.CapybaraToy Create(global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(global::UnityEngine.Vector3.zero, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.CapybaraToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(position, global::UnityEngine.Quaternion.identity, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.CapybaraToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(position, rotation, global::UnityEngine.Vector3.one, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.CapybaraToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Vector3 scale, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			global::LabApi.Features.Wrappers.CapybaraToy capybaraToy = Get(global::LabApi.Features.Wrappers.AdminToy.Create<global::AdminToys.CapybaraToy>(position, rotation, scale, parent));
			if (networkSpawn)
			{
				capybaraToy.Spawn();
			}
			return capybaraToy;
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseCapybaraToy")]
		public static global::LabApi.Features.Wrappers.CapybaraToy? Get(global::AdminToys.CapybaraToy? baseCapybaraToy)
		{
			if (baseCapybaraToy == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseCapybaraToy, out global::LabApi.Features.Wrappers.CapybaraToy value))
			{
				return (global::LabApi.Features.Wrappers.CapybaraToy)global::LabApi.Features.Wrappers.AdminToy.CreateAdminToyWrapper(baseCapybaraToy);
			}
			return value;
		}

		internal CapybaraToy(global::AdminToys.CapybaraToy baseCapybaraToy)
			: base(baseCapybaraToy)
		{
			Base = baseCapybaraToy;
			if (base.CanCache)
			{
				Dictionary.Add(baseCapybaraToy, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}

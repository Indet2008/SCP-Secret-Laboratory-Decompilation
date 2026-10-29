namespace LabApi.Features.Wrappers
{
	public class TextToy : global::LabApi.Features.Wrappers.AdminToy
	{
		public new static global::System.Collections.Generic.Dictionary<global::AdminToys.TextToy, global::LabApi.Features.Wrappers.TextToy> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::AdminToys.TextToy, global::LabApi.Features.Wrappers.TextToy>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.TextToy> List => Dictionary.Values;

		public new global::AdminToys.TextToy Base { get; }

		public string TextFormat
		{
			get
			{
				return Base.TextFormat;
			}
			set
			{
				Base.TextFormat = value;
			}
		}

		public global::UnityEngine.Vector2 DisplaySize
		{
			get
			{
				return Base.DisplaySize;
			}
			set
			{
				Base.DisplaySize = value;
			}
		}

		public global::Mirror.SyncList<string> Arguments => Base.Arguments;

		public static global::LabApi.Features.Wrappers.TextToy Create(global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(global::UnityEngine.Vector3.zero, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.TextToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(position, global::UnityEngine.Quaternion.identity, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.TextToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(position, rotation, global::UnityEngine.Vector3.one, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.TextToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Vector3 scale, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			global::LabApi.Features.Wrappers.TextToy textToy = Get(global::LabApi.Features.Wrappers.AdminToy.Create<global::AdminToys.TextToy>(position, rotation, scale, parent));
			if (networkSpawn)
			{
				textToy.Spawn();
			}
			return textToy;
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseTextToy")]
		public static global::LabApi.Features.Wrappers.TextToy? Get(global::AdminToys.TextToy? baseTextToy)
		{
			if (baseTextToy == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseTextToy, out global::LabApi.Features.Wrappers.TextToy value))
			{
				return (global::LabApi.Features.Wrappers.TextToy)global::LabApi.Features.Wrappers.AdminToy.CreateAdminToyWrapper(baseTextToy);
			}
			return value;
		}

		public static bool TryGet(global::AdminToys.TextToy? baseTextToy, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.TextToy? textToy)
		{
			textToy = Get(baseTextToy);
			return textToy != null;
		}

		internal TextToy(global::AdminToys.TextToy baseToy)
			: base(baseToy)
		{
			Base = baseToy;
			if (base.CanCache)
			{
				Dictionary.Add(baseToy, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}

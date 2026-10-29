namespace LabApi.Features.Wrappers
{
	public class LightSourceToy : global::LabApi.Features.Wrappers.AdminToy
	{
		public new static global::System.Collections.Generic.Dictionary<global::AdminToys.LightSourceToy, global::LabApi.Features.Wrappers.LightSourceToy> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::AdminToys.LightSourceToy, global::LabApi.Features.Wrappers.LightSourceToy>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.LightSourceToy> List => Dictionary.Values;

		public new global::AdminToys.LightSourceToy Base { get; }

		public float Intensity
		{
			get
			{
				return Base.LightIntensity;
			}
			set
			{
				Base.NetworkLightIntensity = value;
			}
		}

		public float Range
		{
			get
			{
				return Base.LightRange;
			}
			set
			{
				Base.NetworkLightRange = value;
			}
		}

		public global::UnityEngine.Color Color
		{
			get
			{
				return Base.LightColor;
			}
			set
			{
				Base.NetworkLightColor = value;
			}
		}

		public global::UnityEngine.LightShadows ShadowType
		{
			get
			{
				return Base.ShadowType;
			}
			set
			{
				Base.NetworkShadowType = value;
			}
		}

		public float ShadowStrength
		{
			get
			{
				return Base.ShadowStrength;
			}
			set
			{
				Base.NetworkShadowStrength = value;
			}
		}

		public global::UnityEngine.LightType Type
		{
			get
			{
				return Base.LightType;
			}
			set
			{
				Base.NetworkLightType = value;
			}
		}

		public global::UnityEngine.LightShape Shape
		{
			get
			{
				return Base.LightShape;
			}
			set
			{
				Base.NetworkLightShape = value;
			}
		}

		public float SpotAngle
		{
			get
			{
				return Base.SpotAngle;
			}
			set
			{
				Base.NetworkSpotAngle = value;
			}
		}

		public float InnerSpotAngle
		{
			get
			{
				return Base.InnerSpotAngle;
			}
			set
			{
				Base.NetworkInnerSpotAngle = value;
			}
		}

		public static global::LabApi.Features.Wrappers.LightSourceToy Create(global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(global::UnityEngine.Vector3.zero, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.LightSourceToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(position, global::UnityEngine.Quaternion.identity, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.LightSourceToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(position, rotation, global::UnityEngine.Vector3.one, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.LightSourceToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Vector3 scale, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			global::LabApi.Features.Wrappers.LightSourceToy lightSourceToy = Get(global::LabApi.Features.Wrappers.AdminToy.Create<global::AdminToys.LightSourceToy>(position, rotation, scale, parent));
			if (networkSpawn)
			{
				lightSourceToy.Spawn();
			}
			return lightSourceToy;
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseLightSourceToy")]
		public static global::LabApi.Features.Wrappers.LightSourceToy? Get(global::AdminToys.LightSourceToy? baseLightSourceToy)
		{
			if (baseLightSourceToy == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseLightSourceToy, out global::LabApi.Features.Wrappers.LightSourceToy value))
			{
				return (global::LabApi.Features.Wrappers.LightSourceToy)global::LabApi.Features.Wrappers.AdminToy.CreateAdminToyWrapper(baseLightSourceToy);
			}
			return value;
		}

		public static bool TryGet(global::AdminToys.LightSourceToy? baseLightSourceToy, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.LightSourceToy? lightSourceToy)
		{
			lightSourceToy = Get(baseLightSourceToy);
			return lightSourceToy != null;
		}

		internal LightSourceToy(global::AdminToys.LightSourceToy baseLightSourceToy)
			: base(baseLightSourceToy)
		{
			Base = baseLightSourceToy;
			if (base.CanCache)
			{
				Dictionary.Add(baseLightSourceToy, this);
			}
		}

		public override string ToString()
		{
			return $"[LightSourceToy: Type={Type}, Shape={Shape}, Intensity={Intensity}, Range={Range}, Color={Color}, ShadowType={ShadowType}, ShadowStrength={ShadowStrength}]";
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}

namespace LabApi.Features.Wrappers
{
	public class Hazard
	{
		private static readonly global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Func<global::Hazards.EnvironmentalHazard, global::LabApi.Features.Wrappers.Hazard>> TypeWrappers = new global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Func<global::Hazards.EnvironmentalHazard, global::LabApi.Features.Wrappers.Hazard>>();

		public static global::System.Collections.Generic.Dictionary<global::Hazards.EnvironmentalHazard, global::LabApi.Features.Wrappers.Hazard> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::Hazards.EnvironmentalHazard, global::LabApi.Features.Wrappers.Hazard>();

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Hazard> List => Dictionary.Values;

		protected static global::Hazards.EnvironmentalHazard? BasePrefab { get; private set; }

		public global::Hazards.EnvironmentalHazard Base { get; private set; }

		public global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Player> AffectedPlayers => global::System.Linq.Enumerable.Select(Base.AffectedPlayers, (ReferenceHub n) => global::LabApi.Features.Wrappers.Player.Get(n));

		public float MaxDistance
		{
			get
			{
				return Base.MaxDistance;
			}
			set
			{
				Base.MaxDistance = value;
			}
		}

		public float MaxHeightDistance
		{
			get
			{
				return Base.MaxHeightDistance;
			}
			set
			{
				Base.MaxHeightDistance = value;
			}
		}

		public virtual global::UnityEngine.Vector3 SourceOffset
		{
			get
			{
				return Base.SourceOffset;
			}
			set
			{
				Base.SourceOffset = value;
			}
		}

		public virtual bool IsActive
		{
			get
			{
				return Base.IsActive;
			}
			set
			{
				Base.IsActive = value;
			}
		}

		public virtual global::UnityEngine.Vector3 SourcePosition
		{
			get
			{
				return Base.SourcePosition;
			}
			set
			{
				Base.SourcePosition = value;
			}
		}

		public bool IsDestroyed
		{
			get
			{
				if (!(Base == null))
				{
					return Base.gameObject == null;
				}
				return true;
			}
		}

		public global::LabApi.Features.Wrappers.Room? Room => global::LabApi.Features.Wrappers.Room.GetRoomAtPosition(SourcePosition);

		protected bool CanCache
		{
			get
			{
				if (!IsDestroyed)
				{
					return Base.isActiveAndEnabled;
				}
				return false;
			}
		}

		public static global::LabApi.Features.Wrappers.Hazard Spawn(global::Hazards.EnvironmentalHazard prefab, global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Vector3 scale)
		{
			global::Hazards.EnvironmentalHazard environmentalHazard = global::UnityEngine.Object.Instantiate(prefab);
			environmentalHazard.transform.SetPositionAndRotation(position, rotation);
			environmentalHazard.transform.localScale = scale;
			return Get(environmentalHazard);
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("hazard")]
		public static global::LabApi.Features.Wrappers.Hazard? Get(global::Hazards.EnvironmentalHazard? hazard)
		{
			if (hazard == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(hazard, out global::LabApi.Features.Wrappers.Hazard value))
			{
				return CreateItemWrapper(hazard);
			}
			return value;
		}

		public static bool TryGet(global::Hazards.EnvironmentalHazard? envHazard, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.Hazard? wrapper)
		{
			wrapper = Get(envHazard);
			return wrapper != null;
		}

		public static global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Hazard> Get(global::LabApi.Features.Wrappers.Room? room)
		{
			if (room == null)
			{
				yield break;
			}
			foreach (global::LabApi.Features.Wrappers.Hazard item in List)
			{
				if (item.Room == room)
				{
					yield return item;
				}
			}
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void Initialize()
		{
			Dictionary.Clear();
			global::Hazards.EnvironmentalHazard.OnAdded = (global::System.Action<global::Hazards.EnvironmentalHazard>)global::System.Delegate.Combine(global::Hazards.EnvironmentalHazard.OnAdded, new global::System.Action<global::Hazards.EnvironmentalHazard>(AddHazard));
			global::Hazards.EnvironmentalHazard.OnRemoved = (global::System.Action<global::Hazards.EnvironmentalHazard>)global::System.Delegate.Combine(global::Hazards.EnvironmentalHazard.OnRemoved, new global::System.Action<global::Hazards.EnvironmentalHazard>(RemoveHazard));
			Register((global::Hazards.SinkholeEnvironmentalHazard x) => new global::LabApi.Features.Wrappers.SinkholeHazard(x));
			Register((global::Hazards.TantrumEnvironmentalHazard x) => new global::LabApi.Features.Wrappers.TantrumHazard(x));
			Register((global::PlayerRoles.PlayableScps.Scp939.Scp939AmnesticCloudInstance x) => new global::LabApi.Features.Wrappers.AmnesticCloudHazard(x));
		}

		protected static global::LabApi.Features.Wrappers.Hazard? CreateItemWrapper(global::Hazards.EnvironmentalHazard hazard)
		{
			global::System.Type type = hazard.GetType();
			if (!TypeWrappers.TryGetValue(type, out global::System.Func<global::Hazards.EnvironmentalHazard, global::LabApi.Features.Wrappers.Hazard> value))
			{
				return new global::LabApi.Features.Wrappers.Hazard(hazard);
			}
			return value(hazard);
		}

		protected static T? GetPrefab<T>() where T : global::Hazards.EnvironmentalHazard
		{
			foreach (global::UnityEngine.GameObject value in global::Mirror.NetworkClient.prefabs.Values)
			{
				if (value.TryGetComponent<T>(out var component))
				{
					return component;
				}
			}
			return null;
		}

		private static void AddHazard(global::Hazards.EnvironmentalHazard hazard)
		{
			if (!Dictionary.ContainsKey(hazard))
			{
				CreateItemWrapper(hazard);
			}
		}

		private static void RemoveHazard(global::Hazards.EnvironmentalHazard hazard)
		{
			if (Dictionary.Remove(hazard, out global::LabApi.Features.Wrappers.Hazard value))
			{
				value.OnRemove();
			}
		}

		private static void Register<T>(global::System.Func<T, global::LabApi.Features.Wrappers.Hazard> constructor) where T : global::Hazards.EnvironmentalHazard
		{
			TypeWrappers.Add(typeof(T), (global::Hazards.EnvironmentalHazard x) => constructor((T)x));
		}

		protected Hazard(global::Hazards.EnvironmentalHazard hazard)
		{
			Base = hazard;
			if (CanCache)
			{
				Dictionary.Add(hazard, this);
			}
		}

		public override string ToString()
		{
			return $"[{GetType().Name}: MaxDistance={MaxDistance}, MaxHeightDistance={MaxHeightDistance}, SourcePosition={SourcePosition}, SourceOffset={SourceOffset}, IsActive={IsActive}, IsDestroyed={IsDestroyed}]";
		}

		public bool IsInArea(global::LabApi.Features.Wrappers.Player player)
		{
			return Base.IsInArea(SourcePosition, player.Position);
		}

		public virtual void Destroy()
		{
			if (Base.gameObject != null)
			{
				global::Mirror.NetworkServer.Destroy(Base.gameObject);
			}
		}

		internal virtual void OnRemove()
		{
		}
	}
}

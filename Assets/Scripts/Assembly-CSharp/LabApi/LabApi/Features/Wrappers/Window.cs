namespace LabApi.Features.Wrappers
{
	public class Window
	{
		public static global::System.Collections.Generic.Dictionary<BreakableWindow, global::LabApi.Features.Wrappers.Window> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<BreakableWindow, global::LabApi.Features.Wrappers.Window>();

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Window> List => Dictionary.Values;

		public BreakableWindow Base { get; }

		public global::UnityEngine.GameObject GameObject => Base.gameObject;

		public global::UnityEngine.Transform Transform => Base.transform;

		protected internal bool CanCache
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

		public bool IsDestroyed
		{
			get
			{
				if (!(Base == null))
				{
					return GameObject == null;
				}
				return true;
			}
		}

		public bool IsBroken => Base.NetworkIsBroken;

		public float Health
		{
			get
			{
				return Base.Health;
			}
			set
			{
				Base.Damage(Base.Health - value, new global::PlayerStatsSystem.CustomReasonDamageHandler(string.Empty), global::UnityEngine.Vector3.zero);
			}
		}

		public global::UnityEngine.Vector3 Position => Transform.position;

		public global::UnityEngine.Quaternion Rotation => Transform.rotation;

		[global::Generators.InitializeWrapper(128)]
		internal static void Initialize()
		{
			BreakableWindow.OnAdded = (global::System.Action<BreakableWindow>)global::System.Delegate.Combine(BreakableWindow.OnAdded, new global::System.Action<BreakableWindow>(OnAdded));
			BreakableWindow.OnDestroyed = (global::System.Action<BreakableWindow>)global::System.Delegate.Combine(BreakableWindow.OnDestroyed, new global::System.Action<BreakableWindow>(OnRemoved));
		}

		internal Window(BreakableWindow breakableWindow)
		{
			Base = breakableWindow;
			if (CanCache)
			{
				Dictionary.Add(breakableWindow, this);
			}
		}

		internal virtual void OnRemove()
		{
			Dictionary.Remove(Base);
		}

		public override string ToString()
		{
			return $"[{GetType().Name}: Position={Position}, Rotation={Rotation} IsDestroyed={IsDestroyed}]";
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("breakableWindow")]
		public static global::LabApi.Features.Wrappers.Window? Get(BreakableWindow? breakableWindow)
		{
			if (breakableWindow == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(breakableWindow, out global::LabApi.Features.Wrappers.Window value))
			{
				return new global::LabApi.Features.Wrappers.Window(breakableWindow);
			}
			return value;
		}

		public static bool TryGet(BreakableWindow? breakableWindow, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.Window? window)
		{
			window = Get(breakableWindow);
			return window != null;
		}

		private static void OnAdded(BreakableWindow structure)
		{
			if (!Dictionary.ContainsKey(structure))
			{
				new global::LabApi.Features.Wrappers.Window(structure);
			}
		}

		private static void OnRemoved(BreakableWindow spawnableStructure)
		{
			if (Dictionary.TryGetValue(spawnableStructure, out global::LabApi.Features.Wrappers.Window value))
			{
				value.OnRemove();
			}
		}
	}
}

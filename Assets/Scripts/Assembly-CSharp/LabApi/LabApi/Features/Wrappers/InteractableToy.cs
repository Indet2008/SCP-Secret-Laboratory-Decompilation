namespace LabApi.Features.Wrappers
{
	public class InteractableToy : global::LabApi.Features.Wrappers.AdminToy
	{
		public new static global::System.Collections.Generic.Dictionary<global::AdminToys.InvisibleInteractableToy, global::LabApi.Features.Wrappers.InteractableToy> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::AdminToys.InvisibleInteractableToy, global::LabApi.Features.Wrappers.InteractableToy>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.InteractableToy> List => Dictionary.Values;

		public new global::AdminToys.InvisibleInteractableToy Base { get; }

		public global::AdminToys.InvisibleInteractableToy.ColliderShape Shape
		{
			get
			{
				return Base.Shape;
			}
			set
			{
				Base.NetworkShape = value;
			}
		}

		public float InteractionDuration
		{
			get
			{
				return Base.InteractionDuration;
			}
			set
			{
				Base.NetworkInteractionDuration = value;
			}
		}

		public bool IsLocked
		{
			get
			{
				return Base.IsLocked;
			}
			set
			{
				Base.NetworkIsLocked = value;
			}
		}

		public bool CanSearch => Base.CanSearch;

		public event global::System.Action<global::LabApi.Features.Wrappers.Player> OnInteracted
		{
			add
			{
				if (InternalOnInteracted == null)
				{
					Base.OnInteracted += InvokeOnInteracted;
				}
				InternalOnInteracted += value;
			}
			remove
			{
				InternalOnInteracted -= value;
				if (InternalOnInteracted == null)
				{
					Base.OnInteracted -= InvokeOnInteracted;
				}
			}
		}

		public event global::System.Action<global::LabApi.Features.Wrappers.Player> OnSearching
		{
			add
			{
				if (InternalOnSearching == null)
				{
					Base.OnSearching += InvokeOnSearching;
				}
				InternalOnSearching += value;
			}
			remove
			{
				InternalOnSearching -= value;
				if (InternalOnSearching == null)
				{
					Base.OnSearching -= InvokeOnSearching;
				}
			}
		}

		public event global::System.Action<global::LabApi.Features.Wrappers.Player> OnSearched
		{
			add
			{
				if (InternalOnSearched == null)
				{
					Base.OnSearched += InvokeOnSearched;
				}
				InternalOnSearched += value;
			}
			remove
			{
				InternalOnSearched -= value;
				if (InternalOnSearched == null)
				{
					Base.OnSearched -= InvokeOnSearched;
				}
			}
		}

		public event global::System.Action<global::LabApi.Features.Wrappers.Player> OnSearchAborted
		{
			add
			{
				if (InternalOnSearchAborted == null)
				{
					Base.OnSearched += InvokeOnSearchAborted;
				}
				InternalOnSearchAborted += value;
			}
			remove
			{
				InternalOnSearchAborted -= value;
				if (InternalOnSearchAborted == null)
				{
					Base.OnSearched -= InvokeOnSearchAborted;
				}
			}
		}

		private event global::System.Action<global::LabApi.Features.Wrappers.Player>? InternalOnInteracted;

		private event global::System.Action<global::LabApi.Features.Wrappers.Player>? InternalOnSearching;

		private event global::System.Action<global::LabApi.Features.Wrappers.Player>? InternalOnSearched;

		private event global::System.Action<global::LabApi.Features.Wrappers.Player>? InternalOnSearchAborted;

		public static global::LabApi.Features.Wrappers.InteractableToy Create(global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(global::UnityEngine.Vector3.zero, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.InteractableToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(position, global::UnityEngine.Quaternion.identity, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.InteractableToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(position, rotation, global::UnityEngine.Vector3.one, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.InteractableToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Vector3 scale, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			global::LabApi.Features.Wrappers.InteractableToy interactableToy = Get(global::LabApi.Features.Wrappers.AdminToy.Create<global::AdminToys.InvisibleInteractableToy>(position, rotation, scale, parent));
			if (networkSpawn)
			{
				interactableToy.Spawn();
			}
			return interactableToy;
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseInteractableToy")]
		public static global::LabApi.Features.Wrappers.InteractableToy? Get(global::AdminToys.InvisibleInteractableToy? baseInteractableToy)
		{
			if (baseInteractableToy == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseInteractableToy, out global::LabApi.Features.Wrappers.InteractableToy value))
			{
				return (global::LabApi.Features.Wrappers.InteractableToy)global::LabApi.Features.Wrappers.AdminToy.CreateAdminToyWrapper(baseInteractableToy);
			}
			return value;
		}

		public static bool TryGet(global::AdminToys.InvisibleInteractableToy? baseInteractableToy, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.InteractableToy? interactableToy)
		{
			interactableToy = Get(baseInteractableToy);
			return interactableToy != null;
		}

		internal InteractableToy(global::AdminToys.InvisibleInteractableToy baseInteractableToy)
			: base(baseInteractableToy)
		{
			Base = baseInteractableToy;
			if (base.CanCache)
			{
				Dictionary.Add(baseInteractableToy, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}

		private void InvokeOnInteracted(ReferenceHub hub)
		{
			InternalOnInteracted?.Invoke(global::LabApi.Features.Wrappers.Player.Get(hub));
		}

		private void InvokeOnSearching(ReferenceHub hub)
		{
			InternalOnSearching?.Invoke(global::LabApi.Features.Wrappers.Player.Get(hub));
		}

		private void InvokeOnSearched(ReferenceHub hub)
		{
			InternalOnSearched?.Invoke(global::LabApi.Features.Wrappers.Player.Get(hub));
		}

		private void InvokeOnSearchAborted(ReferenceHub hub)
		{
			InternalOnSearchAborted?.Invoke(global::LabApi.Features.Wrappers.Player.Get(hub));
		}
	}
}

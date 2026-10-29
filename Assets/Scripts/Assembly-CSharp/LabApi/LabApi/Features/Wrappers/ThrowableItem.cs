namespace LabApi.Features.Wrappers
{
	public class ThrowableItem : global::LabApi.Features.Wrappers.Item
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.ThrowableItem, global::LabApi.Features.Wrappers.ThrowableItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.ThrowableItem, global::LabApi.Features.Wrappers.ThrowableItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.ThrowableItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.ThrowableProjectiles.ThrowableItem Base { get; }

		public float WeakThrowStartVelocity
		{
			get
			{
				return Base.WeakThrowSettings.StartVelocity;
			}
			set
			{
				Base.WeakThrowSettings.StartVelocity = value;
			}
		}

		public float WeakThrowUpwardsFactor
		{
			get
			{
				return Base.WeakThrowSettings.UpwardsFactor;
			}
			set
			{
				Base.WeakThrowSettings.UpwardsFactor = value;
			}
		}

		public global::UnityEngine.Vector3 WeakThrowStartTorque
		{
			get
			{
				return Base.WeakThrowSettings.StartTorque;
			}
			set
			{
				Base.WeakThrowSettings.StartTorque = value;
			}
		}

		public global::UnityEngine.Vector3 WeakThrowRelativePosition
		{
			get
			{
				return Base.WeakThrowSettings.RelativePosition;
			}
			set
			{
				Base.WeakThrowSettings.RelativePosition = value;
			}
		}

		public float FullThrowStartVelocity
		{
			get
			{
				return Base.FullThrowSettings.StartVelocity;
			}
			set
			{
				Base.FullThrowSettings.StartVelocity = value;
			}
		}

		public float FullThrowUpwardsFactor
		{
			get
			{
				return Base.FullThrowSettings.UpwardsFactor;
			}
			set
			{
				Base.FullThrowSettings.UpwardsFactor = value;
			}
		}

		public global::UnityEngine.Vector3 FullThrowStartTorque
		{
			get
			{
				return Base.FullThrowSettings.StartTorque;
			}
			set
			{
				Base.FullThrowSettings.StartTorque = value;
			}
		}

		public global::UnityEngine.Vector3 FullThrowRelativePosition
		{
			get
			{
				return Base.FullThrowSettings.StartTorque;
			}
			set
			{
				Base.FullThrowSettings.StartTorque = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseThrowableItem")]
		public static global::LabApi.Features.Wrappers.ThrowableItem? Get(global::InventorySystem.Items.ThrowableProjectiles.ThrowableItem? baseThrowableItem)
		{
			if (baseThrowableItem == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseThrowableItem, out global::LabApi.Features.Wrappers.ThrowableItem value))
			{
				return (global::LabApi.Features.Wrappers.ThrowableItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(baseThrowableItem);
			}
			return value;
		}

		internal ThrowableItem(global::InventorySystem.Items.ThrowableProjectiles.ThrowableItem baseThrowableItem)
			: base(baseThrowableItem)
		{
			Base = baseThrowableItem;
			if (base.CanCache)
			{
				Dictionary.Add(baseThrowableItem, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}

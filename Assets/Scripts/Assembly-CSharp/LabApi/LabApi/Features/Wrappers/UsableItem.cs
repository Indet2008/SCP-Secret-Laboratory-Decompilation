namespace LabApi.Features.Wrappers
{
	public class UsableItem : global::LabApi.Features.Wrappers.Item
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.UsableItem, global::LabApi.Features.Wrappers.UsableItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.UsableItem, global::LabApi.Features.Wrappers.UsableItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.UsableItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.Usables.UsableItem Base { get; }

		public bool IsUsing
		{
			get
			{
				return Base.IsUsing;
			}
			set
			{
				global::InventorySystem.Items.Usables.UsableItemsController.ServerEmulateMessage(base.Serial, (!value) ? global::InventorySystem.Items.Usables.StatusMessage.StatusType.Cancel : global::InventorySystem.Items.Usables.StatusMessage.StatusType.Start);
			}
		}

		public float UseDuration
		{
			get
			{
				return Base.UseTime;
			}
			set
			{
				Base.UseTime = value;
			}
		}

		public float MaxCancellableDuration
		{
			get
			{
				return Base.MaxCancellableTime;
			}
			set
			{
				Base.MaxCancellableTime = value;
			}
		}

		public float GlobalCooldownDuration
		{
			get
			{
				if (!global::InventorySystem.Items.Usables.UsableItemsController.GlobalItemCooldowns.TryGetValue(base.Serial, out var value))
				{
					return 0f;
				}
				return value - global::UnityEngine.Time.timeSinceLevelLoad;
			}
			set
			{
				global::InventorySystem.Items.Usables.UsableItemsController.GlobalItemCooldowns[base.Serial] = global::UnityEngine.Time.timeSinceLevelLoad + value;
			}
		}

		public float PersonalCooldownDuration
		{
			get
			{
				if (base.CurrentOwner?.ReferenceHub == null || !global::InventorySystem.Items.Usables.UsableItemsController.GetHandler(base.CurrentOwner.ReferenceHub).PersonalCooldowns.TryGetValue(base.Type, out var value))
				{
					return 0f;
				}
				return value - global::UnityEngine.Time.timeSinceLevelLoad;
			}
			set
			{
				if (base.CurrentOwner?.ReferenceHub != null)
				{
					global::InventorySystem.Items.Usables.UsableItemsController.GetHandler(base.CurrentOwner.ReferenceHub).PersonalCooldowns[base.Type] = global::UnityEngine.Time.timeSinceLevelLoad + value;
				}
			}
		}

		public bool CanClientStartUsing => Base.CanStartUsing;

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseUsableItem")]
		public static global::LabApi.Features.Wrappers.UsableItem? Get(global::InventorySystem.Items.Usables.UsableItem? baseUsableItem)
		{
			if (baseUsableItem == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseUsableItem, out global::LabApi.Features.Wrappers.UsableItem value))
			{
				return (global::LabApi.Features.Wrappers.UsableItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(baseUsableItem);
			}
			return value;
		}

		internal UsableItem(global::InventorySystem.Items.Usables.UsableItem baseUsableItem)
			: base(baseUsableItem)
		{
			Base = baseUsableItem;
			if (base.CanCache)
			{
				Dictionary.Add(baseUsableItem, this);
			}
		}

		public void Use()
		{
			Base.ServerOnUsingCompleted();
		}

		public bool TryGetSoundEmissionRange(out float range)
		{
			return Base.TryGetSoundEmissionRange(out range);
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}

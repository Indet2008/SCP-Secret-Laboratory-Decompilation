namespace LabApi.Features.Wrappers
{
	public class LightItem : global::LabApi.Features.Wrappers.Item
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ToggleableLights.ToggleableLightItemBase, global::LabApi.Features.Wrappers.LightItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ToggleableLights.ToggleableLightItemBase, global::LabApi.Features.Wrappers.LightItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.LightItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.ToggleableLights.ToggleableLightItemBase Base { get; }

		public bool IsEmitting
		{
			get
			{
				return Base.IsEmittingLight;
			}
			set
			{
				global::Utils.Networking.NetworkUtils.SendToAuthenticated(new global::InventorySystem.Items.ToggleableLights.FlashlightNetworkHandler.FlashlightMessage(base.Serial, value));
				Base.IsEmittingLight = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("toggleableLight")]
		public static global::LabApi.Features.Wrappers.LightItem? Get(global::InventorySystem.Items.ToggleableLights.ToggleableLightItemBase? toggleableLight)
		{
			if (toggleableLight == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(toggleableLight, out global::LabApi.Features.Wrappers.LightItem value))
			{
				return (global::LabApi.Features.Wrappers.LightItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(toggleableLight);
			}
			return value;
		}

		internal LightItem(global::InventorySystem.Items.ToggleableLights.ToggleableLightItemBase toggleableLightItemBase)
			: base(toggleableLightItemBase)
		{
			Base = toggleableLightItemBase;
			if (base.CanCache)
			{
				Dictionary.Add(toggleableLightItemBase, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}

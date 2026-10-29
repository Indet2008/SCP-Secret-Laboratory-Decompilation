namespace LabApi.Features.Wrappers
{
	public class MicroPedestal : global::LabApi.Features.Wrappers.Locker
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.MicroHID.MicroHIDPedestal, global::LabApi.Features.Wrappers.MicroPedestal> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.MicroHID.MicroHIDPedestal, global::LabApi.Features.Wrappers.MicroPedestal>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.MicroPedestal> List => Dictionary.Values;

		public new global::InventorySystem.Items.MicroHID.MicroHIDPedestal Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("basePedestal")]
		public static global::LabApi.Features.Wrappers.MicroPedestal? Get(global::InventorySystem.Items.MicroHID.MicroHIDPedestal? basePedestal)
		{
			if (basePedestal == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(basePedestal, out global::LabApi.Features.Wrappers.MicroPedestal value))
			{
				return (global::LabApi.Features.Wrappers.MicroPedestal)global::LabApi.Features.Wrappers.Structure.CreateStructureWrapper(basePedestal);
			}
			return value;
		}

		internal MicroPedestal(global::InventorySystem.Items.MicroHID.MicroHIDPedestal pedestal)
			: base(pedestal)
		{
			Base = pedestal;
			if (base.CanCache)
			{
				Dictionary.Add(pedestal, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}

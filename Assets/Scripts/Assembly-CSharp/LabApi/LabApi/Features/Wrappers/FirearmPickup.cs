namespace LabApi.Features.Wrappers
{
	public class FirearmPickup : global::LabApi.Features.Wrappers.Pickup
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Firearms.FirearmPickup, global::LabApi.Features.Wrappers.FirearmPickup> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Firearms.FirearmPickup, global::LabApi.Features.Wrappers.FirearmPickup>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.FirearmPickup> List => Dictionary.Values;

		public new global::InventorySystem.Items.Firearms.FirearmPickup Base { get; }

		public uint AttachmentCode
		{
			get
			{
				if (!global::InventorySystem.Items.Firearms.Attachments.AttachmentCodeSync.TryGet(base.Serial, out var code))
				{
					return 0u;
				}
				return code;
			}
			set
			{
				global::InventorySystem.Items.Firearms.Attachments.AttachmentCodeSync.AttachmentCodeMessage message = new global::InventorySystem.Items.Firearms.Attachments.AttachmentCodeSync.AttachmentCodeMessage(base.Serial, value);
				global::Utils.Networking.NetworkUtils.SendToAuthenticated(message);
				message.Apply();
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("pickup")]
		public static global::LabApi.Features.Wrappers.FirearmPickup? Get(global::InventorySystem.Items.Firearms.FirearmPickup? pickup)
		{
			if (pickup == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(pickup, out global::LabApi.Features.Wrappers.FirearmPickup value))
			{
				return (global::LabApi.Features.Wrappers.FirearmPickup)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(pickup);
			}
			return value;
		}

		internal FirearmPickup(global::InventorySystem.Items.Firearms.FirearmPickup baseFirearmPickup)
			: base(baseFirearmPickup)
		{
			Base = baseFirearmPickup;
			if (base.CanCache)
			{
				Dictionary.Add(baseFirearmPickup, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}

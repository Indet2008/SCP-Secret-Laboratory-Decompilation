namespace LabApi.Features.Wrappers
{
	public class FirearmItem : global::LabApi.Features.Wrappers.Item
	{
		private static readonly global::System.Collections.Generic.Dictionary<ItemType, global::System.Func<global::InventorySystem.Items.Firearms.Firearm, global::LabApi.Features.Wrappers.FirearmItem>> TypeWrappers = new global::System.Collections.Generic.Dictionary<ItemType, global::System.Func<global::InventorySystem.Items.Firearms.Firearm, global::LabApi.Features.Wrappers.FirearmItem>>();

		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Firearms.Firearm, global::LabApi.Features.Wrappers.FirearmItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Firearms.Firearm, global::LabApi.Features.Wrappers.FirearmItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.FirearmItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.Firearms.Firearm Base { get; }

		public new float Weight => Base.Weight;

		public float Length => Base.Length;

		public float BaseWeight => Base.BaseLength;

		public float BaseLength => Base.BaseLength;

		public bool IsReloading => ReloaderModule.IsReloading;

		public bool IsUnloading => ReloaderModule.IsUnloading;

		public bool IsReloadingOrUnloading => ReloaderModule.IsReloadingOrUnloading;

		public bool CanReload
		{
			get
			{
				if (global::InventorySystem.Items.Firearms.Modules.IReloadUnloadValidatorModule.ValidateReload(Base))
				{
					return !IsReloadingOrUnloading;
				}
				return false;
			}
		}

		public bool CanUnload
		{
			get
			{
				if (global::InventorySystem.Items.Firearms.Modules.IReloadUnloadValidatorModule.ValidateUnload(Base))
				{
					return !IsReloadingOrUnloading;
				}
				return false;
			}
		}

		public ItemType AmmoType
		{
			get
			{
				if (AmmoContainerModule == null)
				{
					return ItemType.None;
				}
				return AmmoContainerModule.AmmoType;
			}
		}

		public virtual bool Cocked
		{
			get
			{
				if (ActionModule is global::InventorySystem.Items.Firearms.Modules.AutomaticActionModule automaticActionModule)
				{
					return automaticActionModule.Cocked;
				}
				return false;
			}
			set
			{
				if (!(ActionModule is global::InventorySystem.Items.Firearms.Modules.AutomaticActionModule automaticActionModule))
				{
					global::LabApi.Features.Console.Logger.Error("Unable to set Cocked as this firearm's IActionModule is invalid");
					return;
				}
				automaticActionModule.Cocked = value;
				automaticActionModule.ServerResync();
			}
		}

		public virtual bool BoltLocked
		{
			get
			{
				if (ActionModule is global::InventorySystem.Items.Firearms.Modules.AutomaticActionModule automaticActionModule)
				{
					return automaticActionModule.BoltLocked;
				}
				return false;
			}
			set
			{
				if (!(ActionModule is global::InventorySystem.Items.Firearms.Modules.AutomaticActionModule automaticActionModule))
				{
					global::LabApi.Features.Console.Logger.Error("Unable to set BoltLocked as this firearm's IActionModule is invalid");
					return;
				}
				automaticActionModule.BoltLocked = value;
				automaticActionModule.ServerResync();
			}
		}

		public virtual bool OpenBolt
		{
			get
			{
				if (ActionModule is global::InventorySystem.Items.Firearms.Modules.AutomaticActionModule automaticActionModule)
				{
					return automaticActionModule.OpenBolt;
				}
				return false;
			}
		}

		public float Firerate
		{
			get
			{
				if (ActionModule != null)
				{
					return ActionModule.DisplayCyclicRate;
				}
				return 0f;
			}
		}

		public uint AttachmentsCode
		{
			get
			{
				return global::InventorySystem.Items.Firearms.Attachments.AttachmentsUtils.GetCurrentAttachmentsCode(Base);
			}
			set
			{
				global::InventorySystem.Items.Firearms.Attachments.AttachmentsUtils.ApplyAttachmentsCode(Base, value, reValidate: true);
				global::InventorySystem.Items.Firearms.Attachments.AttachmentCodeSync.ServerResendAttachmentCode(Base);
			}
		}

		public virtual bool MagazineInserted
		{
			get
			{
				if (MagazineControllerModule == null)
				{
					return false;
				}
				return MagazineControllerModule.MagazineInserted;
			}
			set
			{
				if (!(MagazineControllerModule is global::InventorySystem.Items.Firearms.Modules.MagazineModule magazineModule))
				{
					global::LabApi.Features.Console.Logger.Error("Unable to set MagazineInserted as this firearm's IMagazineControllerModule is null");
				}
				else if (value)
				{
					magazineModule.ServerInsertEmptyMagazine();
				}
				else
				{
					magazineModule.ServerRemoveMagazine();
				}
			}
		}

		public virtual int StoredAmmo
		{
			get
			{
				if (AmmoContainerModule == null)
				{
					return 0;
				}
				return AmmoContainerModule.AmmoStored;
			}
			set
			{
				if (AmmoContainerModule == null)
				{
					global::LabApi.Features.Console.Logger.Error("Unable to set StoredAmmo as this firearm's IPrimaryAmmoContainerModule is null");
					return;
				}
				int amount = value - AmmoContainerModule.AmmoStored;
				AmmoContainerModule.ServerModifyAmmo(amount);
			}
		}

		public int MaxAmmo
		{
			get
			{
				if (AmmoContainerModule == null)
				{
					return 0;
				}
				return AmmoContainerModule.AmmoMax;
			}
		}

		public virtual int ChamberedAmmo
		{
			get
			{
				if (ActionModule is global::InventorySystem.Items.Firearms.Modules.AutomaticActionModule automaticActionModule)
				{
					return automaticActionModule.AmmoStored;
				}
				return 0;
			}
			set
			{
				if (!(ActionModule is global::InventorySystem.Items.Firearms.Modules.AutomaticActionModule automaticActionModule))
				{
					global::LabApi.Features.Console.Logger.Error("Unable to set ChamberedAmmo as this firearm's IActionModule is not valid.");
					return;
				}
				automaticActionModule.AmmoStored = value;
				automaticActionModule.ServerResync();
			}
		}

		public virtual int ChamberMax
		{
			get
			{
				if (ActionModule is global::InventorySystem.Items.Firearms.Modules.AutomaticActionModule automaticActionModule)
				{
					return automaticActionModule.ChamberSize;
				}
				return 0;
			}
			set
			{
				if (!(ActionModule is global::InventorySystem.Items.Firearms.Modules.AutomaticActionModule automaticActionModule))
				{
					global::LabApi.Features.Console.Logger.Error("Unable to set ChamberMax as this firearm's IActionModule is not valid.");
				}
				else
				{
					automaticActionModule.ChamberSize = value;
				}
			}
		}

		public bool FlashlightEnabled
		{
			get
			{
				global::InventorySystem.Items.Firearms.Attachments.Components.Attachment[] attachments = Attachments;
				for (int i = 0; i < attachments.Length; i++)
				{
					if (attachments[i] is global::InventorySystem.Items.Firearms.Attachments.FlashlightAttachment flashlightAttachment)
					{
						if (flashlightAttachment.IsEnabled)
						{
							return flashlightAttachment.IsEmittingLight;
						}
						return false;
					}
				}
				return false;
			}
			set
			{
				global::InventorySystem.Items.Firearms.Attachments.Components.Attachment[] attachments = Attachments;
				for (int i = 0; i < attachments.Length; i++)
				{
					if (attachments[i] is global::InventorySystem.Items.Firearms.Attachments.FlashlightAttachment flashlightAttachment)
					{
						flashlightAttachment.ServerSendStatus(value);
					}
				}
			}
		}

		public global::InventorySystem.Items.Firearms.Attachments.Components.Attachment[] Attachments => Base.Attachments;

		public global::InventorySystem.Items.Firearms.Modules.ModuleBase[] Modules => Base.Modules;

		public global::System.Collections.Generic.IEnumerable<global::InventorySystem.Items.Firearms.Attachments.AttachmentName> AvailableAttachmentsNames
		{
			get
			{
				global::InventorySystem.Items.Firearms.Attachments.Components.Attachment[] attachments = Attachments;
				foreach (global::InventorySystem.Items.Firearms.Attachments.Components.Attachment attachment in attachments)
				{
					yield return attachment.Name;
				}
			}
		}

		public global::System.Collections.Generic.IEnumerable<global::InventorySystem.Items.Firearms.Attachments.Components.Attachment> ActiveAttachments
		{
			get
			{
				global::InventorySystem.Items.Firearms.Attachments.Components.Attachment[] attachments = Attachments;
				foreach (global::InventorySystem.Items.Firearms.Attachments.Components.Attachment attachment in attachments)
				{
					if (attachment.IsEnabled)
					{
						yield return attachment;
					}
				}
			}
		}

		protected global::InventorySystem.Items.Firearms.Modules.IPrimaryAmmoContainerModule AmmoContainerModule { get; set; }

		protected global::InventorySystem.Items.Firearms.Modules.IActionModule ActionModule { get; set; }

		protected global::InventorySystem.Items.Firearms.Modules.IReloaderModule ReloaderModule { get; set; }

		protected global::InventorySystem.Items.Firearms.Modules.IMagazineControllerModule MagazineControllerModule { get; set; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("firearm")]
		public static global::LabApi.Features.Wrappers.FirearmItem? Get(global::InventorySystem.Items.Firearms.Firearm? firearm)
		{
			if (firearm == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(firearm, out global::LabApi.Features.Wrappers.FirearmItem value))
			{
				return CreateFirearmWrapper(firearm);
			}
			return value;
		}

		internal static global::LabApi.Features.Wrappers.FirearmItem CreateFirearmWrapper(global::InventorySystem.Items.Firearms.Firearm firearm)
		{
			if (!TypeWrappers.TryGetValue(firearm.ItemTypeId, out global::System.Func<global::InventorySystem.Items.Firearms.Firearm, global::LabApi.Features.Wrappers.FirearmItem> value))
			{
				return new global::LabApi.Features.Wrappers.FirearmItem(firearm);
			}
			return value(firearm);
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void InitializeFirearmWrappers()
		{
			Register(ItemType.ParticleDisruptor, (global::InventorySystem.Items.Firearms.Firearm x) => new global::LabApi.Features.Wrappers.ParticleDisruptorItem((global::InventorySystem.Items.Firearms.ParticleDisruptor)x));
			Register(ItemType.GunRevolver, (global::InventorySystem.Items.Firearms.Firearm x) => new global::LabApi.Features.Wrappers.RevolverFirearm(x));
			Register(ItemType.GunSCP127, (global::InventorySystem.Items.Firearms.Firearm x) => new global::LabApi.Features.Wrappers.Scp127Firearm(x));
			Register(ItemType.GunShotgun, (global::InventorySystem.Items.Firearms.Firearm x) => new global::LabApi.Features.Wrappers.ShotgunFirearm(x));
		}

		private static void Register(ItemType itemType, global::System.Func<global::InventorySystem.Items.Firearms.Firearm, global::LabApi.Features.Wrappers.FirearmItem> constructor)
		{
			TypeWrappers.Add(itemType, (global::InventorySystem.Items.Firearms.Firearm x) => constructor(x));
		}

		internal FirearmItem(global::InventorySystem.Items.Firearms.Firearm firearm)
			: base(firearm)
		{
			Base = firearm;
			if (base.CanCache)
			{
				Dictionary.Add(firearm, this);
			}
			CacheModules();
		}

		public bool CheckAttachmentsCode(uint code)
		{
			return ValidateAttachmentsCode(code) == code;
		}

		public bool CheckAttachmentsCode(params global::InventorySystem.Items.Firearms.Attachments.AttachmentName[] attachments)
		{
			uint codeFromAttachmentNamesRaw = GetCodeFromAttachmentNamesRaw(attachments);
			return codeFromAttachmentNamesRaw == ValidateAttachmentsCode(codeFromAttachmentNamesRaw);
		}

		public uint ValidateAttachmentsCode(uint code)
		{
			return global::InventorySystem.Items.Firearms.Attachments.AttachmentsUtils.ValidateAttachmentsCode(Base, code);
		}

		public uint ValidateAttachmentsCode(params global::InventorySystem.Items.Firearms.Attachments.AttachmentName[] attachments)
		{
			return ValidateAttachmentsCode(GetCodeFromAttachmentNamesRaw(attachments));
		}

		public uint GetCodeFromAttachmentNamesRaw(global::InventorySystem.Items.Firearms.Attachments.AttachmentName[] attachments)
		{
			uint num = 0u;
			uint num2 = 1u;
			global::InventorySystem.Items.Firearms.Attachments.Components.Attachment[] attachments2 = Attachments;
			foreach (global::InventorySystem.Items.Firearms.Attachments.Components.Attachment attachment in attachments2)
			{
				if (attachments.Contains(attachment.Name))
				{
					num += num2;
				}
				num2 *= 2;
			}
			return num;
		}

		public bool Reload()
		{
			if (!(ReloaderModule is global::InventorySystem.Items.Firearms.Modules.AnimatorReloaderModuleBase animatorReloaderModuleBase))
			{
				global::LabApi.Features.Console.Logger.Error("Unable to reload this firearm as it's animator module is invalid");
				return false;
			}
			return animatorReloaderModuleBase.ServerTryReload();
		}

		public bool Unload()
		{
			if (!(ReloaderModule is global::InventorySystem.Items.Firearms.Modules.AnimatorReloaderModuleBase animatorReloaderModuleBase))
			{
				global::LabApi.Features.Console.Logger.Error("Unable to unload this firearm as it's animator module is invalid");
				return false;
			}
			return animatorReloaderModuleBase.ServerTryUnload();
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}

		protected virtual void CacheModules()
		{
			global::InventorySystem.Items.Firearms.Modules.ModuleBase[] modules = Modules;
			foreach (global::InventorySystem.Items.Firearms.Modules.ModuleBase moduleBase in modules)
			{
				if (!(moduleBase is global::InventorySystem.Items.Firearms.Modules.IPrimaryAmmoContainerModule ammoContainerModule))
				{
					if (!(moduleBase is global::InventorySystem.Items.Firearms.Modules.IActionModule actionModule))
					{
						if (!(moduleBase is global::InventorySystem.Items.Firearms.Modules.IReloaderModule reloaderModule))
						{
							if (moduleBase is global::InventorySystem.Items.Firearms.Modules.IMagazineControllerModule magazineControllerModule)
							{
								MagazineControllerModule = magazineControllerModule;
							}
						}
						else
						{
							ReloaderModule = reloaderModule;
						}
					}
					else
					{
						ActionModule = actionModule;
					}
				}
				else
				{
					AmmoContainerModule = ammoContainerModule;
				}
			}
		}
	}
}

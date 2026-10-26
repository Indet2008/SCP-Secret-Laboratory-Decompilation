using System;
using InventorySystem.Crosshairs;
using InventorySystem.Items.Firearms.Attachments.Components;
using InventorySystem.Items.Firearms.ShotEvents;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class AttachmentDependentHitreg : ModuleBase, IHitregModule, ICustomCrosshairItem, IDisplayableInaccuracyProviderModule, IInaccuracyProviderModule
	{
		[Serializable]
		private class AttachmentOverride
		{
			[SerializeField]
			private Attachment _attachment;

			[SerializeField]
			private ModuleBase _module;

			public IHitregModule Hitreg { get; private set; }

			public bool IsEnabled => _attachment.IsEnabled;

			public void Init()
			{
				_module.MarkAsSubmodule();
				Hitreg = _module as IHitregModule;
			}
		}

		[SerializeField]
		private ModuleBase _primaryHitreg;

		[SerializeField]
		private AttachmentOverride[] _overrideHitregs;

		private bool _targetCacheSet;

		private IHitregModule _cachedTargetModule;

		public float DisplayDamage => TargetModule.DisplayDamage;

		public float DisplayPenetration => TargetModule.DisplayPenetration;

		public Type CrosshairType
		{
			get
			{
				if (!(TargetModule is ICustomCrosshairItem customCrosshairItem))
				{
					return null;
				}
				return customCrosshairItem.CrosshairType;
			}
		}

		public DisplayInaccuracyValues DisplayInaccuracy
		{
			get
			{
				if (!(TargetModule is IDisplayableInaccuracyProviderModule displayableInaccuracyProviderModule))
				{
					return default;
				}
				return displayableInaccuracyProviderModule.DisplayInaccuracy;
			}
		}

		public float Inaccuracy
		{
			get
			{
				if (!(TargetModule is IInaccuracyProviderModule inaccuracyProviderModule))
				{
					return 0f;
				}
				return inaccuracyProviderModule.Inaccuracy;
			}
		}

		private IHitregModule TargetModule
		{
			get
			{
				if (_targetCacheSet)
				{
					return _cachedTargetModule;
				}
				_cachedTargetModule = _primaryHitreg as IHitregModule;
				AttachmentOverride[] overrideHitregs = _overrideHitregs;
				foreach (AttachmentOverride attachmentOverride in overrideHitregs)
				{
					if (attachmentOverride.IsEnabled)
					{
						_cachedTargetModule = attachmentOverride.Hitreg;
						break;
					}
				}
				_targetCacheSet = true;
				return _cachedTargetModule;
			}
		}

		public event Action ServerOnFired;

		public void Fire(ReferenceHub primaryTarget, ShotEvent shotData)
		{
			TargetModule.Fire(primaryTarget, shotData);
		}

		protected override void OnInit()
		{
			base.OnInit();
			_primaryHitreg.MarkAsSubmodule();
			(_primaryHitreg as IHitregModule).ServerOnFired += () =>
			{
				ServerOnFired?.Invoke();
			};
			AttachmentOverride[] overrideHitregs = _overrideHitregs;
			foreach (AttachmentOverride obj in overrideHitregs)
			{
				obj.Init();
				obj.Hitreg.ServerOnFired += () =>
				{
					ServerOnFired?.Invoke();
				};
			}
		}

		internal override void OnAttachmentsApplied()
		{
			base.OnAttachmentsApplied();
			_targetCacheSet = false;
			if (base.IsLocalPlayer && base.Firearm.IsEquipped)
			{
				CrosshairController.Refresh(base.Firearm.Owner, base.ItemSerial);
			}
		}
	}
}

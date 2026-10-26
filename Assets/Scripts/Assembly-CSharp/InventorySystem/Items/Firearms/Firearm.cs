using System;
using Footprinting;
using InventorySystem.Crosshairs;
using InventorySystem.Items.Autosync;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Attachments.Components;
using InventorySystem.Items.Firearms.Modules;
using Mirror;
using PlayerRoles;
using UnityEngine;

namespace InventorySystem.Items.Firearms
{
	public class Firearm : ModularAutosyncItem, IItemNametag, ICustomCrosshairItem, IDisarmingItem
	{
		private Footprint _cachedFootprint;

		private bool _footprintCacheSet;

		private ModuleBase[] _modules;

		private Attachment[] _attachments;

		public override ItemDescriptionType DescriptionType => ItemDescriptionType.Firearm;

		public override float Weight => this.TotalWeightKg();

		public float Length => this.TotalLengthInches();

		[field: SerializeField]
		public FirearmWorldmodel WorldModel { get; set; }

		[field: SerializeField]
		public FirearmCategory FirearmCategory { get; private set; }

		[field: SerializeField]
		public float BaseWeight { get; private set; }

		[field: SerializeField]
		public float BaseLength { get; private set; }

		[field: SerializeField]
		public Texture BodyIconTexture { get; set; }

		public Animator ServerSideAnimator { get; private set; }

		public string Name => ItemTypeId.GetName();

		public AnimatedFirearmViewmodel ClientViewmodelInstance
		{
			get
			{
				if (!HasViewmodel)
				{
					return null;
				}
				return ViewModel as AnimatedFirearmViewmodel;
			}
		}

		public override bool HasViewmodel
		{
			get
			{
				if (ViewModel is AnimatedFirearmViewmodel animatedFirearmViewmodel && animatedFirearmViewmodel != null)
				{
					return animatedFirearmViewmodel.Initialized;
				}
				return false;
			}
		}

		public Footprint Footprint
		{
			get
			{
				if (!_footprintCacheSet)
				{
					_footprintCacheSet = true;
					_cachedFootprint = new Footprint(base.Owner);
				}
				return _cachedFootprint;
			}
		}

		public ModuleBase[] Modules
		{
			get
			{
				if (_modules == null)
				{
					_modules = base.AllSubcomponents.OfType<SubcomponentBase, ModuleBase>();
				}
				return _modules;
			}
		}

		public Attachment[] Attachments
		{
			get
			{
				if (_attachments == null)
				{
					_attachments = base.AllSubcomponents.OfType<SubcomponentBase, Attachment>();
				}
				return _attachments;
			}
		}

		public bool ServerIsPersonal
		{
			get
			{
				ItemAddReason serverAddReason = base.ServerAddReason;
				return serverAddReason == ItemAddReason.StartingItem || serverAddReason == ItemAddReason.AdminCommand || serverAddReason == ItemAddReason.Scp2536;
			}
		}

		internal override bool IsLocalPlayer
		{
			get
			{
				if (base.HasOwner)
				{
					return base.IsLocalPlayer;
				}
				return false;
			}
		}

		public Type CrosshairType
		{
			get
			{
				if (DebugStatsCrosshair.Enabled)
				{
					return typeof(DebugStatsCrosshair);
				}
				if (this.TryGetModule<ICustomCrosshairItem>(out var module))
				{
					return module.CrosshairType;
				}
				return null;
			}
		}

		public bool AllowDisarming => true;

		public override void InitializeSubcomponents()
		{
			ServerSideAnimator = GetComponent<Animator>();
			ServerSideAnimator.enabled = false;
			base.InitializeSubcomponents();
			AttachmentCodeSync.TryGet(base.ItemSerial, out var code);
			if (base.IsServer)
			{
				if (ServerIsPersonal)
				{
					code = AttachmentsServerHandler.ServerGetReceivedPlayerPreference(this);
				}
				this.ApplyAttachmentsCode(code, reValidate: true);
				this.ServerResendAttachmentCode();
			}
			else
			{
				this.ApplyAttachmentsCode(code, reValidate: true);
			}
		}

		public override void ServerConfirmAcqusition()
		{
			base.ServerConfirmAcqusition();
			this.ServerResendAttachmentCode();
		}

		public override void OnEquipped()
		{
			base.OnEquipped();
			ServerSideAnimator.enabled = base.IsServer;
			if (base.IsServer)
			{
				this.ServerResendAttachmentCode();
			}
		}

		public override void OnHolstered()
		{
			base.OnHolstered();
			if (base.IsServer)
			{
				ServerSideAnimator.Rebind();
				ServerSideAnimator.enabled = false;
			}
		}

		protected override void Awake()
		{
			base.Awake();
			AttachmentCodeSync.OnReceived += OnAttachmentCodeReceived;
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			AttachmentCodeSync.OnReceived -= OnAttachmentCodeReceived;
			PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
		}

		private void OnAttachmentCodeReceived(ushort serial, uint attCode)
		{
			if (serial == base.ItemSerial && !NetworkServer.active)
			{
				this.ApplyAttachmentsCode(attCode, reValidate: false);
			}
		}

		private void OnRoleChanged(ReferenceHub hub, PlayerRoleBase prevrole, PlayerRoleBase newrole)
		{
			if (NetworkServer.active && !(base.Owner != hub) && hub.IsAlive())
			{
				_cachedFootprint = new Footprint(base.Owner);
			}
		}
	}
}

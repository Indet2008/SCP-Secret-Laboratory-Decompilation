namespace LabApi.Features.Wrappers
{
	public class ParticleDisruptorItem : global::LabApi.Features.Wrappers.FirearmItem
	{
		private global::InventorySystem.Items.Firearms.Modules.DisruptorModeSelector _selectorModule;

		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Firearms.ParticleDisruptor, global::LabApi.Features.Wrappers.ParticleDisruptorItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Firearms.ParticleDisruptor, global::LabApi.Features.Wrappers.ParticleDisruptorItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.ParticleDisruptorItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.Firearms.ParticleDisruptor Base { get; }

		public global::InventorySystem.Items.Firearms.Modules.DisruptorActionModule.FiringState FiringState
		{
			get
			{
				if (base.ActionModule is global::InventorySystem.Items.Firearms.Modules.DisruptorActionModule disruptorActionModule)
				{
					return disruptorActionModule.CurFiringState;
				}
				return global::InventorySystem.Items.Firearms.Modules.DisruptorActionModule.FiringState.None;
			}
		}

		public bool SingleShotMode => _selectorModule?.SingleShotSelected ?? false;

		public override int ChamberedAmmo
		{
			get
			{
				if (base.ActionModule is global::InventorySystem.Items.Firearms.Modules.DisruptorActionModule disruptorActionModule)
				{
					return disruptorActionModule.IsLoaded ? 1 : 0;
				}
				return 0;
			}
		}

		public override int ChamberMax => 1;

		public override bool Cocked
		{
			get
			{
				if (base.ActionModule is global::InventorySystem.Items.Firearms.Modules.DisruptorActionModule disruptorActionModule)
				{
					return disruptorActionModule.IsLoaded;
				}
				return false;
			}
		}

		public override bool OpenBolt => true;

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("particleDisruptor")]
		public static global::LabApi.Features.Wrappers.ParticleDisruptorItem? Get(global::InventorySystem.Items.Firearms.ParticleDisruptor? particleDisruptor)
		{
			if (particleDisruptor == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(particleDisruptor, out global::LabApi.Features.Wrappers.ParticleDisruptorItem value))
			{
				return (global::LabApi.Features.Wrappers.ParticleDisruptorItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(particleDisruptor);
			}
			return value;
		}

		internal ParticleDisruptorItem(global::InventorySystem.Items.Firearms.ParticleDisruptor particleDisruptor)
			: base(particleDisruptor)
		{
			Base = particleDisruptor;
			if (base.CanCache)
			{
				Dictionary.Add(particleDisruptor, this);
			}
		}

		public void Destroy()
		{
			Base.ServerDestroyItem();
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}

		protected override void CacheModules()
		{
			base.CacheModules();
			global::InventorySystem.Items.Firearms.Modules.ModuleBase[] modules = base.Modules;
			for (int i = 0; i < modules.Length; i++)
			{
				if (modules[i] is global::InventorySystem.Items.Firearms.Modules.DisruptorModeSelector selectorModule)
				{
					_selectorModule = selectorModule;
					break;
				}
			}
		}
	}
}

using InventorySystem.Items.Autosync;

namespace InventorySystem.Items.Firearms
{
	public abstract class FirearmSubcomponentBase : SubcomponentBase
	{
		public Firearm Firearm { get; private set; }

		protected override void OnInit()
		{
			base.OnInit();
			Firearm = base.Item as Firearm;
		}

		public virtual void OnFirearmValidate(Firearm fa)
		{
		}

		internal virtual void OnAttachmentsApplied()
		{
		}

		internal virtual void SpectatorPostprocessSkip()
		{
		}
	}
}

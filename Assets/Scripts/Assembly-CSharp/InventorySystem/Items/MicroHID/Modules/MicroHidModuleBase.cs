using InventorySystem.Items.Autosync;

namespace InventorySystem.Items.MicroHID.Modules
{
	public class MicroHidModuleBase : SubcomponentBase
	{
		public MicroHIDItem MicroHid { get; private set; }

		protected MicroHIDViewmodel Viewmodel { get; private set; }

		protected override void OnInit()
		{
			base.OnInit();
			MicroHid = base.Item as MicroHIDItem;
			Viewmodel = MicroHid.ViewModel as MicroHIDViewmodel;
		}
	}
}

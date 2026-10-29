namespace OperationalGuide
{
	public class OperationalFirearmPage : OperationalExistingPannablePage
	{
		public FirearmObject FirearmObject;

		public ItemType DefaultItem;

		public override void ToggleDescriptionMenu()
		{
			base.ToggleDescriptionMenu();
			FirearmObject.UpdateHeldItem(DefaultItem);
		}

		public virtual void UpdateHeldItem(int item)
		{
			FirearmObject.UpdateHeldItem((ItemType)item);
			DefaultItem = (ItemType)item;
		}

		public override void SpawnPannable()
		{
			PannableObject = OperationalGuide.Instance.SpawnModelRoleForCamera(RoleToSpawn);
			FirearmObject = PannableObject as FirearmObject;
			FirearmObject.UpdateHeldItem(DefaultItem);
		}
	}
}

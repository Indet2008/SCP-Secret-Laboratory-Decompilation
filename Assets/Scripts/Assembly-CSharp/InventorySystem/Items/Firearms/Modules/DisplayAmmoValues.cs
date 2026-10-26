namespace InventorySystem.Items.Firearms.Modules
{
	public readonly struct DisplayAmmoValues
	{
		public readonly int Magazines;

		public readonly int Chambered;

		public int Total => Magazines + Chambered;

		public DisplayAmmoValues(int magazines = 0, int chambered = 0)
		{
			Magazines = magazines;
			Chambered = chambered;
		}
	}
}

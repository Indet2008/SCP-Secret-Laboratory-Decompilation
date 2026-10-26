namespace InventorySystem.Items
{
	public static class ItemSerialGenerator
	{
		private static ushort _ai;

		public static void Reset()
		{
			_ai = 0;
		}

		public static ushort GenerateNext()
		{
			if (_ai > 65000)
			{
				Reset();
			}
			_ai++;
			return _ai;
		}
	}
}

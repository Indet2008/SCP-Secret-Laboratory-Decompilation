using TMPro;

namespace InventorySystem.Items.Test
{
	public class TestItemViewmodel : ItemViewmodelBase
	{
		public TextMeshProUGUI Text;

		public void UpdateText(string stringUwU)
		{
			Text.text = stringUwU;
		}
	}
}

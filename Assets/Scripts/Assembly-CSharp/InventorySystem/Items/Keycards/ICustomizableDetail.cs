using System;

namespace InventorySystem.Items.Keycards
{
	public interface ICustomizableDetail
	{
		string[] CommandArguments { get; }

		int CustomizablePropertiesAmount { get; }

		void ParseArguments(ArraySegment<string> args);

		void SetArguments(ArraySegment<object> args);
	}
}

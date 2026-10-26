using System.Text.RegularExpressions;

namespace InventorySystem.Items.Firearms.Modules
{
	public abstract class ModuleBase : FirearmSubcomponentBase
	{
		public bool IsSubmodule { get; private set; }

		internal void MarkAsSubmodule()
		{
			IsSubmodule = true;
		}

		protected virtual void Reset()
		{
			base.gameObject.name = Regex.Replace(GetType().Name, "[a-z][A-Z]", (Match m) => m.Value[0] + " " + m.Value[1]);
		}
	}
}

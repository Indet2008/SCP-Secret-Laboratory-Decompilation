namespace RemoteAdmin.Menus
{
	public class SanctionMenu : global::RemoteAdmin.Menus.RaCommandMenu
	{
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Transform _rootParent;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _template;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.Button _predefinedReasonsButton;

		protected override void OnStart()
		{
		}

		public SanctionMenu()
		{
		}
	}
}

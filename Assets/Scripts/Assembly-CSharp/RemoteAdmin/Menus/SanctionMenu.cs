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
			global::RemoteAdmin.Elements.ValueButton[] array = base.Options.ToArray();
			foreach (global::RemoteAdmin.Elements.ValueButton valueButton in array)
			{
				if (valueButton is global::RemoteAdmin.Elements.CustomSanctionButton)
				{
					base.Options.Remove(valueButton);
					global::UnityEngine.Object.Destroy(valueButton.gameObject);
				}
			}
			global::ServerConfigSynchronizer singleton = global::ServerConfigSynchronizer.Singleton;
			_predefinedReasonsButton.interactable = singleton.EnableRemoteAdminPredefinedBanTemplates;
			if (!singleton.EnableRemoteAdminPredefinedBanTemplates)
			{
				return;
			}
			foreach (global::ServerConfigSynchronizer.PredefinedBanTemplate remoteAdminPredefinedBanTemplate in singleton.RemoteAdminPredefinedBanTemplates)
			{
				if (!global::UnityEngine.Object.Instantiate(_template, _rootParent).TryGetComponent<global::RemoteAdmin.Elements.CustomSanctionButton>(out var component))
				{
					global::UnityEngine.Debug.LogError("Predefined Sanction button's template doesn't have the CustomSanctionButton component, correct this through Unity.");
					continue;
				}
				component.CommandMenu = this;
				component.Value = string.Format("{0} {1}", remoteAdminPredefinedBanTemplate.Duration, remoteAdminPredefinedBanTemplate.Reason);
				component.Text.text = " " + remoteAdminPredefinedBanTemplate.Reason;
				component.DurationLabel.text = ((remoteAdminPredefinedBanTemplate.Duration <= 0) ? " KICK" : (" BAN [ " + remoteAdminPredefinedBanTemplate.FormattedDuration + "]"));
				base.Options.Add(component);
			}
		}
	}
}

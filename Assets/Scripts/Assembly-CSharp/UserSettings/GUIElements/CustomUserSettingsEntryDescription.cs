namespace UserSettings.GUIElements
{
	public class CustomUserSettingsEntryDescription : UserSettingsEntryDescription
	{
		private string _customText;

		public override string Text => _customText;

		public void SetCustomText(string text)
		{
			_customText = text;
		}
	}
}

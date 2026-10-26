using TMPro;
using UnityEngine;

namespace UserSettings.ServerSpecific.Examples
{
	public class SSFieldsDemoExample : SSExampleImplementationBase
	{
		public override string Name => "All fields demo (no functionality)";

		public override void Activate()
		{
			string[] options = new string[4] { "Option 1", "Option 2", "Option 3", "Option 4" };
			ServerSpecificSettingsSync.DefinedSettings = new ServerSpecificSettingBase[26]
			{
				new SSGroupHeader("GroupHeader"),
				new SSTwoButtonsSetting(null, "TwoButtonsSetting", "Option A", "Option B"),
				new SSTextArea(null, "TextArea"),
				new SSTextArea(null, "Multiline collapsable TextArea.\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", SSTextArea.FoldoutMode.ExtendedByDefault),
				new SSSliderSetting(null, "SliderSetting", 0f, 1f),
				new SSPlaintextSetting(null, "Plaintext"),
				new SSKeybindSetting(null, "KeybindSetting"),
				new SSDropdownSetting(null, "DropdownSetting", options),
				new SSDropdownSetting(null, "Scrollable DropdownSetting", options, 0, SSDropdownSetting.DropdownEntryType.Scrollable),
				new SSButton(null, "Button", "Press me!"),
				new SSGroupHeader("Hints", reducedPadding: false, "Group headers are used to separate settings into subcategories."),
				new SSTwoButtonsSetting(null, "Another TwoButtonsSetting", "Option A", "Option B", defaultIsB: false, "Two Buttons are used to store Boolean values."),
				new SSSliderSetting(null, "Another SliderSetting", 0f, 1f, 0f, integer: false, "0.##", "{0}", "Sliders store a numeric value within a defined range."),
				new SSPlaintextSetting(null, "Another Plaintext", "...", 64, TMP_InputField.ContentType.Standard, "Plaintext fields store any provided text."),
				new SSKeybindSetting(null, "Another KeybindSetting", KeyCode.None, preventInteractionOnGui: true, allowSpectatorTrigger: true, "Allows checking if the player is currently holding the action key."),
				new SSDropdownSetting(null, "Another DropdownSetting", options, 0, SSDropdownSetting.DropdownEntryType.Regular, "Stores an integer value between 0 and the length of options minus 1."),
				new SSDropdownSetting(null, "Another Scrollable DropdownSetting", options, 0, SSDropdownSetting.DropdownEntryType.Scrollable, "Alternative to dropdown. API is the same as in regular dropdown, but the client-side entry behaves differently."),
				new SSButton(null, "Another Button", "Press me! (again)", null, "Triggers an event whenever it is pressed."),
				new SSGroupHeader("Collections"),
				new SSTextArea(null, "Settings assigned with the same CollectionId are shared between servers with the same IP"),
				new SSTwoButtonsSetting(null, "Shared TwoButtonsSetting", "Option A", "Option B", defaultIsB: false, null, 0),
				new SSSliderSetting(null, "Shared SliderSetting", 0f, 1f, 0f, integer: false, "0.##", "{0}", null, 0),
				new SSPlaintextSetting(null, "Shared Plaintext", "...", 64, TMP_InputField.ContentType.Standard, null, 0),
				new SSKeybindSetting(null, "Shared KeybindSetting", KeyCode.None, preventInteractionOnGui: true, allowSpectatorTrigger: true, null, 0),
				new SSDropdownSetting(null, "Shared DropdownSetting", options, 0, SSDropdownSetting.DropdownEntryType.Regular, null, 0),
				new SSDropdownSetting(null, "Shared Scrollable DropdownSetting", options, 0, SSDropdownSetting.DropdownEntryType.Scrollable, null, 0)
			};
			ServerSpecificSettingsSync.SendToAll();
		}

		public override void Deactivate()
		{
		}
	}
}

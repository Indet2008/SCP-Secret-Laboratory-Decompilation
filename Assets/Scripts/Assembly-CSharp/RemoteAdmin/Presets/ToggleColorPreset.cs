using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin.Presets
{
	[CreateAssetMenu(fileName = "MyColorPreset", menuName = "Northwood/UI/Color Preset (Toggle)")]
	public class ToggleColorPreset : ScriptableObject
	{
		[Header("Selected:")]
		[SerializeField]
		private ColorBlock _selected;

		[Space(5f)]
		[Header("Unselected:")]
		[SerializeField]
		private ColorBlock _unselected;

		public ColorBlock Selected => _selected;

		public ColorBlock Unselected => _unselected;
	}
}
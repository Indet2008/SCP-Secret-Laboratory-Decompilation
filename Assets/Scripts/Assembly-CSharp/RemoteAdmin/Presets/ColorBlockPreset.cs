using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin.Presets
{
	[CreateAssetMenu(fileName = "MyColorBlockPreset", menuName = "Northwood/UI/ColorBlock Preset")]
	public class ColorBlockPreset : ScriptableObject
	{
		[SerializeField]
		private ColorBlock _serializedColor;

		public ColorBlock Color => _serializedColor;
	}
}
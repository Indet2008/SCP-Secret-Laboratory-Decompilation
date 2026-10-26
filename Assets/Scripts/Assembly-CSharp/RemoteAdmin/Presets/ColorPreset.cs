using UnityEngine;

namespace RemoteAdmin.Presets
{
	[CreateAssetMenu(fileName = "MyColorPreset", menuName = "Northwood/UI/Color Preset")]
	public class ColorPreset : ScriptableObject
	{
		[SerializeField]
		private Color _serializedColor;

		public Color Color => _serializedColor;
	}
}
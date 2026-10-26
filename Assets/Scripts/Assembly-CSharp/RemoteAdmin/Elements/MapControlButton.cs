using RemoteAdmin.Menus;
using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin.Elements
{
	public abstract class MapControlButton : ValueButton
	{
		protected MapControlMenu MapMenu;

		private bool _menuInitialized;

		[SerializeField]
		private Image _image;

		public virtual void Setup()
		{
			EnsureInitialized();
			MapMenu = base.CommandMenu as MapControlMenu;
			_menuInitialized = MapMenu != null;
			UpdateGraphics();
		}

		public override void SetState(bool isSelected)
		{
			base.SetState(isSelected);
			UpdateGraphics();
		}

		public void UpdateGraphics()
		{
			if (_menuInitialized)
			{
				if (_image != null)
				{
					_image.color = BackgroundColor();
				}
				if (base.Outline != null)
				{
					base.Outline.effectColor = OutlineColor();
				}
			}
		}

		protected static Color PresetColor(Presets.ColorPreset preset, Color fallback)
		{
			if (!(preset != null))
			{
				return fallback;
			}
			return preset.Color;
		}

		protected abstract Color BackgroundColor();

		protected abstract Color OutlineColor();
	}
}
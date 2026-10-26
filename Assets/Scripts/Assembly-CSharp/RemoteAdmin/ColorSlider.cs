namespace RemoteAdmin
{
	public class ColorSlider : global::RemoteAdmin.CustomSlider
	{
		public enum ModifiedColorValue
		{
			R = 0,
			G = 1,
			B = 2,
			A = 3
		}

		[global::UnityEngine.Tooltip("The images this slider is gonna change the color of.")]
		public global::UnityEngine.UI.RawImage[] Images;

		[global::UnityEngine.Tooltip("Which color value will be modified by this slider.")]
		public global::RemoteAdmin.ColorSlider.ModifiedColorValue ValueToModify;

		// Client-only body (empty in the server build): route the slider into its RA setting, which recolours and saves.
		protected override void OnValueChanged(float newValue)
		{
			global::RemoteAdmin.Menus.RaSettings settings = global::RemoteAdmin.Menus.RaSettings.Singleton;
			if (settings == null)
			{
				return;
			}
			switch (ValueToModify)
			{
			case ModifiedColorValue.R:
				settings.WindowRed.SliderToValue();
				break;
			case ModifiedColorValue.G:
				settings.WindowGreen.SliderToValue();
				break;
			case ModifiedColorValue.B:
				settings.WindowBlue.SliderToValue();
				break;
			case ModifiedColorValue.A:
				settings.WindowAlpha.SliderToValue();
				break;
			}
		}

		public ColorSlider()
		{
		}
	}
}

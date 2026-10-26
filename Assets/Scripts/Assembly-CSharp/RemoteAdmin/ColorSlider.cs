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

		protected override void OnValueChanged(float newValue)
		{
		}

		public ColorSlider()
		{
		}
	}
}

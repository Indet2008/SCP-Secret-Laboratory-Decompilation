using UnityEngine;

namespace Hints
{
	public static class KeyCodeExtension
	{
		public static bool TryGetTranslationKey(this KeyCode code, out KeyCodeTranslations translation)
		{
			translation = code switch
			{
				KeyCode.UpArrow => KeyCodeTranslations.ArrowUp, 
				KeyCode.DownArrow => KeyCodeTranslations.ArrowDown, 
				KeyCode.LeftArrow => KeyCodeTranslations.ArrowLeft, 
				KeyCode.RightArrow => KeyCodeTranslations.ArrowRight, 
				KeyCode.LeftShift => KeyCodeTranslations.LeftShift, 
				KeyCode.RightShift => KeyCodeTranslations.RightShift, 
				KeyCode.LeftControl => KeyCodeTranslations.LeftControl, 
				KeyCode.RightControl => KeyCodeTranslations.RightControl, 
				KeyCode.LeftAlt => KeyCodeTranslations.LeftAlt, 
				KeyCode.RightAlt => KeyCodeTranslations.RightAlt, 
				KeyCode.Tab => KeyCodeTranslations.Tab, 
				KeyCode.Space => KeyCodeTranslations.Space, 
				KeyCode.Return => KeyCodeTranslations.Enter, 
				KeyCode.Mouse0 => KeyCodeTranslations.MousePrimary, 
				KeyCode.Mouse1 => KeyCodeTranslations.MouseSecondary, 
				KeyCode.Mouse2 => KeyCodeTranslations.MouseMiddle, 
				KeyCode.Mouse3 => KeyCodeTranslations.MouseN, 
				KeyCode.Mouse4 => KeyCodeTranslations.MouseN, 
				KeyCode.Mouse5 => KeyCodeTranslations.MouseN, 
				KeyCode.Mouse6 => KeyCodeTranslations.MouseN, 
				_ => KeyCodeTranslations.KeyNotAssigned, 
			};
			return translation != KeyCodeTranslations.KeyNotAssigned;
		}
	}
}

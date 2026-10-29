using UnityEngine;

public class HideHUDElement : MonoBehaviour
{
	[SerializeField]
	private Behaviour[] elementsToDisable;

	private void ToggleElement(bool state)
	{
		if (elementsToDisable == null)
		{
			return;
		}
		Behaviour[] array = elementsToDisable;
		foreach (Behaviour behaviour in array)
		{
			if (!(behaviour == null))
			{
				behaviour.enabled = state;
			}
		}
	}

	private void Awake()
	{
		HideHUDController.ToggleHUD += ToggleElement;
		if (!HideHUDController.IsHUDVisible)
		{
			ToggleElement(state: false);
		}
	}

	private void OnDestroy()
	{
		HideHUDController.ToggleHUD -= ToggleElement;
	}
}

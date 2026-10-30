public class MaintainPropotionsToggle : global::UnityEngine.MonoBehaviour
{
	private bool _state;

	public global::UnityEngine.UI.Slider[] CompatibleSliders;

	public void SetValue(bool val)
	{
		_state = val;
		if (val)
		{
			for (int i = 0; i < CompatibleSliders.Length; i++)
			{
				CompatibleSliders[i].value = CompatibleSliders[0].value;
			}
		}
	}

	public void UseSlider(int sliderId)
	{
		if (!_state)
		{
			return;
		}
		for (int i = 0; i < CompatibleSliders.Length; i++)
		{
			if (i != sliderId)
			{
				CompatibleSliders[i].value = CompatibleSliders[sliderId].value;
			}
		}
	}

	public MaintainPropotionsToggle()
	{
	}
}

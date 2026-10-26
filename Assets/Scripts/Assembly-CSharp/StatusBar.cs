using UnityEngine;
using UnityEngine.UI;

public class StatusBar : MonoBehaviour
{
	public enum AutoHideType
	{
		WhenFull = 0,
		WhenEmpty = 1,
		AlwaysVisible = 2
	}

	[Tooltip("Above which object should this be displayed?")]
	public StatusBar MasterBar;

	[Tooltip("Slider which the script will affect")]
	public Slider TargetSlider;

	[Tooltip("All graphics that should be faded in/out")]
	public CanvasRenderer[] TargetGraphics;

	[Tooltip("Y-axis offset of the MasterTransform.position")]
	public float FixedDistance;

	public AutoHideType AutohideOption;

	public bool HiddenByDefault;

	public float FadeInSpeed;

	public float FadeOutSpeed;

	public float MoveSpeed;

	private float CurAlpha
	{
		get
		{
			if (TargetGraphics.Length != 0)
			{
				return TargetGraphics[0].GetAlpha();
			}
			return 1f;
		}
	}

	private Vector3 LocalPosition
	{
		get
		{
			return (base.transform as RectTransform).localPosition;
		}
		set
		{
			(base.transform as RectTransform).localPosition = value;
		}
	}

	private void OnEnable()
	{
		if (HiddenByDefault)
		{
			TargetGraphics.ForEach((CanvasRenderer x) =>
			{
				x.SetAlpha(0f);
			});
		}
	}

	private void Move(float targetY, bool bypassAnimation)
	{
		Vector3 localPosition = LocalPosition;
		if (bypassAnimation)
		{
			localPosition.y = targetY;
		}
		else
		{
			float num = Time.deltaTime * MoveSpeed;
			float num2 = targetY - localPosition.y;
			if (num > Mathf.Abs(num2))
			{
				localPosition.y = targetY;
			}
			else
			{
				localPosition.y += num * (float)((num2 > 0f) ? 1 : (-1));
			}
		}
		LocalPosition = localPosition;
	}

	private void Update()
	{
		UpdateBar(bypassAnims: false);
	}

	public void UpdateBar(bool bypassAnims)
	{
		if (MasterBar != null)
		{
			StatusBar masterBar = MasterBar;
			while (masterBar.TargetGraphics.Length != 0 && masterBar.CurAlpha <= 0.1f)
			{
				if (masterBar.MasterBar == null)
				{
					return;
				}
				masterBar = masterBar.MasterBar;
			}
			Move(masterBar.LocalPosition.y + FixedDistance, bypassAnims || CurAlpha <= 0f);
		}
		if (AutohideOption != AutoHideType.AlwaysVisible)
		{
			float num = FadeInSpeed;
			if ((AutohideOption == AutoHideType.WhenEmpty && TargetSlider.value == TargetSlider.minValue) || (AutohideOption == AutoHideType.WhenFull && TargetSlider.value == TargetSlider.maxValue))
			{
				num = 0f - FadeOutSpeed;
			}
			if (bypassAnims)
			{
				SetAlpha(Mathf.Sign(num));
			}
			else
			{
				SetAlpha(TargetGraphics[0].GetAlpha() + num * Time.deltaTime);
			}
		}
	}

	public void SetAlpha(float a)
	{
		CanvasRenderer[] targetGraphics = TargetGraphics;
		for (int i = 0; i < targetGraphics.Length; i++)
		{
			targetGraphics[i].SetAlpha(Mathf.Clamp01(a));
		}
	}
}

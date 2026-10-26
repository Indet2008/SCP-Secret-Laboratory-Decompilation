using System;
using MapGeneration.Holidays;
using UnityEngine;
using UnityEngine.UI;

public class HolidayBackgroundReplacer : MonoBehaviour
{
	[Serializable]
	private struct BackgroundInfo
	{
		public Image Target;

		public HolidayInfo[] Variants;
	}

	[Serializable]
	private struct HolidayInfo : IHolidayFetchableData<Sprite>
	{
		[field: SerializeField]
		public HolidayType Holiday { get; private set; }

		[field: SerializeField]
		public Sprite Result { get; private set; }
	}

	[SerializeField]
	private BackgroundInfo[] _backgrounds;

	private void Awake()
	{
		BackgroundInfo[] backgrounds = _backgrounds;
		foreach (BackgroundInfo info in backgrounds)
		{
			RefreshBackground(info);
		}
	}

	private void RefreshBackground(BackgroundInfo info)
	{
		if (info.Variants.TryGetResult<HolidayInfo, Sprite>(out var result))
		{
			info.Target.sprite = result;
		}
	}
}

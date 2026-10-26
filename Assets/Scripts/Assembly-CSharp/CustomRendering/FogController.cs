using System;
using System.Collections.Generic;
using System.Linq;
using MapGeneration.Holidays;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	public class FogController : MonoBehaviour
	{
		private static readonly int HashGlobalFogColor = Shader.PropertyToID("_GlobalFogColor");

		private static readonly int HashGlobalFogDistance = Shader.PropertyToID("_GlobalFogDistance");

		private static readonly Dictionary<HolidayType, FogType> HolidayDefaultFog = new Dictionary<HolidayType, FogType>
		{
			[HolidayType.None] = FogType.Inside,
			[HolidayType.Christmas] = FogType.ChristmasInside,
			[HolidayType.Halloween] = FogType.HalloweenInside
		};

		private FogSetting[] _fogSettings;

		private FogType? _fogType;

		private int _defaultIndex;

		public static float FogFarPlaneDistance { get; private set; }

		public static FogController Singleton { get; private set; }

		public static FogType DefaultFog
		{
			get
			{
				HolidayType activeHoliday = HolidayUtils.GetActiveHoliday();
				if (!HolidayDefaultFog.TryGetValue(activeHoliday, out var value))
				{
					return FogType.Inside;
				}
				return value;
			}
		}

		public CustomFog FogEffect { get; private set; }

		public FogType? ForcedFog
		{
			get
			{
				return _fogType;
			}
			set
			{
				bool flag = !value.HasValue || value.Value != FogType.None;
				FogEffect.enabled = flag;
				_fogType = value;
			}
		}

		public static void EnableFogType(FogType fogType, float seconds = 0f)
		{
			FogSetting fogSetting = Singleton.GetFogSetting(fogType);
			fogSetting.IsEnabled = true;
			fogSetting.BlendTime = seconds;
		}

		public static void DisableFogType(FogType fogType, float seconds = 0f)
		{
			FogSetting fogSetting = Singleton.GetFogSetting(fogType);
			fogSetting.IsEnabled = false;
			fogSetting.BlendTime = seconds;
		}

		public FogSetting GetFogSetting(FogType fogType)
		{
			FogSetting[] fogSettings = _fogSettings;
			foreach (FogSetting fogSetting in fogSettings)
			{
				if (fogSetting.FogType == fogType)
				{
					return fogSetting;
				}
			}
			throw new NotImplementedException($"The FogSetting component for '{fogType}' needs to be attached to the FogController GameObject.");
		}

		private void Awake()
		{
			if (Singleton == null)
			{
				Singleton = this;
				_fogSettings = (from x in GetComponents<FogSetting>()
					orderby x.Priority
					select x).ToArray();
				for (int num = 0; num < _fogSettings.Length; num++)
				{
					FogSetting fogSetting = _fogSettings[num];
					if (fogSetting.FogType == DefaultFog)
					{
						fogSetting.enabled = true;
						_defaultIndex = num;
					}
				}
			}
			else
			{
				UnityEngine.Object.Destroy(this);
			}
		}

		private void Start()
		{
			FogEffect = (CustomFog)GetComponent<CustomPassVolume>().customPasses[0];
		}

		private void OnDisable()
		{
			Shader.SetGlobalVector(HashGlobalFogDistance, Vector2.one * float.MaxValue);
		}

		private void Update()
		{
			Color color = _fogSettings[_defaultIndex].Color;
			float num = _fogSettings[_defaultIndex].StartDistance;
			float num2 = _fogSettings[_defaultIndex].EndDistance;
			for (int i = 1; i < _fogSettings.Length; i++)
			{
				FogSetting fogSetting = _fogSettings[i];
				if (ForcedFog.HasValue)
				{
					if (ForcedFog.Value != fogSetting.FogType)
					{
						continue;
					}
				}
				else if (!fogSetting.IsEnabled && fogSetting.Weight == 0f)
				{
					continue;
				}
				fogSetting.UpdateWeight();
				color = Color.Lerp(color, fogSetting.Color, fogSetting.Weight);
				num = Mathf.Lerp(num, fogSetting.StartDistance, fogSetting.Weight);
				num2 = Mathf.Lerp(num2, fogSetting.EndDistance, fogSetting.Weight);
			}
			FogEffect.FogColor = color;
			FogEffect.EndDistance = num2;
			FogEffect.StartDistance = num;
			Shader.SetGlobalVector(HashGlobalFogColor, color);
			Shader.SetGlobalVector(HashGlobalFogDistance, new Vector2(num, num2));
			FogFarPlaneDistance = num2;
		}
	}
}

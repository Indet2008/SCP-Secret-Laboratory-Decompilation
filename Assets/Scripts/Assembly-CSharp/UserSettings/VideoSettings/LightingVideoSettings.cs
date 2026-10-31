using MapGeneration;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;

namespace UserSettings.VideoSettings
{
	// Restored from the 14.2.8 client disassembly.
	public static class LightingVideoSettings
	{
		private readonly struct RoomLightInfo
		{
			public readonly RoomLight Light;

			public readonly HDAdditionalLightData Data;

			public readonly bool ShadowsAllowed;

			public RoomLightInfo(RoomLight light, HDAdditionalLightData data, bool shadowsAllowed)
			{
				Light = light;
				Data = data;
				ShadowsAllowed = shadowsAllowed;
			}
		}

		private static readonly RoomLightInfo[] Lights = new RoomLightInfo[4096];

		private static int _lightsCount;

		private static bool _renderLights;

		private static bool _shadowsEnabled;

		private static ShadowResolution _shadowResolution;

		private const bool DefaultRenderLights = true;

		private const bool DefaultShadowsEnabled = true;

		private const int DefaultShadowResolution = 2;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			UserSetting<bool>.SetDefaultValue(LightingVideoSetting.RenderLights, defaultValue: true);
			UserSetting<bool>.AddListener(LightingVideoSetting.RenderLights, delegate(bool x)
			{
				_renderLights = x;
				UpdateConditionally();
			});
			UserSetting<bool>.SetDefaultValue(LightingVideoSetting.RenderShadows, defaultValue: true);
			UserSetting<bool>.AddListener(LightingVideoSetting.RenderShadows, delegate(bool x)
			{
				_shadowsEnabled = x;
				UpdateConditionally();
			});
			UserSetting<int>.SetDefaultValue(LightingVideoSetting.ShadowResolution, 2);
			UserSetting<int>.AddListener(LightingVideoSetting.ShadowResolution, delegate(int x)
			{
				_shadowResolution = (ShadowResolution)x;
				UpdateConditionally();
			});
			SeedSynchronizer.OnGenerationFinished += OnMapGenerated;
			RoomLightController.OnAdded += OnRoomLightInstanceAdded;
		}

		private static void OnRoomLightInstanceAdded(RoomLightController rlc)
		{
			if (SeedSynchronizer.MapGenerated)
			{
				RegisterLightController(rlc);
			}
		}

		private static void OnMapGenerated()
		{
			_lightsCount = 0;
			_renderLights = UserSetting<bool>.Get(LightingVideoSetting.RenderLights);
			_shadowsEnabled = UserSetting<bool>.Get(LightingVideoSetting.RenderShadows);
			_shadowResolution = (ShadowResolution)UserSetting<int>.Get(LightingVideoSetting.ShadowResolution);
			foreach (RoomLightController instance in RoomLightController.Instances)
			{
				RegisterLightController(instance);
			}
		}

		private static void RegisterLightController(RoomLightController ctrl)
		{
			ctrl.LightsInRoom.ForEach(RegisterLight);
		}

		private static void RegisterLight(RoomLight rl)
		{
			if (!(rl == null) && rl.HasLight && rl.LightSource.gameObject.TryGetComponent<HDAdditionalLightData>(out var component) && _lightsCount < Lights.Length)
			{
				RoomLightInfo info = new RoomLightInfo(rl, component, rl.LightSource.shadows != LightShadows.None);
				Lights[_lightsCount++] = info;
				UpdateInstance(info);
			}
		}

		private static void UpdateConditionally()
		{
			if (SeedSynchronizer.MapGenerated && _renderLights)
			{
				for (int i = 0; i < _lightsCount; i++)
				{
					UpdateInstance(Lights[i]);
				}
			}
		}

		private static void UpdateInstance(RoomLightInfo info)
		{
			if (!info.ShadowsAllowed || info.Data == null)
			{
				return;
			}
			if (_shadowsEnabled)
			{
				info.Light.LightSource.shadows = LightShadows.Soft;
				if (!info.Data.shadowResolution.useOverride)
				{
					info.Data.shadowResolution.useOverride = true;
				}
				info.Data.RequestShadowMapRendering();
				info.Data.SetShadowResolution(1 << (int)(_shadowResolution + 7));
			}
			else
			{
				info.Light.LightSource.shadows = LightShadows.None;
			}
		}
	}
}

using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using AdminToys;
using GameCore;
using Mirror;
using TMPro;
using UnityEngine;
using Utils.Networking;

namespace UserSettings.ServerSpecific.Examples
{
	public class SSLightSpawnerExample : SSExampleImplementationBase
	{
		private enum ExampleId
		{
			IntensitySlider = 0,
			RangeSlider = 1,
			ColorPresetDropdown = 2,
			CustomColor = 3,
			ColorInfo = 4,
			ShadowType = 5,
			ShadowStrength = 6,
			LightType = 7,
			LightShape = 8,
			SpotAngle = 9,
			InnerSpotAngle = 10,
			ConfirmButton = 11,
			DestroyAllButton = 12
		}

		private readonly struct ColorPreset
		{
			public readonly string Name;

			public readonly Color Color;

			public ColorPreset(string name, Color color)
			{
				Name = name;
				Color = color;
			}
		}

		private static float _lightIntensity;

		private static float _lightRange;

		private static ColorPreset[] _colorPresets;

		private static LightShadows[] _shadowType;

		private static float _shadowStrength;

		private static LightType[] _lightType;

		private static LightShape[] _lightShape;

		private static float _spotAngle;

		private static float _innerSpotAngle;

		private static List<ServerSpecificSettingBase> _allSettings;

		private static bool _anySpawned;

		private static SSTextArea _selectedColorTextArea;

		private const PlayerPermissions RequiredPermission = PlayerPermissions.FacilityManagement;

		public override string Name => "Light Spawner";

		public override void Activate()
		{
			_anySpawned = false;
			_lightIntensity = 1f;
			_lightRange = 10f;
			if (_colorPresets == null)
			{
				_colorPresets = new ColorPreset[9]
				{
					new ColorPreset("White", Color.white),
					new ColorPreset("Black", Color.black),
					new ColorPreset("Gray", Color.gray),
					new ColorPreset("Red", Color.red),
					new ColorPreset("Green", Color.green),
					new ColorPreset("Blue", Color.blue),
					new ColorPreset("Yellow", Color.yellow),
					new ColorPreset("Cyan", Color.cyan),
					new ColorPreset("Magenta", Color.magenta)
				};
			}
			if (_shadowType == null)
			{
				_shadowType = EnumUtils<LightShadows>.Values;
			}
			_shadowStrength = 0f;
			if (_lightType == null)
			{
				_lightType = EnumUtils<LightType>.Values;
			}
			if (_lightShape == null)
			{
				_lightShape = EnumUtils<LightShape>.Values;
			}
			_spotAngle = 30f;
			_innerSpotAngle = 0f;
			GenerateNewSettings();
			ResendSettings();
			ServerSpecificSettingsSync.SendOnJoinFilter = (ReferenceHub _) => false;
			ServerSpecificSettingsSync.ServerOnSettingValueReceived += ProcessUserInput;
		}

		public override void Deactivate()
		{
			ServerSpecificSettingsSync.SendOnJoinFilter = null;
			ServerSpecificSettingsSync.ServerOnSettingValueReceived -= ProcessUserInput;
		}

		private void GenerateNewSettings()
		{
			_allSettings = new List<ServerSpecificSettingBase>
			{
				new SSGroupHeader("Light Spawner"),
				new SSSliderSetting(0, "Intensity", 0f, 100f, _lightIntensity, integer: false, "0.00", "x{0}", null, byte.MaxValue, isServerOnly: true),
				new SSSliderSetting(1, "Range", 0f, 100f, _lightRange, integer: false, "0.00", "x{0}", null, byte.MaxValue, isServerOnly: true),
				new SSDropdownSetting(2, "Color (preset)", _colorPresets.Select((ColorPreset x) => x.Name).ToArray(), 0, SSDropdownSetting.DropdownEntryType.Regular, null, byte.MaxValue, isServerOnly: true),
				new SSPlaintextSetting(3, "Custom Color (R G B)", "...", 10, TMP_InputField.ContentType.Standard, "Leave empty to use a preset.", byte.MaxValue, isServerOnly: true),
				(_selectedColorTextArea = new SSTextArea(4, "Selected color: None")),
				new SSDropdownSetting(5, "Shadow Type", _shadowType.Select((LightShadows x) => x.ToString()).ToArray(), 0, SSDropdownSetting.DropdownEntryType.Regular, null, byte.MaxValue, isServerOnly: true),
				new SSSliderSetting(6, "Shadow Strength", 0f, 100f, _shadowStrength, integer: false, "0.00", "x{0}", null, byte.MaxValue, isServerOnly: true),
				new SSDropdownSetting(7, "Light Type", _lightType.Select((LightType x) => x.ToString()).ToArray(), 0, SSDropdownSetting.DropdownEntryType.Regular, null, byte.MaxValue, isServerOnly: true),
				new SSDropdownSetting(8, "Light Shape", _lightShape.Select((LightShape x) => x.ToString()).ToArray(), 0, SSDropdownSetting.DropdownEntryType.Regular, null, byte.MaxValue, isServerOnly: true),
				new SSSliderSetting(9, "Spot Angle", 0f, 100f, _spotAngle, integer: false, "0.00", "x{0}", null, byte.MaxValue, isServerOnly: true),
				new SSSliderSetting(10, "Inner Spot Angle", 0f, 100f, _innerSpotAngle, integer: false, "0.00", "x{0}", null, byte.MaxValue, isServerOnly: true),
				new SSButton(11, "Confirm Spawning", "Spawn")
			};
		}

		private bool ValidateUser(ReferenceHub user)
		{
			return PermissionsHandler.IsPermitted(user.serverRoles.Permissions, PlayerPermissions.FacilityManagement);
		}

		private void ProcessUserInput(ReferenceHub sender, ServerSpecificSettingBase setting)
		{
			if (ValidateUser(sender) && (!(setting is SSButton sSButton) || !TryDestroy(sSButton.SettingId)))
			{
				switch ((ExampleId)setting.SettingId)
				{
				case ExampleId.ColorPresetDropdown:
					_selectedColorTextArea.SendTextUpdate(GetColorInfoForUser(sender));
					break;
				case ExampleId.DestroyAllButton:
					DestroyAll();
					break;
				case ExampleId.ConfirmButton:
					SpawnLight(sender);
					break;
				}
			}
		}

		private void SpawnLight(ReferenceHub sender)
		{
			LightSourceToy lightSourceToy = null;
			foreach (GameObject value in NetworkClient.prefabs.Values)
			{
				if (value.TryGetComponent<LightSourceToy>(out var component))
				{
					lightSourceToy = UnityEngine.Object.Instantiate(component);
					lightSourceToy.OnSpawned(sender, new ArraySegment<string>(new string[0]));
					break;
				}
			}
			if (!(lightSourceToy == null))
			{
				lightSourceToy.NetworkLightIntensity = GetSettingOfUser<SSSliderSetting>(sender, ExampleId.IntensitySlider).SyncFloatValue;
				lightSourceToy.NetworkLightRange = GetSettingOfUser<SSSliderSetting>(sender, ExampleId.RangeSlider).SyncFloatValue;
				Color color = (lightSourceToy.NetworkLightColor = GetColorForUser(sender));
				int syncSelectionIndexValidated = GetSettingOfUser<SSDropdownSetting>(sender, ExampleId.ShadowType).SyncSelectionIndexValidated;
				lightSourceToy.NetworkShadowType = (LightShadows)syncSelectionIndexValidated;
				lightSourceToy.NetworkShadowStrength = GetSettingOfUser<SSSliderSetting>(sender, ExampleId.ShadowStrength).SyncFloatValue;
				int syncSelectionIndexValidated2 = GetSettingOfUser<SSDropdownSetting>(sender, ExampleId.LightType).SyncSelectionIndexValidated;
				lightSourceToy.NetworkLightType = (LightType)syncSelectionIndexValidated2;
				int syncSelectionIndexValidated3 = GetSettingOfUser<SSDropdownSetting>(sender, ExampleId.LightShape).SyncSelectionIndexValidated;
				lightSourceToy.NetworkLightShape = (LightShape)syncSelectionIndexValidated3;
				lightSourceToy.NetworkSpotAngle = GetSettingOfUser<SSSliderSetting>(sender, ExampleId.SpotAngle).SyncFloatValue;
				lightSourceToy.NetworkInnerSpotAngle = GetSettingOfUser<SSSliderSetting>(sender, ExampleId.InnerSpotAngle).SyncFloatValue;
				if (!_anySpawned)
				{
					_allSettings.Add(new SSGroupHeader("Destroy Spawned Lights"));
					_allSettings.Add(new SSButton(12, "All Lights", "Destroy All (HOLD)", 2f));
					_anySpawned = true;
				}
				string text = $"{lightSourceToy.LightType} Color: {color} SpawnPosition: {lightSourceToy.transform.position}";
				string text2 = "Spawned by " + sender.LoggedNameFromRefHub() + " at round time " + RoundStart.RoundLength.ToString("hh\\:mm\\:ss\\.fff", CultureInfo.InvariantCulture);
				string hint = text + "\n" + text2;
				_allSettings.Add(new SSButton((int)lightSourceToy.netId, $"Light NetID#{lightSourceToy.netId}", "Destroy (HOLD)", 0.4f, hint));
				ResendSettings();
			}
		}

		private void ResendSettings()
		{
			ServerSpecificSettingsSync.DefinedSettings = _allSettings.ToArray();
			ServerSpecificSettingsSync.SendToPlayersConditionally(ValidateUser);
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (ValidateUser(allHub))
				{
					_selectedColorTextArea.SendTextUpdate(GetColorInfoForUser(allHub));
				}
			}
		}

		private void DestroyAll()
		{
			if (_anySpawned)
			{
				int num = _allSettings.Count - 1;
				ServerSpecificSettingBase element;
				while (num > 0 && _allSettings.TryGet(num, out element) && element is SSButton)
				{
					TryDestroy(element.SettingId);
					num--;
				}
			}
		}

		private bool TryDestroy(int buttonId)
		{
			if (!NetworkUtils.SpawnedNetIds.TryGetValue((uint)buttonId, out var value))
			{
				return false;
			}
			if (!value.TryGetComponent<LightSourceToy>(out var component))
			{
				return false;
			}
			for (int i = 0; i < _allSettings.Count; i++)
			{
				ServerSpecificSettingBase serverSpecificSettingBase = _allSettings[i];
				if (serverSpecificSettingBase is SSButton && serverSpecificSettingBase.SettingId == buttonId)
				{
					_allSettings.RemoveAt(i);
					break;
				}
			}
			List<ServerSpecificSettingBase> allSettings = _allSettings;
			ServerSpecificSettingBase serverSpecificSettingBase2 = allSettings[allSettings.Count - 1];
			if (serverSpecificSettingBase2 is SSButton && serverSpecificSettingBase2.SettingId == 12)
			{
				_anySpawned = false;
				GenerateNewSettings();
			}
			NetworkServer.Destroy(component.gameObject);
			ResendSettings();
			return true;
		}

		private T GetSettingOfUser<T>(ReferenceHub user, ExampleId id) where T : ServerSpecificSettingBase
		{
			return ServerSpecificSettingsSync.GetSettingOfUser<T>(user, (int)id);
		}

		private string GetColorInfoForUser(ReferenceHub hub)
		{
			Color colorForUser = GetColorForUser(hub);
			return "Selected color: <color=" + colorForUser.ToHex() + ">███████████</color>";
		}

		private Color GetColorForUser(ReferenceHub user)
		{
			string[] array = GetSettingOfUser<SSPlaintextSetting>(user, ExampleId.CustomColor).SyncInputText.Split(' ');
			int syncSelectionIndexValidated = GetSettingOfUser<SSDropdownSetting>(user, ExampleId.ColorPresetDropdown).SyncSelectionIndexValidated;
			Color color = _colorPresets[syncSelectionIndexValidated].Color;
			float r = ((array.TryGet(0, out var element) && float.TryParse(element, out var result)) ? (result / 255f) : color.r);
			float g = ((array.TryGet(1, out var element2) && float.TryParse(element2, out var result2)) ? (result2 / 255f) : color.g);
			float b = ((array.TryGet(2, out var element3) && float.TryParse(element3, out var result3)) ? (result3 / 255f) : color.b);
			return new Color(r, g, b);
		}
	}
}

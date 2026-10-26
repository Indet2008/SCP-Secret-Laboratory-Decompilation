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
	public class SSPrimitiveSpawnerExample : SSExampleImplementationBase
	{
		private enum ExampleId
		{
			ConfirmButton = 0,
			DestroyAllButton = 1,
			TypeDropdown = 2,
			ColorPresetDropdown = 3,
			ColorField = 4,
			ColorAlphaSlider = 5,
			CollisionsToggle = 6,
			RendererToggle = 7,
			ColorInfo = 8,
			ScaleSliderX = 9,
			ScaleSliderY = 10,
			ScaleSliderZ = 11
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

		private static PrimitiveType[] _primitiveTypes;

		private static ColorPreset[] _colorPresets;

		private static List<ServerSpecificSettingBase> _allSettings;

		private static bool _anySpawned;

		private static SSTextArea _selectedColorTextArea;

		private const PlayerPermissions RequiredPermission = PlayerPermissions.FacilityManagement;

		public override string Name => "Primitive Spawner";

		public override void Activate()
		{
			_anySpawned = false;
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
			if (_primitiveTypes == null)
			{
				_primitiveTypes = EnumUtils<PrimitiveType>.Values;
			}
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
				new SSGroupHeader("Primitive Spawner"),
				new SSDropdownSetting(2, "Type", _primitiveTypes.Select((PrimitiveType x) => x.ToString()).ToArray(), 0, SSDropdownSetting.DropdownEntryType.Regular, null, byte.MaxValue, isServerOnly: true),
				new SSDropdownSetting(3, "Color (preset)", _colorPresets.Select((ColorPreset x) => x.Name).ToArray(), 0, SSDropdownSetting.DropdownEntryType.Regular, null, byte.MaxValue, isServerOnly: true),
				new SSSliderSetting(5, "Opacity", 0f, 100f, 100f, integer: true, "0.##", "{0}%", null, byte.MaxValue, isServerOnly: true),
				new SSPlaintextSetting(4, "Custom Color (R G B)", "...", 11, TMP_InputField.ContentType.Standard, "Leave empty to use a preset.", byte.MaxValue, isServerOnly: true),
				(_selectedColorTextArea = new SSTextArea(8, "Selected color: None")),
				new SSTwoButtonsSetting(6, "Collisions", "Disabled", "Enabled", defaultIsB: true, null, byte.MaxValue, isServerOnly: true),
				new SSTwoButtonsSetting(7, "Renderer", "Invisible", "Visible", defaultIsB: true, "Invisible primitives can still receive collisions.", byte.MaxValue, isServerOnly: true),
				new SSSliderSetting(9, "Scale (X)", 0f, 25f, 1f, integer: false, "0.00", "x{0}", null, byte.MaxValue, isServerOnly: true),
				new SSSliderSetting(10, "Scale (Y)", 0f, 25f, 1f, integer: false, "0.00", "x{0}", null, byte.MaxValue, isServerOnly: true),
				new SSSliderSetting(11, "Scale (Z)", 0f, 25f, 1f, integer: false, "0.00", "x{0}", null, byte.MaxValue, isServerOnly: true),
				new SSButton(0, "Confirm Spawning", "Spawn")
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
				case ExampleId.ColorField:
				case ExampleId.ColorAlphaSlider:
					_selectedColorTextArea.SendTextUpdate(GetColorInfoForUser(sender), applyOverride: false);
					break;
				case ExampleId.DestroyAllButton:
					DestroyAll();
					break;
				case ExampleId.ConfirmButton:
					SpawnPrimitive(sender);
					break;
				case ExampleId.TypeDropdown:
					break;
				}
			}
		}

		private void SpawnPrimitive(ReferenceHub sender)
		{
			PrimitiveObjectToy primitiveObjectToy = null;
			foreach (GameObject value in NetworkClient.prefabs.Values)
			{
				if (value.TryGetComponent<PrimitiveObjectToy>(out var component))
				{
					primitiveObjectToy = UnityEngine.Object.Instantiate(component);
					primitiveObjectToy.OnSpawned(sender, new ArraySegment<string>(new string[0]));
					break;
				}
			}
			if (!(primitiveObjectToy == null))
			{
				int syncSelectionIndexValidated = GetSettingOfUser<SSDropdownSetting>(sender, ExampleId.TypeDropdown).SyncSelectionIndexValidated;
				primitiveObjectToy.NetworkPrimitiveType = (PrimitiveType)syncSelectionIndexValidated;
				Color color = (primitiveObjectToy.NetworkMaterialColor = GetColorForUser(sender));
				float syncFloatValue = GetSettingOfUser<SSSliderSetting>(sender, ExampleId.ScaleSliderX).SyncFloatValue;
				float syncFloatValue2 = GetSettingOfUser<SSSliderSetting>(sender, ExampleId.ScaleSliderY).SyncFloatValue;
				float syncFloatValue3 = GetSettingOfUser<SSSliderSetting>(sender, ExampleId.ScaleSliderZ).SyncFloatValue;
				Vector3 vector = new Vector3(syncFloatValue, syncFloatValue2, syncFloatValue3);
				primitiveObjectToy.transform.localScale = vector;
				primitiveObjectToy.NetworkScale = vector;
				PrimitiveFlags primitiveFlags = (GetSettingOfUser<SSTwoButtonsSetting>(sender, ExampleId.CollisionsToggle).SyncIsB ? PrimitiveFlags.Collidable : PrimitiveFlags.None);
				PrimitiveFlags primitiveFlags2 = (GetSettingOfUser<SSTwoButtonsSetting>(sender, ExampleId.RendererToggle).SyncIsB ? PrimitiveFlags.Visible : PrimitiveFlags.None);
				primitiveObjectToy.NetworkPrimitiveFlags = primitiveFlags | primitiveFlags2;
				if (!_anySpawned)
				{
					_allSettings.Add(new SSGroupHeader("Destroy Spawned Primitives"));
					_allSettings.Add(new SSButton(1, "All Primitives", "Destroy All (HOLD)", 2f));
					_anySpawned = true;
				}
				string text = $"{primitiveObjectToy.PrimitiveType} Color: {color} Size: {vector} SpawnPosition: {primitiveObjectToy.transform.position}";
				string text2 = "Spawned by " + sender.LoggedNameFromRefHub() + " at round time " + RoundStart.RoundLength.ToString("hh\\:mm\\:ss\\.fff", CultureInfo.InvariantCulture);
				string hint = text + "\n" + text2;
				_allSettings.Add(new SSButton((int)primitiveObjectToy.netId, $"Primitive NetID#{primitiveObjectToy.netId}", "Destroy (HOLD)", 0.4f, hint));
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
			if (!value.TryGetComponent<PrimitiveObjectToy>(out var component))
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
			if (serverSpecificSettingBase2 is SSButton && serverSpecificSettingBase2.SettingId == 1)
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
			string[] array = GetSettingOfUser<SSPlaintextSetting>(user, ExampleId.ColorField).SyncInputText.Split(' ');
			int syncSelectionIndexValidated = GetSettingOfUser<SSDropdownSetting>(user, ExampleId.ColorPresetDropdown).SyncSelectionIndexValidated;
			Color color = _colorPresets[syncSelectionIndexValidated].Color;
			float r = ((array.TryGet(0, out var element) && float.TryParse(element, out var result)) ? (result / 255f) : color.r);
			float g = ((array.TryGet(1, out var element2) && float.TryParse(element2, out var result2)) ? (result2 / 255f) : color.g);
			float b = ((array.TryGet(2, out var element3) && float.TryParse(element3, out var result3)) ? (result3 / 255f) : color.b);
			float a = GetSettingOfUser<SSSliderSetting>(user, ExampleId.ColorAlphaSlider).SyncFloatValue / 100f;
			return new Color(r, g, b, a);
		}
	}
}

using System;
using System.Collections.Generic;
using RemoteAdmin.Settings;
using TMPro;
using UnityEngine;

namespace RemoteAdmin.Menus
{
	public class RaSettings : MonoBehaviour
	{
		[SerializeField]
		private TMP_Text _display;

		private static RaSettings _singleton;

		private bool _loaded;

		// The settings tab can be inactive, so Awake/Start may never run before the settings are needed.
		public static RaSettings Singleton
		{
			get
			{
				if (_singleton == null)
				{
					_singleton = UnityEngine.Object.FindFirstObjectByType<RaSettings>(FindObjectsInactive.Include);
				}
				if (_singleton != null)
				{
					_singleton.EnsureLoaded();
				}
				return _singleton;
			}
			private set
			{
				_singleton = value;
			}
		}

		private void EnsureLoaded()
		{
			if (!_loaded)
			{
				_loaded = true;
				Load();
			}
		}

		[field: SerializeField]
		public ToggleMovementSetting ToggleMovement { get; set; } = new ToggleMovementSetting();

		[field: SerializeField]
		public ToggleItemOrderSetting ToggleItemOrder { get; set; } = new ToggleItemOrderSetting();

		[field: SerializeField]
		public ToggleListOrderSetting ToggleListOrder { get; set; } = new ToggleListOrderSetting();

		[field: SerializeField]
		public ToggleSuggestionsSetting ToggleSuggestions { get; set; } = new ToggleSuggestionsSetting();

		[field: SerializeField]
		public ToggleTimestampsSetting ToggleTimestamps { get; set; } = new ToggleTimestampsSetting();

		[field: SerializeField]
		public BandwidthCooldownSetting BandwidthCooldown { get; set; } = new BandwidthCooldownSetting();

		[field: SerializeField]
		public PlayerListSortingSetting PlayerListSorting { get; set; } = new PlayerListSortingSetting();

		[field: SerializeField]
		public ToggleSpawnpointSetting ToggleSpawnpoint { get; set; } = new ToggleSpawnpointSetting();

		[field: SerializeField]
		public ToggleResetInventorySetting ToggleResetInventory { get; set; } = new ToggleResetInventorySetting();

		[field: SerializeField]
		public ToggleTooltipSetting ToggleTooltip { get; set; } = new ToggleTooltipSetting();

		[field: SerializeField]
		public TooltipHideDelaySetting HideTooltipDelay { get; set; } = new TooltipHideDelaySetting();

		[field: SerializeField]
		public TooltipShowDelaySetting ShowTooltipDelay { get; set; } = new TooltipShowDelaySetting();

		[field: SerializeField]
		public RedWindowSetting WindowRed { get; set; } = new RedWindowSetting();

		[field: SerializeField]
		public GreenWindowSetting WindowGreen { get; set; } = new GreenWindowSetting();

		[field: SerializeField]
		public BlueWindowSetting WindowBlue { get; set; } = new BlueWindowSetting();

		[field: SerializeField]
		public AlphaWindowSetting WindowAlpha { get; set; } = new AlphaWindowSetting();

		// Seconds between the Round/Map menus' status requests ("Bandwidth Cooldown").
		public static float CurrentBandwidthCooldown
		{
			get
			{
				RaSettings singleton = Singleton;
				if (singleton != null && singleton.BandwidthCooldown.Value > 0f)
				{
					return singleton.BandwidthCooldown.Value;
				}
				return 1f;
			}
		}

		public static event Action OnLoad;

		public static event Action OnReset;

		public static event Action OnSave;

		private IEnumerable<Action> AllLoads()
		{
			yield return ToggleMovement.Load;
			yield return ToggleItemOrder.Load;
			yield return ToggleListOrder.Load;
			yield return ToggleSuggestions.Load;
			yield return ToggleTimestamps.Load;
			yield return BandwidthCooldown.Load;
			yield return PlayerListSorting.Load;
			yield return ToggleSpawnpoint.Load;
			yield return ToggleResetInventory.Load;
			yield return ToggleTooltip.Load;
			yield return HideTooltipDelay.Load;
			yield return ShowTooltipDelay.Load;
			yield return WindowRed.Load;
			yield return WindowGreen.Load;
			yield return WindowBlue.Load;
			yield return WindowAlpha.Load;
		}

		private IEnumerable<Action> AllSaves()
		{
			yield return ToggleMovement.Save;
			yield return ToggleItemOrder.Save;
			yield return ToggleListOrder.Save;
			yield return ToggleSuggestions.Save;
			yield return ToggleTimestamps.Save;
			yield return BandwidthCooldown.Save;
			yield return PlayerListSorting.Save;
			yield return ToggleSpawnpoint.Save;
			yield return ToggleResetInventory.Save;
			yield return ToggleTooltip.Save;
			yield return HideTooltipDelay.Save;
			yield return ShowTooltipDelay.Save;
			yield return WindowRed.Save;
			yield return WindowGreen.Save;
			yield return WindowBlue.Save;
			yield return WindowAlpha.Save;
		}

		private IEnumerable<Action> AllResets()
		{
			yield return ToggleMovement.Reset;
			yield return ToggleItemOrder.Reset;
			yield return ToggleListOrder.Reset;
			yield return ToggleSuggestions.Reset;
			yield return ToggleTimestamps.Reset;
			yield return BandwidthCooldown.Reset;
			yield return PlayerListSorting.Reset;
			yield return ToggleSpawnpoint.Reset;
			yield return ToggleResetInventory.Reset;
			yield return ToggleTooltip.Reset;
			yield return HideTooltipDelay.Reset;
			yield return ShowTooltipDelay.Reset;
			yield return WindowRed.Reset;
			yield return WindowGreen.Reset;
			yield return WindowBlue.Reset;
			yield return WindowAlpha.Reset;
		}

		private static void RunAll(IEnumerable<Action> actions)
		{
			foreach (Action action in actions)
			{
				try
				{
					action();
				}
				catch (Exception exception)
				{
					Debug.LogException(exception);
				}
			}
		}

		private void SetDisplay(bool updateDisplay, string text)
		{
			if (updateDisplay && _display != null)
			{
				_display.text = text;
			}
		}

		public void Save(bool updateDisplay = false)
		{
			RunAll(AllSaves());
			RaSettings.OnSave?.Invoke();
			SetDisplay(updateDisplay, "Settings saved.");
		}

		public void Load(bool updateDisplay = false)
		{
			RunAll(AllLoads());
			RaSettings.OnLoad?.Invoke();
			SetDisplay(updateDisplay, "Settings loaded.");
		}

		public void ForceReset(bool updateDisplay = false)
		{
			RunAll(AllResets());
			RaSettings.OnReset?.Invoke();
			SetDisplay(updateDisplay, "Settings reset.");
		}

		public void ToggleListOrdering()
		{
			EnsureLoaded();
			ToggleListOrder.Toggle();
		}

		public void ToggleItemOrdering()
		{
			EnsureLoaded();
			ToggleItemOrder.Toggle();
		}

		public void RefreshTooltipShowDelay()
		{
			EnsureLoaded();
			ShowTooltipDelay.SliderToValue();
		}

		public void RefreshTooltipHideDelay()
		{
			EnsureLoaded();
			HideTooltipDelay.SliderToValue();
		}

		public void RefreshTimestampsToggle()
		{
			EnsureLoaded();
			ToggleTimestamps.Toggle();
			RaSettings.OnSave?.Invoke();
		}

		public void RefreshBandwithCooldown()
		{
			EnsureLoaded();
			BandwidthCooldown.SliderToValue();
		}

		public void RefreshMovementToggle()
		{
			EnsureLoaded();
			ToggleMovement.Toggle();
		}

		public void RefreshTooltipsToggle()
		{
			EnsureLoaded();
			ToggleTooltip.Toggle();
		}

		public void RefreshSuggestionsToggle()
		{
			EnsureLoaded();
			ToggleSuggestions.Toggle();
		}

		public void RefreshSpawnpointToggle()
		{
			EnsureLoaded();
			ToggleSpawnpoint.Toggle();
		}

		public void RefreshResetInventoryToggle()
		{
			EnsureLoaded();
			ToggleResetInventory.Toggle();
		}

		private void Awake()
		{
			_singleton = this;
		}

		private void Start()
		{
			EnsureLoaded();
		}

		private void OnDestroy()
		{
			if (_singleton == this)
			{
				_singleton = null;
			}
		}
	}
}

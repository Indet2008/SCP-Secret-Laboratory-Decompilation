using System.Collections.Generic;
using System.Linq;
using System.Text;
using Interactables.Interobjects;
using Interactables.Interobjects.DoorUtils;
using MapGeneration;
using RemoteAdmin.Elements;
using RemoteAdmin.Presets;
using TMPro;
using UnityEngine;

namespace RemoteAdmin.Menus
{
	public class MapControlMenu : RaCommandMenu
	{
		private const string DefaultOverchargeValue = "3600";

		[SerializeField]
		internal ColorPreset Closed;

		[SerializeField]
		internal ColorPreset Opened;

		[SerializeField]
		internal ColorPreset Moving;

		[SerializeField]
		internal ColorPreset Unselected;

		[SerializeField]
		internal ColorPreset Selected;

		[SerializeField]
		internal ColorPreset LockedUnselected;

		[SerializeField]
		internal ColorPreset LockedSelected;

		[SerializeField]
		private RaDoorButton _doorButtonTemplate;

		[SerializeField]
		private RaElevatorButton _elevatorButtonTemplate;

		[SerializeField]
		private Transform _rootParent;

		[SerializeField]
		private Transform _elevatorRootParent;

		[SerializeField]
		private TMP_Dropdown _zoneDropdown;

		[SerializeField]
		private TMP_InputField _overchargeDuration;

		[SerializeField]
		private TMP_InputField _lockdownDuration;

		[SerializeField]
		private TMP_InputField _cleanupAmount;

		[SerializeField]
		private TMP_InputField _dummyUsername;

		private float _updateTimer;

		private readonly List<RaDoorButton> _doorButtons = new List<RaDoorButton>();

		private readonly List<RaElevatorButton> _elevatorButtons = new List<RaElevatorButton>();

		private int _spawnedDoorCount = -1;

		public void RefreshButtons()
		{
			foreach (RaDoorButton doorButton in _doorButtons)
			{
				if (doorButton != null)
				{
					doorButton.UpdateGraphics();
				}
			}
			foreach (RaElevatorButton elevatorButton in _elevatorButtons)
			{
				if (elevatorButton != null)
				{
					elevatorButton.UpdateGraphics();
				}
			}
		}

		public void FilterDoors()
		{
			int num = ((_zoneDropdown != null) ? _zoneDropdown.value : 0);
			foreach (RaDoorButton doorButton in _doorButtons)
			{
				if (doorButton == null)
				{
					continue;
				}
				DoorVariant doorVariant = ((doorButton.Door != null) ? doorButton.Door.TargetDoor : null);
				bool flag = doorVariant != null;
				if (flag && num != 0)
				{
					flag = false;
					RoomIdentifier[] rooms = doorVariant.Rooms;
					if (rooms != null)
					{
						RoomIdentifier[] array = rooms;
						foreach (RoomIdentifier roomIdentifier in array)
						{
							if (roomIdentifier != null && (int)roomIdentifier.Zone == num)
							{
								flag = true;
								break;
							}
						}
					}
				}
				doorButton.gameObject.SetActive(flag);
			}
		}

		protected override string BuildCommand(string command, string format)
		{
			StringBuilder builder = new StringBuilder();
			string text = ((_overchargeDuration != null) ? _overchargeDuration.text : string.Empty);
			if (string.IsNullOrEmpty(text))
			{
				text = DefaultOverchargeValue;
			}
			object[] args = new object[8]
			{
				command,
				GetSelectedPlayers(builder),
				GetSelectedOptions(builder),
				GetInputFieldText(),
				text,
				(_lockdownDuration != null) ? _lockdownDuration.text : string.Empty,
				(_cleanupAmount != null) ? _cleanupAmount.text : string.Empty,
				(_dummyUsername != null) ? _dummyUsername.text : string.Empty
			};
			try
			{
				return string.Format(format, args);
			}
			catch (System.FormatException)
			{
				return command;
			}
		}

		protected override void OnUpdate()
		{
			if (!(_updateTimer > Time.unscaledTime))
			{
				_updateTimer = Time.unscaledTime + 1f;
				if (_spawnedDoorCount != DoorNametagExtension.NamedDoors.Count)
				{
					SpawnButtons();
				}
				RefreshButtons();
			}
		}

		protected override void OnStart()
		{
			if (_doorButtonTemplate != null)
			{
				base.Options.Remove(_doorButtonTemplate);
				_doorButtonTemplate.gameObject.SetActive(value: false);
			}
			if (_elevatorButtonTemplate != null)
			{
				base.Options.Remove(_elevatorButtonTemplate);
				_elevatorButtonTemplate.gameObject.SetActive(value: false);
			}
			SpawnButtons();
		}

		private void SpawnButtons()
		{
			_spawnedDoorCount = DoorNametagExtension.NamedDoors.Count;
			foreach (RaDoorButton doorButton in _doorButtons)
			{
				if (doorButton != null)
				{
					base.Options.Remove(doorButton);
					Object.Destroy(doorButton.gameObject);
				}
			}
			_doorButtons.Clear();
			foreach (RaElevatorButton elevatorButton in _elevatorButtons)
			{
				if (elevatorButton != null)
				{
					base.Options.Remove(elevatorButton);
					Object.Destroy(elevatorButton.gameObject);
				}
			}
			_elevatorButtons.Clear();
			if (_doorButtonTemplate != null && _rootParent != null)
			{
				foreach (DoorNametagExtension item in DoorNametagExtension.NamedDoors.Values.Where((DoorNametagExtension x) => x != null).OrderBy((DoorNametagExtension x) => x.GetName))
				{
					RaDoorButton raDoorButton = Object.Instantiate(_doorButtonTemplate, _rootParent);
					raDoorButton.gameObject.SetActive(value: true);
					raDoorButton.Door = item;
					raDoorButton.CommandMenu = this;
					raDoorButton.Setup();
					if (!base.Options.Contains(raDoorButton))
					{
						base.Options.Add(raDoorButton);
					}
					_doorButtons.Add(raDoorButton);
				}
			}
			if (_elevatorButtonTemplate != null && _elevatorRootParent != null)
			{
				foreach (ElevatorChamber allChamber in ElevatorChamber.AllChambers)
				{
					if (!(allChamber == null))
					{
						RaElevatorButton raElevatorButton = Object.Instantiate(_elevatorButtonTemplate, _elevatorRootParent);
						raElevatorButton.gameObject.SetActive(value: true);
						raElevatorButton.Target = allChamber;
						raElevatorButton.CommandMenu = this;
						raElevatorButton.Setup();
						if (!base.Options.Contains(raElevatorButton))
						{
							base.Options.Add(raElevatorButton);
						}
						_elevatorButtons.Add(raElevatorButton);
					}
				}
			}
			FilterDoors();
		}
	}
}
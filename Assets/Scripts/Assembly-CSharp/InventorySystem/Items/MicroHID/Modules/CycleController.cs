using System;
using System.Collections.Generic;
using InventorySystem.Items.Autosync;
using InventorySystem.Items.Pickups;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.MicroHID.Modules
{
	public class CycleController
	{
		private const float MinIdleCooldown = 1.5f;

		private float _windUpProgress;

		private float _serverIdleTimer;

		private bool _hasOwner;

		private MicroHidPhase _phase;

		private MicroHIDItem _prevItem;

		private readonly List<FiringModeControllerModule> _firingModeControllers = new List<FiringModeControllerModule>();

		private readonly Dictionary<MicroHidPhase, double> _lastChangeTimes = new Dictionary<MicroHidPhase, double>();

		public readonly ushort Serial;

		public float ServerWindUpProgress
		{
			get
			{
				return _windUpProgress;
			}
			private set
			{
				_windUpProgress = Mathf.Clamp01(value);
			}
		}

		public float CurrentPhaseElapsed
		{
			get
			{
				if (!TryGetElapsed(Phase, out var elapsed))
				{
					return Time.timeSinceLevelLoad;
				}
				return elapsed;
			}
		}

		public MicroHidPhase Phase
		{
			get
			{
				return _phase;
			}
			set
			{
				if (_phase != value)
				{
					_phase = value;
					_lastChangeTimes[value] = NetworkTime.time;
					OnPhaseChanged?.Invoke(Serial, value);
				}
			}
		}

		public MicroHidFiringMode LastFiringMode { get; set; }

		public static event Action<ushort, MicroHidPhase> OnPhaseChanged;

		public CycleController(ushort serial)
		{
			Serial = serial;
		}

		public void ServerUpdateHeldItem(MicroHIDItem item)
		{
			if (item.ItemSerial != Serial)
			{
				throw new ArgumentException("The provided held MicroHID has a serial number that does not match the controller.", "item");
			}
			if (item != _prevItem)
			{
				RecacheFiringModes(item);
				_prevItem = item;
			}
			_hasOwner = true;
			UpdatePhase();
		}

		public void ServerUpdatePickup(MicroHIDPickup pickup)
		{
			PickupSyncInfo info = pickup.Info;
			if (info.Serial != Serial)
			{
				throw new ArgumentException("The provided MicroHID pickup has a serial number that does not match the controller.", "pickup");
			}
			if (_hasOwner)
			{
				_hasOwner = false;
				_prevItem = null;
				RecacheFiringModes(info.ItemId.GetTemplate<MicroHIDItem>());
			}
			UpdatePhase();
		}

		public bool TryGetElapsed(MicroHidPhase phase, out float elapsed)
		{
			if (_lastChangeTimes.TryGetValue(phase, out var value))
			{
				elapsed = (float)(NetworkTime.time - value);
				return true;
			}
			elapsed = 0f;
			return false;
		}

		public bool TryGetLastFiringController(out FiringModeControllerModule ret)
		{
			if (!NetworkServer.active && _firingModeControllers.Count == 0)
			{
				RecacheFiringModes(ItemType.MicroHID.GetTemplate<MicroHIDItem>());
			}
			foreach (FiringModeControllerModule firingModeController in _firingModeControllers)
			{
				if (firingModeController.AssignedMode == LastFiringMode)
				{
					ret = firingModeController;
					return true;
				}
			}
			ret = null;
			return false;
		}

		private void RecacheFiringModes(MicroHIDItem item)
		{
			_firingModeControllers.Clear();
			SubcomponentBase[] allSubcomponents = item.AllSubcomponents;
			for (int i = 0; i < allSubcomponents.Length; i++)
			{
				if (allSubcomponents[i] is FiringModeControllerModule item2)
				{
					_firingModeControllers.Add(item2);
				}
			}
		}

		private void UpdatePhase()
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Attempting to update phase as a client");
			}
			switch (Phase)
			{
			case MicroHidPhase.Standby:
				UpdateStandby();
				return;
			case MicroHidPhase.WindingUp:
				UpdateWindingUp();
				break;
			case MicroHidPhase.WindingDown:
				UpdateWindingDown();
				break;
			case MicroHidPhase.WoundUpSustain:
				UpdateWoundUp();
				break;
			case MicroHidPhase.Firing:
				UpdateFiring();
				break;
			default:
				throw new InvalidOperationException(string.Format("Unknown {0}: {1}", "MicroHidPhase", Phase));
			}
			if (_hasOwner && TryGetLastFiringController(out var ret))
			{
				ret.ServerUpdateSelected(Phase);
			}
		}

		private void UpdateStandby()
		{
			if (_serverIdleTimer < 1.5f)
			{
				_serverIdleTimer += Time.deltaTime;
			}
			else
			{
				if (!_hasOwner)
				{
					return;
				}
				foreach (FiringModeControllerModule firingModeController in _firingModeControllers)
				{
					if (firingModeController.ValidateStart && firingModeController.ValidateUpdate)
					{
						_serverIdleTimer = 0f;
						Phase = MicroHidPhase.WindingUp;
						LastFiringMode = firingModeController.AssignedMode;
						break;
					}
				}
			}
		}

		private void UpdateWindingUp()
		{
			if (TryGetLastFiringController(out var ret))
			{
				ServerWindUpProgress += ret.WindUpRate * Time.deltaTime;
				if (!_hasOwner || !ret.ValidateUpdate)
				{
					Phase = MicroHidPhase.WindingDown;
				}
				else if (ServerWindUpProgress >= 1f)
				{
					Phase = (ret.ValidateEnterFire ? MicroHidPhase.Firing : MicroHidPhase.WoundUpSustain);
				}
			}
		}

		private void UpdateWindingDown()
		{
			if (TryGetLastFiringController(out var ret))
			{
				ServerWindUpProgress -= ret.WindDownRate * Time.deltaTime;
				if (ServerWindUpProgress <= 0f)
				{
					Phase = MicroHidPhase.Standby;
				}
			}
		}

		private void UpdateWoundUp()
		{
			if (TryGetLastFiringController(out var ret))
			{
				if (!_hasOwner || !ret.ValidateUpdate)
				{
					Phase = MicroHidPhase.WindingDown;
				}
				else if (ret.ValidateEnterFire)
				{
					Phase = MicroHidPhase.Firing;
				}
			}
		}

		private void UpdateFiring()
		{
			if (TryGetLastFiringController(out var ret) && (!_hasOwner || !ret.ValidateUpdate))
			{
				Phase = MicroHidPhase.WindingDown;
			}
		}
	}
}

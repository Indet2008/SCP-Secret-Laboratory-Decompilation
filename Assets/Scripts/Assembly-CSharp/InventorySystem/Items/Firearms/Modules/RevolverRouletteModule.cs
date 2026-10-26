using System;
using InventorySystem.Items.Firearms.Modules.Misc;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class RevolverRouletteModule : ModuleBase, IBusyIndicatorModule, IAdsPreventerModule
	{
		private readonly ClientRequestTimer _requestTimer = new ClientRequestTimer();

		private CylinderAmmoModule _cylinderModule;

		private DoubleActionModule _doubleActionModule;

		private float _keyHoldTime;

		private bool _busy;

		public bool IsBusy
		{
			get
			{
				if (!_busy)
				{
					return _requestTimer.Busy;
				}
				return true;
			}
		}

		public bool AdsAllowed => !_busy;

		protected override void OnInit()
		{
			base.OnInit();
			if (!base.Firearm.TryGetModules<DoubleActionModule, CylinderAmmoModule>(out _doubleActionModule, out _cylinderModule))
			{
				throw new InvalidOperationException("The " + base.Firearm.name + " is missing one or more essential modules (required by " + base.name + ").");
			}
		}

		internal override void OnHolstered()
		{
			base.OnHolstered();
			_busy = false;
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			if (!base.IsControllable || base.PrimaryActionBlocked)
			{
				return;
			}
			if (!GetAction(ActionName.WeaponAlt) || base.Firearm.AnyModuleBusy())
			{
				_keyHoldTime = 0f;
				return;
			}
			_keyHoldTime += Time.deltaTime;
			if (_keyHoldTime > 1f)
			{
				_requestTimer.Trigger();
				SendCmd();
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			ServerTrySpin();
		}

		public override void ClientProcessRpcInstance(NetworkReader reader)
		{
			base.ClientProcessRpcInstance(reader);
			_busy = true;
			if (_doubleActionModule.Cocked)
			{
				_doubleActionModule.TriggerDecocking(FirearmAnimatorHashes.Roulette);
			}
			else
			{
				base.Firearm.AnimSetTrigger(FirearmAnimatorHashes.Roulette);
			}
		}

		public bool ServerTrySpin()
		{
			if (!base.IsLocalPlayer && base.Firearm.AnyModuleBusy())
			{
				return false;
			}
			PlayerSpinningRevolverEventArgs e = new PlayerSpinningRevolverEventArgs(base.Firearm.Owner, base.Firearm);
			PlayerEvents.OnSpinningRevolver(e);
			if (!e.IsAllowed)
			{
				return false;
			}
			SendRpc();
			return true;
		}

		[ExposedFirearmEvent]
		public void ServerRandomize()
		{
			if (base.IsServer)
			{
				int ammoMax = _cylinderModule.AmmoMax;
				int rotations = UnityEngine.Random.Range(0, ammoMax);
				_cylinderModule.RotateCylinder(rotations);
			}
		}

		[ExposedFirearmEvent]
		public void EndSpin()
		{
			_busy = false;
			PlayerEvents.OnSpinnedRevolver(new PlayerSpinnedRevolverEventArgs(base.Firearm.Owner, base.Firearm));
		}
	}
}

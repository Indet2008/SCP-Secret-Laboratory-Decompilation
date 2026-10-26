using System;
using System.Collections.Generic;
using Footprinting;
using InventorySystem.Items.Autosync;
using InventorySystem.Items.Firearms.Extensions;
using InventorySystem.Items.Firearms.Modules.Misc;
using InventorySystem.Items.Firearms.ShotEvents;
using InventorySystem.Items.Pickups;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace InventorySystem.Items.Firearms.Modules
{
	public class DisruptorActionModule : ModuleBase, IReloaderModule, IActionModule, IBusyIndicatorModule
	{
		private enum MessageType
		{
			RpcRequireReloadTrue = 0,
			RpcRequireReloadFalse = 1,
			RpcRequireReloadFullResync = 2,
			RpcStartFiring = 3,
			RpcStopFiring = 4,
			RpcOnShot = 5,
			CmdRequestStartFiring = 6,
			CmdConfirmDischarge = 7
		}

		public enum FiringState
		{
			None = 0,
			FiringRapid = 1,
			FiringSingle = 2
		}

		private const float ShotTicketTimeout = 0.07f;

		private static readonly int FireSingleNormalHash = Animator.StringToHash("FireSingle");

		private static readonly int FireSingleLastHash = Animator.StringToHash("FireSingleLast");

		private static readonly int FireRapidNormalHash = Animator.StringToHash("FireRapid");

		private static readonly int FireRapidLastHash = Animator.StringToHash("FireRapidLast");

		private static readonly int StopFireHash = Animator.StringToHash("StopFire");

		private static readonly HashSet<ushort> ReloadRequiredSerials = new HashSet<ushort>();

		private readonly FullAutoShotsQueue<ShotBacktrackData> _receivedShots = new FullAutoShotsQueue<ShotBacktrackData>((ShotBacktrackData x) => x);

		private readonly Queue<double> _shotTickets = new Queue<double>();

		private MagazineModule _magModule;

		private DisruptorModeSelector _modeSelector;

		private DisruptorAudioModule _audioModule;

		private FiringState _curFiringState;

		private FiringState _lastActiveFiringState;

		private float _firingElapsed;

		[SerializeField]
		private float[] _singleShotTimes;

		[SerializeField]
		private float[] _rapidShotTimes;

		public FiringState CurFiringState
		{
			get
			{
				return _curFiringState;
			}
			private set
			{
				_curFiringState = value;
				if (value != FiringState.None)
				{
					_lastActiveFiringState = value;
				}
				else
				{
					_firingElapsed = 0f;
				}
			}
		}

		public bool IsFiring => CurFiringState != FiringState.None;

		public bool IsReloading => GetDisplayReloadingOrUnloading(base.ItemSerial);

		public bool IsUnloading => false;

		public bool IsLoaded
		{
			get
			{
				if (_magModule.AmmoStored <= 0)
				{
					return CurFiringState != FiringState.None;
				}
				return true;
			}
		}

		public bool IsBusy
		{
			get
			{
				if (!IsFiring)
				{
					return IsReloading;
				}
				return true;
			}
		}

		[field: SerializeField]
		public float DisplayCyclicRate { get; private set; }

		[ExposedFirearmEvent]
		public void EndShootingAnimation()
		{
			CurFiringState = FiringState.None;
			ReloadRequiredSerials.Add(base.ItemSerial);
			base.Firearm.AnimSetTrigger(FirearmAnimatorHashes.StartReloadOrUnload);
			if (base.IsServer)
			{
				SendRpc((NetworkWriter x) =>
				{
					x.WriteSubheader(MessageType.RpcRequireReloadTrue);
				});
			}
		}

		[ExposedFirearmEvent]
		public void FinishReloading()
		{
			if (base.IsServer)
			{
				SendRpc((NetworkWriter x) =>
				{
					x.WriteSubheader(MessageType.RpcRequireReloadFalse);
				});
			}
		}

		public bool GetDisplayReloadingOrUnloading(ushort serial)
		{
			return ReloadRequiredSerials.Contains(serial);
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			switch ((MessageType)reader.ReadByte())
			{
			case MessageType.RpcRequireReloadFullResync:
				ReloadRequiredSerials.Clear();
				while (reader.Remaining > 0)
				{
					ReloadRequiredSerials.Add(reader.ReadUShort());
				}
				break;
			case MessageType.RpcRequireReloadTrue:
				ReloadRequiredSerials.Add(serial);
				break;
			case MessageType.RpcRequireReloadFalse:
			case MessageType.RpcStopFiring:
				ReloadRequiredSerials.Remove(serial);
				break;
			case MessageType.RpcOnShot:
			{
				FiringState state = (FiringState)reader.ReadByte();
				ShotEventManager.Trigger(new DisruptorShotEvent(new ItemIdentifier(base.Firearm.ItemTypeId, serial), default, state));
				break;
			}
			case MessageType.RpcStartFiring:
				break;
			}
		}

		public override void ClientProcessRpcInstance(NetworkReader reader)
		{
			base.ClientProcessRpcInstance(reader);
			switch ((MessageType)reader.ReadByte())
			{
			case MessageType.RpcStartFiring:
				if (!base.IsLocalPlayer || base.IsServer)
				{
					bool singleMode = reader.ReadBool();
					bool last = reader.ReadBool();
					StartFiring(singleMode, last);
				}
				break;
			case MessageType.RpcStopFiring:
				base.Firearm.AnimSetTrigger(StopFireHash);
				CurFiringState = FiringState.None;
				_audioModule.StopDisruptorShot();
				break;
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			switch ((MessageType)reader.ReadByte())
			{
			case MessageType.CmdRequestStartFiring:
			{
				bool ads = reader.ReadBool();
				if (!base.PrimaryActionBlocked)
				{
					ServerProcessStartCmd(ads);
				}
				break;
			}
			case MessageType.CmdConfirmDischarge:
				if (!base.PrimaryActionBlocked)
				{
					_receivedShots.Enqueue(new ShotBacktrackData(reader));
					ServerUpdateShotRequests();
				}
				break;
			}
		}

		protected override void OnInit()
		{
			base.OnInit();
			if (!base.Firearm.TryGetModules<MagazineModule, DisruptorModeSelector, DisruptorAudioModule>(out _magModule, out _modeSelector, out _audioModule))
			{
				throw new NotImplementedException("The DisruptorActionModule does not implement all modules necessary for its operation.");
			}
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			UpdateAction();
			base.Firearm.AnimSetBool(FirearmAnimatorHashes.Reload, IsReloading);
			if (base.IsControllable)
			{
				ClientUpdate();
			}
			if (base.IsServer)
			{
				ServerUpdateShotRequests();
			}
		}

		internal override void OnClientReady()
		{
			base.OnClientReady();
			ReloadRequiredSerials.Clear();
		}

		internal override void ServerOnPlayerConnected(ReferenceHub hub, bool firstModule)
		{
			base.ServerOnPlayerConnected(hub, firstModule);
			if (firstModule)
			{
				SendRpc(hub, (NetworkWriter x) =>
				{
					x.WriteSubheader(MessageType.RpcRequireReloadFullResync);
					ReloadRequiredSerials.ForEach(x.WriteUShort);
				});
			}
		}

		internal override void OnRemoved(ItemPickupBase pickupBase)
		{
			base.OnRemoved(pickupBase);
			if (!(pickupBase is FirearmPickup firearmPickup) || pickupBase == null || !TryGetCurStateTimes(out var times) || !firearmPickup.Worldmodel.TryGetExtension<DisruptorWorldmodelActionExtension>(out var extension))
			{
				return;
			}
			float[] array = new float[times.Length];
			for (int i = 0; i < times.Length; i++)
			{
				array[i] = times[i] - _firingElapsed;
			}
			extension.ServerScheduleShot(new Footprint(base.Firearm.Owner), CurFiringState, array);
			if (base.IsServer)
			{
				SendRpc((NetworkWriter x) =>
				{
					x.WriteSubheader(MessageType.RpcRequireReloadTrue);
				});
			}
		}

		private void UpdateAction()
		{
			if (!TryGetCurStateTimes(out var times))
			{
				return;
			}
			float num = _firingElapsed + Time.deltaTime;
			float[] array = times;
			foreach (float num2 in array)
			{
				if (!(num2 <= _firingElapsed) && !(num2 > num))
				{
					TriggerFire();
				}
			}
			_firingElapsed = num;
		}

		private bool TryGetCurStateTimes(out float[] times)
		{
			switch (CurFiringState)
			{
			case FiringState.FiringRapid:
				times = _rapidShotTimes;
				return true;
			case FiringState.FiringSingle:
				times = _singleShotTimes;
				return true;
			default:
				times = null;
				return false;
			}
		}

		private void TriggerFire()
		{
			if (base.IsServer)
			{
				_shotTickets.Enqueue(NetworkTime.time);
				ServerUpdateShotRequests();
			}
			if (base.IsLocalPlayer)
			{
				ShotEventManager.Trigger(new DisruptorShotEvent(base.Firearm, CurFiringState));
				SendCmd((NetworkWriter writer) =>
				{
					writer.WriteSubheader(MessageType.CmdConfirmDischarge);
					writer.WriteBacktrackData(new ShotBacktrackData(base.Firearm));
				});
			}
		}

		private void ServerUpdateShotRequests()
		{
			if (!_shotTickets.TryPeek(out var result))
			{
				return;
			}
			if (_receivedShots.TryDequeue(out var dequeued))
			{
				dequeued.ProcessShot(base.Firearm, ServerFire);
			}
			else
			{
				if (NetworkTime.time - result < 0.07000000029802322)
				{
					return;
				}
				ServerFire(null);
			}
			_shotTickets.Dequeue();
		}

		private void ServerProcessStartCmd(bool ads)
		{
			if (IsReloading || CurFiringState != FiringState.None || _magModule.AmmoStored == 0)
			{
				return;
			}
			PlayerShootingWeaponEventArgs e = new PlayerShootingWeaponEventArgs(base.Firearm.Owner, base.Firearm);
			PlayerEvents.OnShootingWeapon(e);
			if (!e.IsAllowed)
			{
				SendRpc((NetworkWriter x) =>
				{
					x.WriteSubheader(MessageType.RpcStopFiring);
				});
				return;
			}
			bool last = _magModule.AmmoStored == 1;
			SendRpc((NetworkWriter x) =>
			{
				x.WriteSubheader(MessageType.RpcStartFiring);
				x.WriteBool(ads);
				x.WriteBool(last);
			});
			_magModule.ServerModifyAmmo(-1);
			PlayerEvents.OnShotWeapon(new PlayerShotWeaponEventArgs(base.Firearm.Owner, base.Firearm));
		}

		private void ServerFire(ReferenceHub primaryTarget)
		{
			if (base.Firearm.TryGetModule<IHitregModule>(out var module))
			{
				module.Fire(primaryTarget, new DisruptorShotEvent(base.Firearm, _lastActiveFiringState));
			}
			SendRpc((ReferenceHub hub) => hub != base.Firearm.Owner, (NetworkWriter x) =>
			{
				x.WriteSubheader(MessageType.RpcOnShot);
				x.WriteByte((byte)_lastActiveFiringState);
			});
		}

		private void ClientUpdate()
		{
			if (!base.Firearm.AnyModuleBusy() && GetAction(ActionName.Shoot) && !base.PrimaryActionBlocked && !IsReloading && CurFiringState == FiringState.None)
			{
				if (!base.IsServer)
				{
					StartFiring(_modeSelector.SingleShotSelected, _magModule.AmmoStored <= 1);
				}
				SendCmd((NetworkWriter x) =>
				{
					x.WriteSubheader(MessageType.CmdRequestStartFiring);
					x.WriteBool(_modeSelector.SingleShotSelected);
				});
			}
		}

		private void StartFiring(bool singleMode, bool last)
		{
			if (singleMode)
			{
				CurFiringState = FiringState.FiringSingle;
				base.Firearm.AnimSetTrigger(last ? FireSingleLastHash : FireSingleNormalHash);
			}
			else
			{
				CurFiringState = FiringState.FiringRapid;
				base.Firearm.AnimSetTrigger(last ? FireRapidLastHash : FireRapidNormalHash);
			}
			_audioModule.PlayDisruptorShot(singleMode, last);
		}
	}
}

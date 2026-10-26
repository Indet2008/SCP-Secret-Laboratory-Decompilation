using System;
using System.Collections.Generic;
using System.Diagnostics;
using InventorySystem.Items.Autosync;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Modules.Misc;
using InventorySystem.Items.Firearms.ShotEvents;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class AutomaticActionModule : ModuleBase, IActionModule, IAmmoContainerModule, IBusyIndicatorModule, IDisplayableAmmoProviderModule, IInspectPreventerModule
	{
		private enum MessageHeader
		{
			CmdShoot = 0,
			RpcPublicSync = 1,
			RpcResponse = 2,
			RpcFire = 3,
			RpcDryFire = 4,
			RpcNewPlayerSync = 5,
			RpcRejectionReason = 6
		}

		[Flags]
		private enum SyncDataFlags : byte
		{
			None = 0,
			AmmoChamberedBit0 = 1,
			AmmoChamberedBit1 = 2,
			AmmoChamberedBit2 = 4,
			AmmoChamberedBit3 = 8,
			Cocked = 0x10,
			BoltLocked = 0x20,
			AmmoChamberedFilter = AmmoChamberedBit0 | AmmoChamberedBit1 | AmmoChamberedBit2 | AmmoChamberedBit3
		}

		private readonly struct ShotRequest
		{
			public readonly int PredictedReserve;

			public readonly byte CorrectionVersion;

			public readonly ShotBacktrackData BacktrackData;

			public ShotRequest(AutomaticActionModule mod)
			{
				PredictedReserve = mod._clientAmmo.Value;
				CorrectionVersion = mod._clientCorrectionVersion;
				BacktrackData = new ShotBacktrackData(mod.Firearm);
			}

			public ShotRequest(NetworkReader reader)
			{
				PredictedReserve = reader.ReadByte();
				CorrectionVersion = reader.ReadByte();
				BacktrackData = new ShotBacktrackData(reader);
			}

			public void Write(NetworkWriter writer)
			{
				writer.WriteSubheader(MessageHeader.CmdShoot);
				writer.WriteByte((byte)PredictedReserve);
				writer.WriteByte(CorrectionVersion);
				writer.WriteBacktrackData(BacktrackData);
			}
		}

		[Serializable]
		private struct GunshotDefinition
		{
			public AudioClip[] RandomSounds;

			[Tooltip("Value provided in ShotClipIdOverride. Zero if no attachments.")]
			public int ClipId;

			[Tooltip("This gunshot sound will only be used if number of chambers fired is greater or equal to this amount.")]
			[Range(1f, 16f)]
			public int MinChamberedRounds;

			[Tooltip("This gunshot sound will only be used if number of chambers fired is less or equal to this amount.")]
			[Range(1f, 16f)]
			public int MaxChamberedRounds;
		}

		private enum RejectionReason
		{
			TimedOut = 1,
			ModuleBusy = 2,
			NotCocked = 3,
			BoltLocked = 4
		}

		private static readonly Dictionary<ushort, SyncDataFlags> ReceivedFlags = new Dictionary<ushort, SyncDataFlags>();

		private const int MaxChambers = 16;

		private readonly Stopwatch _totalTimeStopwatch = Stopwatch.StartNew();

		private readonly FullAutoShotsQueue<ShotRequest> _serverQueuedRequests = new FullAutoShotsQueue<ShotRequest>((ShotRequest x) => x.BacktrackData);

		private readonly Queue<float> _clientQueuedShots = new Queue<float>();

		private readonly FullAutoRateLimiter _clientRateLimiter = new FullAutoRateLimiter();

		private ClientPredictedValue<int> _clientChambered;

		private ClientPredictedValue<int> _clientAmmo;

		private ClientPredictedValue<bool> _clientCocked;

		private ClientPredictedValue<bool> _clientBoltLock;

		private byte _clientCorrectionVersion;

		private int _serverChambered;

		private bool _serverCocked;

		private bool _serverBoltLocked;

		[SerializeField]
		private GunshotDefinition[] _gunshotSounds;

		[SerializeField]
		private AudioClip _dryfireSound;

		[SerializeField]
		private AnimatorConditionalOverride _boltLockOverrideLayers;

		[field: SerializeField]
		public virtual float BaseFireRate { get; private set; }

		[field: SerializeField]
		public float BoltTravelTime { get; private set; }

		[field: SerializeField]
		public bool MagLocksBolt { get; private set; }

		[field: SerializeField]
		public bool OpenBolt { get; private set; }

		[field: SerializeField]
		[field: Range(1f, 16f)]
		public int ChamberSize { get; set; }

		public bool Cocked
		{
			get
			{
				if (!base.IsServer)
				{
					return SyncCocked;
				}
				return _serverCocked;
			}
			set
			{
				_serverCocked = value;
			}
		}

		public bool BoltLocked
		{
			get
			{
				if (!base.IsServer)
				{
					return SyncBoltLocked;
				}
				return _serverBoltLocked;
			}
			set
			{
				_serverBoltLocked = value;
			}
		}

		public int AmmoStored
		{
			get
			{
				if (!base.IsServer)
				{
					return SyncAmmoChambered;
				}
				return _serverChambered;
			}
			set
			{
				_serverChambered = value;
			}
		}

		public bool IsBusy
		{
			get
			{
				if (_serverQueuedRequests.Idle)
				{
					return !_clientRateLimiter.Ready;
				}
				return true;
			}
		}

		public float DisplayCyclicRate => BaseFireRate * base.Firearm.AttachmentsValue(AttachmentParam.FireRateMultiplier);

		public int AmmoMax => AmmoStored;

		public DisplayAmmoValues PredictedDisplayAmmo => new DisplayAmmoValues(_clientAmmo.Value, _clientChambered.Value);

		public bool InspectionAllowed
		{
			get
			{
				if (IsBusy)
				{
					if (_clientChambered.Value == 0)
					{
						return _clientAmmo.Value == 0;
					}
					return false;
				}
				return true;
			}
		}

		public bool IsLoaded
		{
			get
			{
				if (!OpenBolt)
				{
					return AmmoStored > 0;
				}
				return PrimaryAmmoContainer.AmmoStored > 0;
			}
		}

		private float TimeBetweenShots => 1f / DisplayCyclicRate;

		private float CurTime => (float)_totalTimeStopwatch.Elapsed.TotalSeconds;

		private SyncDataFlags CurSyncFlags
		{
			get
			{
				if (!ReceivedFlags.TryGetValue(base.ItemSerial, out var value))
				{
					return SyncDataFlags.None;
				}
				return value;
			}
		}

		private int SyncAmmoChambered => (int)(CurSyncFlags & SyncDataFlags.AmmoChamberedFilter);

		private bool SyncBoltLocked => (CurSyncFlags & SyncDataFlags.BoltLocked) != 0;

		private bool SyncCocked => (CurSyncFlags & SyncDataFlags.Cocked) != 0;

		private bool MagInserted
		{
			get
			{
				if (base.Firearm.TryGetModule<IMagazineControllerModule>(out var module))
				{
					return module.MagazineInserted;
				}
				return true;
			}
		}

		private IPrimaryAmmoContainerModule PrimaryAmmoContainer
		{
			get
			{
				if (!base.Firearm.TryGetModule<IPrimaryAmmoContainerModule>(out var module))
				{
					throw new InvalidOperationException("Automatic weapons must have a designated primary ammo container.");
				}
				return module;
			}
		}

		public static event Action<ushort> OnSyncDataReceived;

		public static void DecodeSyncFlags(ushort serial, out int ammoChambered, out bool boltLocked, out bool cocked)
		{
			if (!ReceivedFlags.TryGetValue(serial, out var value))
			{
				value = SyncDataFlags.None;
			}
			ammoChambered = (int)(value & SyncDataFlags.AmmoChamberedFilter);
			boltLocked = (value & SyncDataFlags.BoltLocked) != 0;
			cocked = (value & SyncDataFlags.Cocked) != 0;
		}

		[ExposedFirearmEvent]
		public void ServerCycleAction()
		{
			if (base.IsServer)
			{
				Cocked = true;
				if (!OpenBolt)
				{
					int num = Mathf.Min(PrimaryAmmoContainer.AmmoStored, ChamberSize - AmmoStored);
					AmmoStored += num;
					PrimaryAmmoContainer.ServerModifyAmmo(-num);
					BoltLocked = AmmoStored == 0 && MagLocksBolt && MagInserted;
				}
				ServerResync();
			}
		}

		[ExposedFirearmEvent]
		public void ServerUnloadChambered()
		{
			if (base.IsServer && base.Firearm.TryGetModule<IPrimaryAmmoContainerModule>(out var module))
			{
				base.Firearm.OwnerInventory.ServerAddAmmo(module.AmmoType, AmmoStored);
				AmmoStored = 0;
				ServerResync();
			}
		}

		public void ServerLockBolt()
		{
			BoltLocked = true;
			ServerResync();
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			byte b = reader.ReadByte();
			if (!base.PrimaryActionBlocked && b == 0)
			{
				_serverQueuedRequests.Enqueue(new ShotRequest(reader));
			}
		}

		public override void ClientProcessRpcInstance(NetworkReader reader)
		{
			base.ClientProcessRpcInstance(reader);
			switch ((MessageHeader)reader.ReadByte())
			{
			case MessageHeader.RpcResponse:
				ClientApplyResponse(reader);
				break;
			case MessageHeader.RpcFire:
				if (base.IsSpectator)
				{
					PlayFireAnims(dryFire: false);
				}
				break;
			case MessageHeader.RpcDryFire:
				if (base.IsSpectator)
				{
					PlayFireAnims(dryFire: true);
				}
				break;
			}
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			switch ((MessageHeader)reader.ReadByte())
			{
			case MessageHeader.RpcNewPlayerSync:
				while (reader.Remaining > 0)
				{
					serial = reader.ReadUShort();
					ReadSyncData();
				}
				break;
			case MessageHeader.RpcPublicSync:
				ReadSyncData();
				break;
			case MessageHeader.RpcFire:
			{
				int num = reader.ReadByte();
				for (int i = 0; i < num; i++)
				{
					ShotEventManager.Trigger(new BulletShotEvent(new ItemIdentifier(base.Firearm.ItemTypeId, serial), i));
				}
				break;
			}
			case MessageHeader.RpcRejectionReason:
			{
				byte b = reader.ReadByte();
				byte b2 = reader.ReadByte();
				UnityEngine.Debug.Log("Shot has been rejected by server. Error code: " + b + "." + b2);
				break;
			}
			case MessageHeader.RpcResponse:
			case MessageHeader.RpcDryFire:
				break;
			}
			void ReadSyncData()
			{
				if (reader.Remaining == 0)
				{
					UnityEngine.Debug.LogError(string.Format("Failed to deserialize {0} of {1} with serial {2}.", "AutomaticActionModule", base.Firearm.ItemTypeId, serial));
				}
				else
				{
					ReceivedFlags[serial] = (SyncDataFlags)reader.ReadByte();
					OnSyncDataReceived?.Invoke(serial);
				}
			}
		}

		public void ServerResync()
		{
			SyncDataFlags syncData = (SyncDataFlags)AmmoStored;
			if (Cocked)
			{
				syncData |= SyncDataFlags.Cocked;
			}
			if (BoltLocked)
			{
				syncData |= SyncDataFlags.BoltLocked;
			}
			SendRpc((NetworkWriter writer) =>
			{
				writer.WriteSubheader(MessageHeader.RpcPublicSync);
				writer.WriteByte((byte)syncData);
			});
		}

		internal override void OnClientReady()
		{
			base.OnClientReady();
			ReceivedFlags.Clear();
		}

		protected override void OnInit()
		{
			base.OnInit();
			_clientChambered = new ClientPredictedValue<int>(() => SyncAmmoChambered);
			_clientCocked = new ClientPredictedValue<bool>(() => SyncCocked);
			_clientBoltLock = new ClientPredictedValue<bool>(() => SyncBoltLocked);
			_clientAmmo = new ClientPredictedValue<int>(() => PrimaryAmmoContainer.AmmoStored);
			if (base.Firearm.TryGetModule<AudioModule>(out var module))
			{
				module.RegisterClip(_dryfireSound);
				GunshotDefinition[] gunshotSounds = _gunshotSounds;
				for (int num = 0; num < gunshotSounds.Length; num++)
				{
					gunshotSounds[num].RandomSounds.ForEach(module.RegisterClip);
				}
			}
		}

		internal override void OnAdded()
		{
			base.OnAdded();
			if (base.IsServer)
			{
				FullAutoShotsQueue<ShotRequest> serverQueuedRequests = _serverQueuedRequests;
				serverQueuedRequests.OnRequestTimedOut = (Action<ShotRequest>)Delegate.Combine(serverQueuedRequests.OnRequestTimedOut, new Action<ShotRequest>(ServerOnRequestTimedOut));
				BoltLocked = SyncBoltLocked;
				Cocked = SyncCocked;
				AmmoStored = SyncAmmoChambered;
				ServerResync();
			}
		}

		internal override void OnHolstered()
		{
			base.OnHolstered();
			if (base.IsServer && !MagInserted)
			{
				BoltLocked = false;
				ServerResync();
			}
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			if (base.IsControllable)
			{
				ProcessInput();
				ProcessClientShots();
			}
			if (base.IsServer)
			{
				UpdateServer();
			}
			base.Firearm.AnimSetBool(FirearmAnimatorHashes.IsCocked, base.IsLocalPlayer ? _clientCocked.Value : Cocked, checkIfExists: true);
			base.Firearm.AnimSetBool(FirearmAnimatorHashes.IsBoltLocked, base.IsLocalPlayer ? _clientBoltLock.Value : BoltLocked, checkIfExists: true);
			base.Firearm.AnimSetInt(FirearmAnimatorHashes.ChamberedAmmo, base.IsLocalPlayer ? _clientChambered.Value : AmmoStored, checkIfExists: true);
			base.Firearm.AnimSetInt(FirearmAnimatorHashes.PredictedActionAmmo, _clientAmmo.Value, checkIfExists: true);
			_boltLockOverrideLayers.Update(base.Firearm, _clientBoltLock.Value || BoltLocked);
		}

		internal override void ServerOnPlayerConnected(ReferenceHub hub, bool firstModule)
		{
			base.ServerOnPlayerConnected(hub, firstModule);
			if (!firstModule)
			{
				return;
			}
			SendRpc(hub, (NetworkWriter writer) =>
			{
				writer.WriteSubheader(MessageHeader.RpcNewPlayerSync);
				foreach (KeyValuePair<ushort, SyncDataFlags> receivedFlag in ReceivedFlags)
				{
					if (receivedFlag.Value != SyncDataFlags.None)
					{
						writer.WriteUShort(receivedFlag.Key);
						writer.WriteByte((byte)receivedFlag.Value);
					}
				}
			});
		}

		protected virtual void OnTriggerHeld()
		{
			if (_clientCocked.Value && _clientRateLimiter.Ready)
			{
				_clientRateLimiter.Trigger(TimeBetweenShots);
				_clientQueuedShots.Enqueue(CurTime + BoltTravelTime);
			}
		}

		private void ProcessInput()
		{
			_clientRateLimiter.Update();
			if (base.Firearm.TryGetModule<ITriggerControllerModule>(out var module) && module.TriggerHeld)
			{
				OnTriggerHeld();
			}
		}

		private void ProcessClientShots()
		{
			if (_clientQueuedShots.Count == 0 || _clientQueuedShots.Peek() > CurTime)
			{
				return;
			}
			_clientQueuedShots.Dequeue();
			if (!_clientCocked.Value || _clientBoltLock.Value)
			{
				return;
			}
			int num = Mathf.Min((OpenBolt ? _clientAmmo : _clientChambered).Value, ChamberSize);
			if (num > 0)
			{
				for (int i = 0; i < num; i++)
				{
					ShotEventManager.Trigger(new BulletShotEvent(new ItemIdentifier(base.Firearm), i));
				}
				if (!NetworkServer.active)
				{
					PlayFire(num);
				}
				int num2 = Mathf.Min(_clientAmmo.Value, ChamberSize);
				_clientChambered.Value = ((!OpenBolt) ? num2 : 0);
				_clientAmmo.Value -= num2;
				_clientCocked.Value = true;
				if (num2 == 0 && MagLocksBolt && MagInserted)
				{
					_clientBoltLock.Value = true;
				}
			}
			else
			{
				PlayDryFire();
				_clientCocked.Value = false;
			}
			ShotRequest shotRequest = new ShotRequest(this);
			SendCmd(((ShotRequest)shotRequest).Write);
		}

		private void UpdateServer()
		{
			_serverQueuedRequests.Update();
			if (!_serverQueuedRequests.TryDequeue(out var dequeued))
			{
				return;
			}
			if (!Cocked)
			{
				ServerSendRejection(RejectionReason.NotCocked, 0);
				return;
			}
			if (BoltLocked)
			{
				ServerSendRejection(RejectionReason.BoltLocked, 0);
				return;
			}
			ModuleBase[] modules = base.Firearm.Modules;
			foreach (ModuleBase moduleBase in modules)
			{
				if (moduleBase is IBusyIndicatorModule { IsBusy: not false } && !(moduleBase == this))
				{
					ServerSendRejection(RejectionReason.ModuleBusy, moduleBase.SyncId);
					return;
				}
			}
			if (AmmoStored > 0 || (OpenBolt && PrimaryAmmoContainer.AmmoStored > 0))
			{
				PlayerShootingWeaponEventArgs e = new PlayerShootingWeaponEventArgs(base.Firearm.Owner, base.Firearm);
				PlayerEvents.OnShootingWeapon(e);
				if (!e.IsAllowed)
				{
					return;
				}
				dequeued.BacktrackData.ProcessShot(base.Firearm, ServerShoot);
				PlayerEvents.OnShotWeapon(new PlayerShotWeaponEventArgs(base.Firearm.Owner, base.Firearm));
			}
			else
			{
				PlayerDryFiringWeaponEventArgs e2 = new PlayerDryFiringWeaponEventArgs(base.Firearm.Owner, base.Firearm);
				PlayerEvents.OnDryFiringWeapon(e2);
				if (!e2.IsAllowed)
				{
					return;
				}
				Cocked = false;
				PlayDryFire();
				ServerResync();
				SendRpc((NetworkWriter x) =>
				{
					x.WriteSubheader(MessageHeader.RpcDryFire);
				});
				PlayerEvents.OnDryFiredWeapon(new PlayerDryFiredWeaponEventArgs(base.Firearm.Owner, base.Firearm));
			}
			ServerSendResponse(dequeued);
		}

		private void ClientApplyResponse(NetworkReader reader)
		{
			byte b = reader.ReadByte();
			bool flag = reader.ReadBool();
			int num = reader.ReadShort();
			_clientCocked.Value &= flag;
			if (num != 0 && b == _clientCorrectionVersion)
			{
				_clientCorrectionVersion++;
				_clientAmmo.Value -= num;
			}
		}

		private void ServerOnRequestTimedOut(ShotRequest request)
		{
			ServerSendResponse(request);
			ServerSendRejection(RejectionReason.TimedOut, 0);
		}

		private void ServerSendResponse(ShotRequest request)
		{
			SendRpc((NetworkWriter writer) =>
			{
				writer.WriteSubheader(MessageHeader.RpcResponse);
				int num = request.PredictedReserve - PrimaryAmmoContainer.AmmoStored;
				writer.WriteByte(request.CorrectionVersion);
				writer.WriteBool(Cocked);
				writer.WriteShort((short)num);
			}, toAll: false);
		}

		private void ServerSendRejection(RejectionReason reason, byte errorCode = 0)
		{
			SendRpc((NetworkWriter writer) =>
			{
				writer.WriteSubheader(MessageHeader.RpcRejectionReason);
				writer.WriteSubheader(reason);
				writer.WriteByte(errorCode);
			}, toAll: false);
		}

		private void ServerShoot(ReferenceHub primaryTarget)
		{
			int ammoToFire;
			if (OpenBolt)
			{
				ammoToFire = Mathf.Min(PrimaryAmmoContainer.AmmoStored, ChamberSize);
				PrimaryAmmoContainer.ServerModifyAmmo(-ammoToFire);
			}
			else
			{
				ammoToFire = AmmoStored;
				AmmoStored = 0;
			}
			_serverQueuedRequests.Trigger(TimeBetweenShots);
			SendRpc((ReferenceHub ply) => ply != base.Firearm.Owner, (NetworkWriter writer) =>
			{
				writer.WriteSubheader(MessageHeader.RpcFire);
				writer.WriteByte((byte)ammoToFire);
			});
			PlayFire(ammoToFire);
			ServerCycleAction();
			if (base.Firearm.TryGetModule<IHitregModule>(out var module))
			{
				for (int num = 0; num < ammoToFire; num++)
				{
					module.Fire(primaryTarget, new BulletShotEvent(new ItemIdentifier(base.Firearm), num));
				}
			}
		}

		private void PlayDryFire()
		{
			PlayFireAnims(dryFire: true);
			if (base.Firearm.TryGetModule<AudioModule>(out var module))
			{
				module.PlayNormal(_dryfireSound);
			}
		}

		private void PlayFire(int chambersFired)
		{
			PlayFireAnims(dryFire: false);
			if (!base.Firearm.TryGetModule<AudioModule>(out var module))
			{
				return;
			}
			int num = (int)base.Firearm.AttachmentsValue(AttachmentParam.ShotClipIdOverride);
			GunshotDefinition[] gunshotSounds = _gunshotSounds;
			for (int i = 0; i < gunshotSounds.Length; i++)
			{
				GunshotDefinition gunshotDefinition = gunshotSounds[i];
				if (gunshotDefinition.ClipId == num && gunshotDefinition.MinChamberedRounds <= chambersFired && gunshotDefinition.MaxChamberedRounds >= chambersFired)
				{
					module.PlayGunshot(gunshotDefinition.RandomSounds.RandomItem());
					break;
				}
			}
		}

		private void PlayFireAnims(bool dryFire)
		{
			base.Firearm.AnimSetFloat(FirearmAnimatorHashes.Random, UnityEngine.Random.value, checkIfExists: true);
			if (dryFire)
			{
				base.Firearm.AnimSetTrigger(FirearmAnimatorHashes.DryFire, checkIfExists: true);
				return;
			}
			base.Firearm.AnimSetTrigger(FirearmAnimatorHashes.Fire);
			base.Firearm.AnimSetTrigger(FirearmAnimatorHashes.ReleaseHammer, checkIfExists: true);
		}

		public int GetAmmoStoredForSerial(ushort serial)
		{
			if (!ReceivedFlags.TryGetValue(serial, out var value))
			{
				return 0;
			}
			return (int)(value & SyncDataFlags.AmmoChamberedFilter);
		}

		public DisplayAmmoValues GetDisplayAmmoForSerial(ushort serial)
		{
			return new DisplayAmmoValues(0, GetAmmoStoredForSerial(serial));
		}
	}
}

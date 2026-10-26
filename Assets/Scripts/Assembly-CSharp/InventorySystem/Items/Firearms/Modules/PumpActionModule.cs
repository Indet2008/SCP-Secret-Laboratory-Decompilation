using System;
using System.Collections.Generic;
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
	public class PumpActionModule : ModuleBase, IActionModule, IAmmoContainerModule, IBusyIndicatorModule, ITriggerPressPreventerModule, IReloadUnloadValidatorModule, IDisplayableAmmoProviderModule, IInspectPreventerModule
	{
		private enum RpcType
		{
			ResyncOne = 0,
			ResyncAll = 1,
			Shoot = 2,
			SchedulePump = 3
		}

		private static readonly Dictionary<ushort, byte> ChamberedBySerial = new Dictionary<ushort, byte>();

		private static readonly Dictionary<ushort, byte> CockedBySerial = new Dictionary<ushort, byte>();

		private static readonly int PumpTriggerHash = Animator.StringToHash("Pump");

		private readonly FullAutoShotsQueue<ShotBacktrackData> _serverQueuedShots = new FullAutoShotsQueue<ShotBacktrackData>((ShotBacktrackData x) => x);

		private readonly FullAutoRateLimiter _clientRateLimiter = new FullAutoRateLimiter();

		private readonly FullAutoRateLimiter _pumpingDelayTimer = new FullAutoRateLimiter();

		private readonly FullAutoRateLimiter _pumpingRemaining = new FullAutoRateLimiter();

		private ClientPredictedValue<int> _clientChambered;

		private ClientPredictedValue<int> _clientCocked;

		private ClientPredictedValue<int> _clientMagazine;

		private bool _pumpingScheduled;

		[SerializeField]
		private int _numberOfBarrels;

		[SerializeField]
		private int _baseShotsPerTriggerPull;

		[SerializeField]
		private float _basePumpingDuration;

		[SerializeField]
		private float _baseCooldownAfterShot;

		[SerializeField]
		private AudioClip _dryFireClip;

		[SerializeField]
		private AudioClip[] _shotClipPerBarrelIndex;

		private float PumpingDuration => _basePumpingDuration / base.Firearm.AttachmentsValue(AttachmentParam.FireRateMultiplier);

		private bool PumpIdle
		{
			get
			{
				if (_pumpingRemaining.Ready)
				{
					return !_pumpingScheduled;
				}
				return false;
			}
		}

		private float CooldownAfterShot => _baseCooldownAfterShot / base.Firearm.AttachmentsValue(AttachmentParam.FireRateMultiplier);

		private int ShotsPerTriggerPull => Mathf.RoundToInt((float)_baseShotsPerTriggerPull * base.Firearm.AttachmentsValue(AttachmentParam.AmmoConsumptionMultiplier));

		private int MagazineAmmo
		{
			get
			{
				if (!base.Firearm.TryGetModule<IPrimaryAmmoContainerModule>(out var module))
				{
					return 0;
				}
				return module.AmmoStored;
			}
		}

		private int SyncChambered
		{
			get
			{
				return GetSyncValue(ChamberedBySerial);
			}
			set
			{
				SetSyncValue(ChamberedBySerial, value);
			}
		}

		public int SyncCocked
		{
			get
			{
				return GetSyncValue(CockedBySerial);
			}
			set
			{
				SetSyncValue(CockedBySerial, value);
			}
		}

		public int AmmoStored
		{
			get
			{
				return SyncChambered;
			}
			set
			{
				SyncChambered = value;
			}
		}

		public int Barrels
		{
			get
			{
				return _numberOfBarrels;
			}
			set
			{
				_numberOfBarrels = value;
			}
		}

		public float DisplayCyclicRate
		{
			get
			{
				int shotsPerTriggerPull = ShotsPerTriggerPull;
				float cooldownAfterShot = CooldownAfterShot;
				float num = (float)(_numberOfBarrels / shotsPerTriggerPull - 1) * cooldownAfterShot;
				float num2 = (float)shotsPerTriggerPull * cooldownAfterShot;
				float num3 = PumpingDuration + num2 + num;
				return (float)_numberOfBarrels / num3;
			}
		}

		public int AmmoMax => AmmoStored;

		public bool IsBusy
		{
			get
			{
				if (_clientRateLimiter.Ready && _serverQueuedShots.Idle)
				{
					return !PumpIdle;
				}
				return true;
			}
		}

		public bool ClientBlockTrigger
		{
			get
			{
				if (!PumpIdle)
				{
					return _clientRateLimiter.Ready;
				}
				return false;
			}
		}

		public IReloadUnloadValidatorModule.Authorization ReloadAuthorization => IReloadUnloadValidatorModule.Authorization.Idle;

		public IReloadUnloadValidatorModule.Authorization UnloadAuthorization
		{
			get
			{
				if (AmmoStored <= 0)
				{
					return IReloadUnloadValidatorModule.Authorization.Idle;
				}
				return IReloadUnloadValidatorModule.Authorization.Allowed;
			}
		}

		public DisplayAmmoValues PredictedDisplayAmmo => new DisplayAmmoValues(_clientMagazine.Value, _clientChambered.Value);

		public bool InspectionAllowed
		{
			get
			{
				if (IsBusy)
				{
					if (_clientChambered.Value == 0)
					{
						return _clientMagazine.Value == 0;
					}
					return false;
				}
				return true;
			}
		}

		public bool IsLoaded => AmmoStored > 0;

		internal override void OnEquipped()
		{
			base.OnEquipped();
			if (base.IsServer)
			{
				ServerResync();
			}
		}

		internal override void OnHolstered()
		{
			base.OnHolstered();
			_pumpingScheduled = false;
			_pumpingRemaining.Clear();
		}

		protected override void OnInit()
		{
			base.OnInit();
			_clientChambered = new ClientPredictedValue<int>(() => SyncChambered);
			_clientCocked = new ClientPredictedValue<int>(() => SyncCocked);
			_clientMagazine = new ClientPredictedValue<int>(() => MagazineAmmo);
			if (base.Firearm.TryGetModule<AudioModule>(out var module))
			{
				_shotClipPerBarrelIndex.ForEach(module.RegisterClip);
				module.RegisterClip(_dryFireClip);
			}
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			if (base.IsLocalPlayer)
			{
				UpdateClient();
			}
			if (base.IsServer)
			{
				UpdateServer();
			}
			int i = (base.IsLocalPlayer ? _clientChambered.Value : SyncChambered);
			int i2 = (base.IsLocalPlayer ? _clientCocked.Value : SyncCocked);
			base.Firearm.AnimSetInt(FirearmAnimatorHashes.ChamberedAmmo, i);
			base.Firearm.AnimSetInt(FirearmAnimatorHashes.CockedHammers, i2);
			_pumpingDelayTimer.Update();
			_pumpingRemaining.Update();
			if (_pumpingScheduled && _pumpingDelayTimer.Ready)
			{
				base.Firearm.AnimSetTrigger(PumpTriggerHash);
				_pumpingScheduled = false;
				_pumpingRemaining.Trigger(PumpingDuration);
			}
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
				writer.WriteSubheader(RpcType.ResyncAll);
				foreach (KeyValuePair<ushort, byte> item in CockedBySerial)
				{
					writer.WriteUShort(item.Key);
					writer.WriteByte((byte)GetChamberedCount(item.Key));
					writer.WriteByte(item.Value);
				}
			});
		}

		internal override void OnClientReady()
		{
			base.OnClientReady();
			ChamberedBySerial.Clear();
			CockedBySerial.Clear();
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (!base.PrimaryActionBlocked)
			{
				_serverQueuedShots.Enqueue(reader.ReadBacktrackData());
			}
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			switch ((RpcType)reader.ReadByte())
			{
			case RpcType.ResyncOne:
				ChamberedBySerial[serial] = reader.ReadByte();
				CockedBySerial[serial] = reader.ReadByte();
				break;
			case RpcType.ResyncAll:
				while (reader.Remaining > 0)
				{
					serial = reader.ReadUShort();
					ChamberedBySerial[serial] = reader.ReadByte();
					CockedBySerial[serial] = reader.ReadByte();
				}
				break;
			case RpcType.Shoot:
			{
				ItemIdentifier shotFirearm = new ItemIdentifier(base.Firearm.ItemTypeId, serial);
				while (reader.Remaining > 0)
				{
					int barrelId = reader.ReadByte();
					ShotEventManager.Trigger(new BulletShotEvent(shotFirearm, barrelId));
				}
				break;
			}
			}
		}

		public override void ClientProcessRpcInstance(NetworkReader reader)
		{
			base.ClientProcessRpcInstance(reader);
			switch ((RpcType)reader.ReadByte())
			{
			case RpcType.SchedulePump:
				if (!NetworkServer.active)
				{
					SchedulePumping(reader.ReadByte());
				}
				break;
			case RpcType.Shoot:
				if (base.Firearm.IsSpectator)
				{
					base.Firearm.AnimSetTrigger(FirearmAnimatorHashes.Fire);
				}
				break;
			}
		}

		public void Pump()
		{
			if (base.IsSpectator)
			{
				return;
			}
			IPrimaryAmmoContainerModule module2;
			if (!NetworkServer.active)
			{
				if (!base.Firearm.TryGetModule<IReloaderModule>(out var module) || !module.IsReloadingOrUnloading)
				{
					_clientCocked.Value = _numberOfBarrels;
					_clientChambered.Value = Mathf.Min(_clientMagazine.Value, _numberOfBarrels);
					_clientMagazine.Value -= _clientChambered.Value;
				}
			}
			else if (base.Firearm.TryGetModule<IPrimaryAmmoContainerModule>(out module2))
			{
				if (AmmoStored > 0)
				{
					base.Firearm.OwnerInventory.ServerAddAmmo(module2.AmmoType, AmmoStored);
				}
				SyncCocked = _numberOfBarrels;
				SyncChambered = Mathf.Min(module2.AmmoStored, _numberOfBarrels);
				ServerResync();
				module2.ServerModifyAmmo(-SyncChambered);
			}
		}

		public DisplayAmmoValues GetDisplayAmmoForSerial(ushort serial)
		{
			return new DisplayAmmoValues(0, GetAmmoStoredForSerial(serial));
		}

		public int GetAmmoStoredForSerial(ushort serial)
		{
			return GetSyncValue(serial, ChamberedBySerial);
		}

		public void SchedulePumping(int shotsFired)
		{
			_pumpingScheduled = true;
			_pumpingDelayTimer.Trigger((float)shotsFired * CooldownAfterShot);
			if (base.IsServer)
			{
				SendRpc((NetworkWriter writer) =>
				{
					writer.WriteSubheader(RpcType.SchedulePump);
					writer.WriteByte((byte)shotsFired);
				});
			}
		}

		private void UpdateClient()
		{
			_clientRateLimiter.Update();
			if (_clientRateLimiter.Ready && PumpIdle && base.Firearm.TryGetModule<ITriggerControllerModule>(out var module) && module.TriggerHeld && _clientCocked.Value != 0)
			{
				ShotBacktrackData backtrackData = new ShotBacktrackData(base.Firearm);
				PullTrigger(clientside: true, out var _);
				SendCmd((NetworkWriter writer) =>
				{
					writer.WriteBacktrackData(backtrackData);
				});
				_clientRateLimiter.Trigger(CooldownAfterShot);
			}
		}

		private void PullTrigger(bool clientside, out int shotsFired)
		{
			int num = (clientside ? _clientCocked.Value : SyncCocked);
			int num2 = Mathf.Min(ShotsPerTriggerPull, num);
			shotsFired = 0;
			for (int i = 0; i < num2; i++)
			{
				if (ShootOneBarrel(clientside))
				{
					shotsFired++;
				}
			}
			if ((!clientside || !NetworkServer.active) && num - num2 <= 0 && base.Firearm.TryGetModule<IPrimaryAmmoContainerModule>(out var module) && module.AmmoStored != 0)
			{
				SchedulePumping(shotsFired);
			}
		}

		private bool ShootOneBarrel(bool clientside)
		{
			if (clientside)
			{
				_clientCocked.Value--;
			}
			else
			{
				SyncCocked--;
			}
			int num = (clientside ? _clientChambered.Value : SyncChambered);
			bool result;
			if (num == 0)
			{
				PlaySound((AudioModule x) =>
				{
					x.PlayNormal(_dryFireClip);
				}, clientside);
				result = false;
			}
			else
			{
				num--;
				int clipId = num % _shotClipPerBarrelIndex.Length;
				PlaySound((AudioModule x) =>
				{
					x.PlayGunshot(_shotClipPerBarrelIndex[clipId]);
				}, clientside);
				if (clientside)
				{
					base.Firearm.AnimSetTrigger(FirearmAnimatorHashes.Fire);
					ShotEventManager.Trigger(new BulletShotEvent(new ItemIdentifier(base.Firearm), num));
				}
				result = true;
			}
			if (clientside)
			{
				_clientChambered.Value = num;
			}
			else
			{
				SyncChambered = num;
			}
			return result;
		}

		private void PlaySound(Action<AudioModule> method, bool clientside)
		{
			if ((!clientside || !NetworkServer.active) && base.Firearm.TryGetModule<AudioModule>(out var module))
			{
				method(module);
			}
		}

		private void UpdateServer()
		{
			_serverQueuedShots.Update();
			if (!base.Firearm.AnyModuleBusy(this) && PumpIdle && _serverQueuedShots.TryDequeue(out var dequeued))
			{
				PlayerShootingWeaponEventArgs e = new PlayerShootingWeaponEventArgs(base.Firearm.Owner, base.Firearm);
				PlayerEvents.OnShootingWeapon(e);
				if (e.IsAllowed)
				{
					dequeued.ProcessShot(base.Firearm, ServerProcessShot);
					PlayerEvents.OnShotWeapon(new PlayerShotWeaponEventArgs(base.Firearm.Owner, base.Firearm));
				}
			}
		}

		private void ServerProcessShot(ReferenceHub primaryTarget)
		{
			PullTrigger(clientside: false, out var shotsFired);
			ServerResync();
			if (shotsFired == 0)
			{
				return;
			}
			_serverQueuedShots.Trigger(CooldownAfterShot);
			int chambered = SyncChambered;
			SendRpc((ReferenceHub ply) => ply != base.Firearm.Owner, WriteShots);
			if (base.Firearm.TryGetModule<IHitregModule>(out var module))
			{
				ItemIdentifier shotFirearm = new ItemIdentifier(base.Firearm);
				for (int num = 0; num < shotsFired; num++)
				{
					int barrelId = chambered + num - 1;
					module.Fire(primaryTarget, new BulletShotEvent(shotFirearm, barrelId));
				}
			}
			void WriteShots(NetworkWriter writer)
			{
				writer.WriteSubheader(RpcType.Shoot);
				for (int num2 = shotsFired; num2 > 0; num2--)
				{
					int num3 = chambered + num2 - 1;
					writer.WriteByte((byte)num3);
				}
			}
		}

		private void ServerResync()
		{
			SendRpc((NetworkWriter writer) =>
			{
				writer.WriteSubheader(RpcType.ResyncOne);
				writer.WriteByte((byte)SyncChambered);
				writer.WriteByte((byte)SyncCocked);
			});
		}

		private void SetSyncValue(Dictionary<ushort, byte> syncDictionary, int value)
		{
			syncDictionary[base.ItemSerial] = (byte)Mathf.Clamp(value, 0, 255);
		}

		private int GetSyncValue(Dictionary<ushort, byte> syncDictionary)
		{
			return GetSyncValue(base.ItemSerial, syncDictionary);
		}

		private static int GetSyncValue(ushort serial, Dictionary<ushort, byte> syncDictionary)
		{
			if (!syncDictionary.TryGetValue(serial, out var value))
			{
				return 0;
			}
			return value;
		}

		public static int GetChamberedCount(ushort serial)
		{
			return GetSyncValue(serial, ChamberedBySerial);
		}

		public static int GetCockedCount(ushort serial)
		{
			return GetSyncValue(serial, CockedBySerial);
		}
	}
}

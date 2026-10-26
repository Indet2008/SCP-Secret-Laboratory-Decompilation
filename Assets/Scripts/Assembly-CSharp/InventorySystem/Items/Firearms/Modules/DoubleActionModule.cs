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
using Utils;
using Utils.NonAllocLINQ;

namespace InventorySystem.Items.Firearms.Modules
{
	public class DoubleActionModule : ModuleBase, IActionModule, IBusyIndicatorModule, IInspectPreventerModule
	{
		private enum MessageType : byte
		{
			RpcNewPlayerResync = 0,
			RpcSetCockedTrue = 1,
			RpcSetCockedFalse = 2,
			RpcFire = 3,
			RpcDryFire = 4,
			CmdUpdatePulling = 5,
			CmdShoot = 6,
			StartPulling = 7,
			StartCocking = 8
		}

		private class TriggerPull
		{
			private double _pullStartTime;

			private double _pullEndTime;

			private double InverseLerpTime => MoreMath.InverseLerp(_pullStartTime, _pullEndTime, NetworkTime.time);

			public float PullProgress
			{
				get
				{
					if (!IsPulling)
					{
						return 0f;
					}
					return (float)InverseLerpTime;
				}
			}

			public bool IsPulling { get; private set; }

			public void Pull(float durationSeconds)
			{
				IsPulling = true;
				_pullStartTime = NetworkTime.time;
				_pullEndTime = NetworkTime.time + (double)durationSeconds;
			}

			public void Reset()
			{
				IsPulling = false;
			}
		}

		private static readonly HashSet<ushort> CockedHashes = new HashSet<ushort>();

		private const float CockingKeyMaxHoldTime = 0.5f;

		[SerializeField]
		private float _baseDoubleActionTime;

		[SerializeField]
		private float _basePostShotCooldown;

		[SerializeField]
		private AudioClip[] _fireClips;

		[SerializeField]
		private AudioClip _dryFireClip;

		[SerializeField]
		private AudioClip _doubleActionClip;

		[SerializeField]
		private AudioClip _cockingClip;

		[SerializeField]
		private AudioClip _decockingClip;

		private float _cockingKeyHoldTime;

		private int? _afterDecockTrigger;

		private bool _cockingBusy;

		private bool _serverPullTokenUsed;

		private ClientPredictedValue<bool> _clientCocked;

		private AudioModule _audioModule;

		private CylinderAmmoModule _cylinderModule;

		private IHitregModule _hitregModule;

		private readonly TriggerPull _triggerPull = new TriggerPull();

		private readonly ClientRequestTimer _cockRequestTimer = new ClientRequestTimer();

		private readonly FullAutoRateLimiter _clientShotCooldown = new FullAutoRateLimiter();

		private readonly FullAutoRateLimiter _serverShotCooldown = new FullAutoRateLimiter();

		public bool IsBusy
		{
			get
			{
				if (!OnCooldown && !IsCocking)
				{
					return _triggerPull.IsPulling;
				}
				return true;
			}
		}

		public bool InspectionAllowed
		{
			get
			{
				if (_cylinderModule.AmmoStored != 0)
				{
					return !IsBusy;
				}
				return !IsCocking;
			}
		}

		public bool Cocked
		{
			get
			{
				if (!base.IsServer)
				{
					return _clientCocked.Value;
				}
				return GetCocked(base.ItemSerial);
			}
			set
			{
				if (!base.IsServer)
				{
					_clientCocked.Value = value;
				}
				else if (value)
				{
					CockedHashes.Add(base.ItemSerial);
					SendRpc(MessageType.RpcSetCockedTrue);
				}
				else
				{
					CockedHashes.Remove(base.ItemSerial);
					SendRpc(MessageType.RpcSetCockedFalse);
				}
			}
		}

		public float TriggerPullProgress => _triggerPull.PullProgress;

		public float DisplayCyclicRate => 1f / (DoubleActionTime + TimeBetweenShots);

		public bool IsLoaded => _cylinderModule.AmmoStored > 0;

		private float DoubleActionTime => _baseDoubleActionTime / base.Firearm.AttachmentsValue(AttachmentParam.DoubleActionSpeedMultiplier);

		private float TimeBetweenShots => _basePostShotCooldown / base.Firearm.AttachmentsValue(AttachmentParam.FireRateMultiplier);

		private bool OnCooldown
		{
			get
			{
				if (_clientShotCooldown.Ready)
				{
					return !_serverShotCooldown.Ready;
				}
				return true;
			}
		}

		private bool IsCocking
		{
			get
			{
				if (!_cockingBusy)
				{
					return _cockRequestTimer.Busy;
				}
				return true;
			}
		}

		public static event Action<ushort, bool> OnCockedChanged;

		public static bool GetCocked(ushort serial)
		{
			return CockedHashes.Contains(serial);
		}

		public void TriggerDecocking(int? nextTriggerHash = null)
		{
			_audioModule.PlayQuiet(_decockingClip);
			_cockingBusy = true;
			_afterDecockTrigger = nextTriggerHash;
			base.Firearm.AnimSetTrigger(FirearmAnimatorHashes.DeCock);
		}

		public void TriggerCocking()
		{
			_audioModule.PlayNormal(_cockingClip);
			_cockingBusy = true;
			base.Firearm.AnimSetTrigger(FirearmAnimatorHashes.Cock);
			if (base.IsLocalPlayer)
			{
				_cylinderModule.ClientHoldPrediction();
			}
		}

		[ExposedFirearmEvent]
		public void SetCocked(bool value)
		{
			Cocked = value;
		}

		[ExposedFirearmEvent]
		public void OnDecockingAnimComplete()
		{
			_cockingBusy = false;
			if (_afterDecockTrigger.HasValue)
			{
				base.Firearm.AnimSetTrigger(_afterDecockTrigger.Value);
				_afterDecockTrigger = null;
			}
		}

		[ExposedFirearmEvent]
		public void OnCockingAnimComplete()
		{
			_cockingBusy = false;
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			switch (DecodeHeader(reader))
			{
			case MessageType.RpcNewPlayerResync:
				foreach (ushort cockedHash in CockedHashes)
				{
					OnCockedChanged?.Invoke(cockedHash, arg2: false);
				}
				CockedHashes.Clear();
				CockedHashes.EnsureCapacity(reader.Remaining / 2);
				while (reader.Remaining > 0)
				{
					ushort num = reader.ReadUShort();
					CockedHashes.Add(num);
					OnCockedChanged?.Invoke(num, arg2: true);
				}
				break;
			case MessageType.RpcSetCockedTrue:
				CockedHashes.Add(serial);
				OnCockedChanged?.Invoke(serial, arg2: true);
				break;
			case MessageType.RpcSetCockedFalse:
				CockedHashes.Remove(serial);
				OnCockedChanged?.Invoke(serial, arg2: false);
				break;
			case MessageType.RpcFire:
				ShotEventManager.Trigger(new BulletShotEvent(new ItemIdentifier(base.Firearm.ItemTypeId, serial)));
				break;
			}
		}

		public override void ClientProcessRpcInstance(NetworkReader reader)
		{
			base.ClientProcessRpcInstance(reader);
			switch (DecodeHeader(reader))
			{
			case MessageType.StartCocking:
				TriggerCocking();
				break;
			case MessageType.StartPulling:
				if (base.IsSpectator)
				{
					_triggerPull.Pull(DoubleActionTime);
				}
				break;
			case MessageType.RpcFire:
				if (base.IsSpectator)
				{
					PlayFireAnims(FirearmAnimatorHashes.Fire);
					_triggerPull.Reset();
				}
				break;
			case MessageType.RpcDryFire:
				if (base.IsSpectator)
				{
					PlayFireAnims(FirearmAnimatorHashes.DryFire);
					_triggerPull.Reset();
				}
				break;
			case MessageType.CmdUpdatePulling:
			case MessageType.CmdShoot:
				break;
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (base.PrimaryActionBlocked)
			{
				return;
			}
			switch (DecodeHeader(reader))
			{
			case MessageType.StartCocking:
				if (!base.Firearm.AnyModuleBusy(this) && !Cocked && !_cockingBusy)
				{
					SendRpc(MessageType.StartCocking);
				}
				break;
			case MessageType.StartPulling:
				if (!_serverPullTokenUsed)
				{
					_serverPullTokenUsed = true;
					_audioModule.PlayQuiet(_doubleActionClip);
					double targetTime = NetworkTime.time + (double)DoubleActionTime;
					SendRpc(MessageType.StartPulling, (NetworkWriter x) =>
					{
						x.WriteDouble(targetTime);
					});
				}
				break;
			case MessageType.CmdShoot:
				Fire(reader);
				_cylinderModule.ServerResync();
				break;
			}
		}

		protected override void OnInit()
		{
			base.OnInit();
			_clientCocked = new ClientPredictedValue<bool>(() => GetCocked(base.ItemSerial));
			if (!base.Firearm.TryGetModules<AudioModule, CylinderAmmoModule, IHitregModule>(out _audioModule, out _cylinderModule, out _hitregModule))
			{
				throw new InvalidOperationException("The " + base.Firearm.name + " is missing one or more essential modules (required by " + base.name + ").");
			}
			_audioModule.RegisterClip(_dryFireClip);
			_audioModule.RegisterClip(_doubleActionClip);
			_audioModule.RegisterClip(_cockingClip);
			_audioModule.RegisterClip(_decockingClip);
			AudioClip[] fireClips = _fireClips;
			foreach (AudioClip clip in fireClips)
			{
				_audioModule.RegisterClip(clip);
			}
		}

		internal override void OnClientReady()
		{
			base.OnClientReady();
			CockedHashes.Clear();
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
				writer.WriteSubheader(MessageType.RpcNewPlayerResync);
				CockedHashes.ForEach((ushort x) =>
				{
					writer.WriteUShort(x);
				});
			});
		}

		internal override void OnHolstered()
		{
			base.OnHolstered();
			_cockingBusy = false;
			_cockingKeyHoldTime = 0f;
			_serverPullTokenUsed = false;
			_triggerPull.Reset();
		}

		internal override void OnEquipped()
		{
			base.OnEquipped();
			if (base.IsServer)
			{
				if (Cocked)
				{
					SendRpc(MessageType.RpcSetCockedTrue);
				}
				else
				{
					SendRpc(MessageType.RpcSetCockedFalse);
				}
			}
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			_clientShotCooldown.Update();
			_serverShotCooldown.Update();
			if (base.IsControllable)
			{
				UpdateInputs();
				if (_triggerPull.IsPulling && (TriggerPullProgress >= 1f || Cocked))
				{
					Fire(null);
				}
			}
			base.Firearm.AnimSetBool(FirearmAnimatorHashes.IsCocked, Cocked);
			base.Firearm.AnimSetFloat(FirearmAnimatorHashes.TriggerState, TriggerPullProgress);
		}

		private void UpdateInputs()
		{
			if (base.Firearm.AnyModuleBusy() || base.PrimaryActionBlocked)
			{
				return;
			}
			if (GetAction(ActionName.WeaponAlt))
			{
				_cockingKeyHoldTime += Time.deltaTime;
			}
			else if (_cockingKeyHoldTime > 0f)
			{
				if (_cockingKeyHoldTime < 0.5f)
				{
					_cockRequestTimer.Trigger();
					SendCmd(MessageType.StartCocking);
				}
				_cockingKeyHoldTime = 0f;
			}
			if (base.Firearm.TryGetModule<ITriggerControllerModule>(out var module) && module.TriggerHeld)
			{
				_triggerPull.Pull(DoubleActionTime);
				if (!Cocked)
				{
					SendCmd(MessageType.StartPulling);
					_audioModule.PlayClientside(_doubleActionClip);
				}
			}
		}

		private void Fire(NetworkReader extraData)
		{
			if (base.IsLocalPlayer)
			{
				_triggerPull.Reset();
				_clientShotCooldown.Trigger(TimeBetweenShots);
			}
			else
			{
				if (!_serverShotCooldown.Ready)
				{
					return;
				}
				_serverPullTokenUsed = false;
				_serverShotCooldown.Trigger(TimeBetweenShots);
			}
			if (!Cocked)
			{
				_cylinderModule.RotateCylinder(1);
			}
			else
			{
				Cocked = false;
			}
			CylinderAmmoModule.Chamber chamber = _cylinderModule.Chambers[0];
			if (chamber.ContextState == CylinderAmmoModule.ChamberState.Live)
			{
				FireLive(chamber, extraData);
			}
			else
			{
				FireDry();
			}
			if (base.IsLocalPlayer && !base.IsServer)
			{
				SendCmd(MessageType.CmdShoot, (NetworkWriter x) =>
				{
					x.WriteBacktrackData(new ShotBacktrackData(base.Firearm));
				});
			}
		}

		private void FireLive(CylinderAmmoModule.Chamber chamber, NetworkReader extraData)
		{
			BulletShotEvent shotEvent = new BulletShotEvent(new ItemIdentifier(base.Firearm));
			if (base.IsServer)
			{
				PlayerShootingWeaponEventArgs e = new PlayerShootingWeaponEventArgs(base.Firearm.Owner, base.Firearm);
				PlayerEvents.OnShootingWeapon(e);
				if (!e.IsAllowed)
				{
					return;
				}
				(base.IsLocalPlayer ? new ShotBacktrackData(base.Firearm) : new ShotBacktrackData(extraData)).ProcessShot(base.Firearm, (ReferenceHub target) =>
				{
					_hitregModule.Fire(target, shotEvent);
				});
				SendRpc((ReferenceHub hub) => hub != base.Firearm.Owner && !hub.isLocalPlayer, (NetworkWriter x) =>
				{
					x.WriteSubheader(MessageType.RpcFire);
				});
				PlayerEvents.OnShotWeapon(new PlayerShotWeaponEventArgs(base.Firearm.Owner, base.Firearm));
			}
			float num = base.Firearm.AttachmentsValue(AttachmentParam.ShotClipIdOverride);
			_audioModule.PlayGunshot(_fireClips[(int)num]);
			chamber.ContextState = CylinderAmmoModule.ChamberState.Discharged;
			ShotEventManager.Trigger(shotEvent);
			PlayFireAnims(FirearmAnimatorHashes.Fire);
		}

		private void FireDry()
		{
			if (base.IsServer)
			{
				PlayerDryFiringWeaponEventArgs e = new PlayerDryFiringWeaponEventArgs(base.Firearm.Owner, base.Firearm);
				PlayerEvents.OnDryFiringWeapon(e);
				if (!e.IsAllowed)
				{
					return;
				}
				SendRpc(MessageType.RpcDryFire);
				PlayerEvents.OnDryFiredWeapon(new PlayerDryFiredWeaponEventArgs(base.Firearm.Owner, base.Firearm));
			}
			if (base.IsLocalPlayer)
			{
				PlayFireAnims(FirearmAnimatorHashes.DryFire);
			}
			_audioModule.PlayNormal(_dryFireClip);
		}

		private void PlayFireAnims(int hash)
		{
			base.Firearm.AnimSetFloat(FirearmAnimatorHashes.Random, UnityEngine.Random.value, checkIfExists: true);
			base.Firearm.AnimSetTrigger(hash);
		}

		private MessageType DecodeHeader(NetworkReader reader)
		{
			return (MessageType)reader.ReadByte();
		}

		private void SendRpc(MessageType header, Action<NetworkWriter> writerFunc = null, bool toAll = true)
		{
			SendRpc((NetworkWriter x) =>
			{
				x.WriteSubheader(header);
				writerFunc?.Invoke(x);
			}, toAll);
		}

		private void SendCmd(MessageType header, Action<NetworkWriter> writerFunc = null)
		{
			SendCmd((NetworkWriter x) =>
			{
				x.WriteSubheader(header);
				writerFunc?.Invoke(x);
			});
		}
	}
}

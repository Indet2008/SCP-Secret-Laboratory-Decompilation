using System.Collections.Generic;
using InventorySystem.Items.Autosync;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class AnimationToggleableReloaderModule : AnimatorReloaderModuleBase
	{
		private enum RpcType
		{
			LoadableAmmoSync = 0,
			StopAnimations = 1
		}

		private static readonly ActionName[] CancelActions = new ActionName[2]
		{
			ActionName.Shoot,
			ActionName.Zoom
		};

		private static readonly Dictionary<ushort, int> SyncLoadableAmmo = new Dictionary<ushort, int>();

		private readonly RateLimiter _postCancelLimiter = new RateLimiter(0.7f);

		private int _prevLoadableAmmo;

		private int ServerLoadableAmmo
		{
			get
			{
				if (!base.Firearm.TryGetModule<IPrimaryAmmoContainerModule>(out var module))
				{
					return 0;
				}
				int a = module.AmmoMax - module.AmmoStored;
				int curAmmo = base.Firearm.OwnerInventory.GetCurAmmo(module.AmmoType);
				return Mathf.Min(a, curAmmo);
			}
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			if (base.IsControllable)
			{
				UpdateControls();
			}
			if (base.IsServer)
			{
				UpdateServer();
			}
			base.Firearm.AnimSetInt(FirearmAnimatorHashes.LoadableAmmo, _prevLoadableAmmo);
		}

		internal override void OnEquipped()
		{
			base.OnEquipped();
			SyncLoadableAmmo.TryGetValue(base.ItemSerial, out _prevLoadableAmmo);
		}

		protected override MessageInterceptionResult InterceptMessage(NetworkReader reader, ushort serial, ReloaderMessageHeader header, AutosyncMessageType scenario)
		{
			if (scenario == AutosyncMessageType.Cmd)
			{
				switch (header)
				{
				case ReloaderMessageHeader.Reload:
				case ReloaderMessageHeader.Unload:
					if (!_postCancelLimiter.InstantReady)
					{
						return MessageInterceptionResult.Stop;
					}
					return MessageInterceptionResult.Continue;
				case ReloaderMessageHeader.Stop:
					ServerStopAnimations();
					return MessageInterceptionResult.Stop;
				default:
					return MessageInterceptionResult.Continue;
				}
			}
			if (header == ReloaderMessageHeader.Custom && (scenario == AutosyncMessageType.RpcInstance || scenario == AutosyncMessageType.RpcTemplate))
			{
				ProcessCustomRpc(reader, serial, (RpcType)reader.ReadByte(), scenario);
				return MessageInterceptionResult.Stop;
			}
			return base.InterceptMessage(reader, serial, header, scenario);
		}

		protected override void StartReloading()
		{
			base.Firearm.AnimSetBool(FirearmAnimatorHashes.Reload, b: true);
			base.Firearm.AnimSetTrigger(FirearmAnimatorHashes.StartReloadOrUnload);
			if (base.IsServer)
			{
				ServerSendLoadableAmmo();
			}
		}

		public void ServerStopAnimations()
		{
			SendRpc((NetworkWriter x) =>
			{
				x.WriteSubheader(ReloaderMessageHeader.Custom);
				x.WriteSubheader(RpcType.StopAnimations);
			});
		}

		protected override void StartUnloading()
		{
			base.Firearm.AnimSetBool(FirearmAnimatorHashes.Unload, b: true);
			base.Firearm.AnimSetTrigger(FirearmAnimatorHashes.StartReloadOrUnload);
			if (base.IsServer)
			{
				ServerSendLoadableAmmo();
			}
		}

		protected override void OnStopReloadingAndUnloading()
		{
			StopAnimations();
			if (_postCancelLimiter.InstantReady)
			{
				_postCancelLimiter.RegisterInput();
			}
		}

		private void ProcessCustomRpc(NetworkReader reader, ushort serial, RpcType rpc, AutosyncMessageType messageType)
		{
			bool flag = messageType == AutosyncMessageType.RpcInstance;
			switch (rpc)
			{
			case RpcType.StopAnimations:
				if (flag)
				{
					StopAnimations();
				}
				break;
			case RpcType.LoadableAmmoSync:
			{
				byte b = reader.ReadByte();
				SyncLoadableAmmo[serial] = b;
				if (messageType == AutosyncMessageType.RpcInstance)
				{
					_prevLoadableAmmo = b;
				}
				break;
			}
			}
		}

		private void StopAnimations()
		{
			base.Firearm.AnimSetBool(FirearmAnimatorHashes.Reload, b: false);
			base.Firearm.AnimSetBool(FirearmAnimatorHashes.Unload, b: false);
		}

		private void UpdateControls()
		{
			if (!base.IsReloading && !base.IsUnloading)
			{
				return;
			}
			ActionName[] cancelActions = CancelActions;
			foreach (ActionName action in cancelActions)
			{
				if (GetActionDown(action))
				{
					SendCmd((NetworkWriter writer) =>
					{
						writer.WriteSubheader(ReloaderMessageHeader.Stop);
					});
					break;
				}
			}
		}

		private void UpdateServer()
		{
			int serverLoadableAmmo = ServerLoadableAmmo;
			if (_prevLoadableAmmo != serverLoadableAmmo)
			{
				_prevLoadableAmmo = serverLoadableAmmo;
				ServerSendLoadableAmmo();
			}
		}

		private void ServerSendLoadableAmmo()
		{
			int clamped = Mathf.Clamp(_prevLoadableAmmo, 0, 255);
			SendRpc((NetworkWriter writer) =>
			{
				writer.WriteSubheader(ReloaderMessageHeader.Custom);
				writer.WriteSubheader(RpcType.LoadableAmmoSync);
				writer.WriteByte((byte)clamped);
			});
		}
	}
}

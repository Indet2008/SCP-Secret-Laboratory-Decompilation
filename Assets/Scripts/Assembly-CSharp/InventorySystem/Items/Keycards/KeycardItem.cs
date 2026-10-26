using System;
using System.Collections.Generic;
using Interactables.Interobjects.DoorUtils;
using InventorySystem.Items.AutoIcons;
using InventorySystem.Items.Autosync;
using InventorySystem.Items.Firearms.Modules.Misc;
using InventorySystem.Items.Pickups;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using RemoteAdmin.Interfaces;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class KeycardItem : AutosyncItem, IItemDescription, IItemNametag, IDoorPermissionProvider, ICustomDisplayName
	{
		protected enum MsgType : byte
		{
			Custom = 0,
			OnKeycardUsed = 1,
			Inspect = 2,
			NewPlayerFullResync = 3
		}

		public static readonly Dictionary<ushort, double> StartInspectTimes = new Dictionary<ushort, double>();

		[SerializeField]
		private ItemDescriptionType _descriptionType;

		[SerializeField]
		private bool _allowInspect;

		private readonly ClientRequestTimer _inspectRequestTimer = new ClientRequestTimer();

		private static readonly ActionName[] CancelInspectButtons = new ActionName[2]
		{
			ActionName.Shoot,
			ActionName.Zoom
		};

		private bool IsIdle
		{
			get
			{
				if (HasViewmodel)
				{
					if (ViewModel is KeycardViewmodel keycardViewmodel)
					{
						return keycardViewmodel.IsIdle;
					}
					return false;
				}
				return false;
			}
		}

		[field: SerializeField]
		public bool OpenDoorsOnThrow { get; private set; }

		[field: SerializeField]
		public KeycardGfx KeycardGfx { get; private set; }

		[field: SerializeField]
		public DetailBase[] Details { get; private set; }

		[field: SerializeField]
		public bool Customizable { get; private set; }

		public override float Weight => 0.01f + KeycardGfx.ExtraWeight;

		public override ItemDescriptionType DescriptionType => _descriptionType;

		public string Name
		{
			get
			{
				DetailBase[] details = Details;
				for (int i = 0; i < details.Length; i++)
				{
					if (details[i] is IItemNametag itemNametag)
					{
						return itemNametag.Name;
					}
				}
				return ItemTypeId.GetName();
			}
		}

		public string Description
		{
			get
			{
				DetailBase[] details = Details;
				for (int i = 0; i < details.Length; i++)
				{
					if (details[i] is IItemDescription itemDescription)
					{
						return itemDescription.Description;
					}
				}
				return ItemTypeId.GetDescription();
			}
		}

		public string DisplayName => null;

		public bool CanBeDisplayed => !Customizable;

		public PermissionUsed PermissionsUsedCallback { get; private set; }

		public static event Action<ushort, bool> OnKeycardUsed;

		public virtual DoorPermissionFlags GetPermissions(IDoorPermissionRequester requester)
		{
			DetailBase[] details = Details;
			for (int i = 0; i < details.Length; i++)
			{
				if (details[i] is IDoorPermissionProvider doorPermissionProvider)
				{
					return doorPermissionProvider.GetPermissions(requester);
				}
			}
			return DoorPermissionFlags.None;
		}

		public override void OnAdded(ItemPickupBase pickup)
		{
			base.OnAdded(pickup);
			if (NetworkServer.active)
			{
				PermissionsUsedCallback = OnUsed;
				KeycardDetailSynchronizer.ServerProcessItem(this);
			}
		}

		public override void OnHolstered()
		{
			base.OnHolstered();
			if (NetworkServer.active)
			{
				ServerSendPublicRpc((NetworkWriter x) =>
				{
					WriteInspect(x, state: false);
				});
			}
		}

		public override void EquipUpdate()
		{
			base.EquipUpdate();
			if (!base.IsControllable || _inspectRequestTimer.Busy)
			{
				return;
			}
			if (!StartInspectTimes.ContainsKey(base.ItemSerial))
			{
				if (GetActionDown(ActionName.InspectItem) && IsIdle)
				{
					ClientSendCmd((NetworkWriter x) =>
					{
						WriteInspect(x, state: true);
					});
					_inspectRequestTimer.Trigger();
				}
				return;
			}
			bool flag = IsIdle;
			ActionName[] cancelInspectButtons = CancelInspectButtons;
			foreach (ActionName action in cancelInspectButtons)
			{
				flag |= GetActionDown(action);
			}
			if (flag)
			{
				ClientSendCmd((NetworkWriter x) =>
				{
					WriteInspect(x, state: false);
				});
				_inspectRequestTimer.Trigger();
			}
		}

		internal override void OnTemplateReloaded(bool wasEverLoaded)
		{
			base.OnTemplateReloaded(wasEverLoaded);
			if (TryGetComponent<AutoIconApplier>(out var component))
			{
				component.UpdateIcon();
			}
			if (wasEverLoaded)
			{
				return;
			}
			CustomNetworkManager.OnClientReady += OnStaticDataReset;
			ReferenceHub.OnPlayerAdded += (ReferenceHub hub) =>
			{
				if (NetworkServer.active)
				{
					ServerOnNewPlayerConnected(hub);
				}
			};
		}

		protected virtual void OnUsed(IDoorPermissionRequester requester, bool success)
		{
			ServerSendPublicRpc((NetworkWriter x) =>
			{
				x.WriteSubheader(MsgType.OnKeycardUsed);
				x.WriteBool(success);
			});
		}

		protected virtual void ServerOnNewPlayerConnected(ReferenceHub hub)
		{
			if (StartInspectTimes.Count == 0)
			{
				return;
			}
			ServerSendTargetRpc(hub, (NetworkWriter writer) =>
			{
				writer.WriteSubheader(MsgType.NewPlayerFullResync);
				foreach (KeyValuePair<ushort, double> startInspectTime in StartInspectTimes)
				{
					writer.WriteUShort(startInspectTime.Key);
					writer.WriteDouble(startInspectTime.Value);
				}
			});
		}

		protected virtual void OnStaticDataReset()
		{
			StartInspectTimes.Clear();
		}

		public sealed override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			switch ((MsgType)reader.ReadByte())
			{
			case MsgType.Custom:
				ClientProcessCustomRpcTemplate(reader, serial);
				break;
			case MsgType.OnKeycardUsed:
				OnKeycardUsed?.Invoke(serial, reader.ReadBool());
				StartInspectTimes.Remove(serial);
				break;
			case MsgType.Inspect:
				if (reader.ReadBool() && _allowInspect)
				{
					StartInspectTimes[serial] = NetworkTime.time;
				}
				else
				{
					StartInspectTimes.Remove(serial);
				}
				break;
			case MsgType.NewPlayerFullResync:
				StartInspectTimes.Clear();
				while (reader.Remaining > 0)
				{
					ushort key = reader.ReadUShort();
					double value = reader.ReadDouble();
					StartInspectTimes[key] = value;
				}
				break;
			}
		}

		public sealed override void ClientProcessRpcInstance(NetworkReader reader)
		{
			base.ClientProcessRpcInstance(reader);
			if (reader.ReadByte() == 0)
			{
				ClientProcessCustomRpcInstance(reader);
			}
		}

		public sealed override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			switch ((MsgType)reader.ReadByte())
			{
			case MsgType.Custom:
				ServerProcessCustomCmd(reader);
				break;
			case MsgType.Inspect:
			{
				bool num = reader.ReadBool();
				bool flag = StartInspectTimes.ContainsKey(base.ItemSerial);
				if (!num)
				{
					ServerSendPublicRpc((NetworkWriter x) =>
					{
						WriteInspect(x, state: false);
					});
				}
				else
				{
					if (flag)
					{
						break;
					}
					PlayerInspectingKeycardEventArgs e = new PlayerInspectingKeycardEventArgs(base.Owner, this);
					PlayerEvents.OnInspectingKeycard(e);
					if (e.IsAllowed)
					{
						ServerSendPublicRpc((NetworkWriter x) =>
						{
							WriteInspect(x, state: true);
						});
						PlayerEvents.OnInspectedKeycard(new PlayerInspectedKeycardEventArgs(base.Owner, this));
					}
				}
				break;
			}
			}
		}

		protected virtual void ClientProcessCustomRpcTemplate(NetworkReader reader, ushort serial)
		{
		}

		protected virtual void ClientProcessCustomRpcInstance(NetworkReader reader)
		{
		}

		protected virtual void ServerProcessCustomCmd(NetworkReader reader)
		{
		}

		private static void WriteInspect(NetworkWriter writer, bool state)
		{
			writer.WriteSubheader(MsgType.Inspect);
			writer.WriteBool(state);
		}
	}
}

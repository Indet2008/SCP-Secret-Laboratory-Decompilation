using System.Collections.Generic;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class SimpleTriggerModule : ModuleBase, ITriggerControllerModule
	{
		internal class ReceivedData
		{
			public bool IsHeld => PressTime > ReleaseTime;

			public double PressTime { get; private set; }

			public double ReleaseTime { get; private set; }

			public void Set(bool isHeld)
			{
				if (isHeld)
				{
					PressTime = NetworkTime.time;
				}
				else
				{
					ReleaseTime = NetworkTime.time;
				}
			}
		}

		private static readonly Dictionary<ushort, ReceivedData> SyncData = new Dictionary<ushort, ReceivedData>();

		private readonly ReceivedData _clientData = new ReceivedData();

		[field: SerializeField]
		public ModuleBase[] IgnoredBusyModules { get; private set; }

		public double LastTriggerPress => SelfData.PressTime;

		public double LastTriggerRelease => SelfData.ReleaseTime;

		public bool TriggerHeld
		{
			get
			{
				if (base.IsControllable ? KeyHeld : GetData(base.ItemSerial).IsHeld)
				{
					return !base.PrimaryActionBlocked;
				}
				return false;
			}
		}

		private ReceivedData SelfData
		{
			get
			{
				if (!base.IsLocalPlayer)
				{
					return GetData(base.ItemSerial);
				}
				return _clientData;
			}
		}

		private bool KeyHeld
		{
			get
			{
				if (GetAction(ActionName.Shoot))
				{
					return !PreventHoldingTrigger;
				}
				return false;
			}
		}

		private bool PreventHoldingTrigger
		{
			get
			{
				ModuleBase[] modules = base.Firearm.Modules;
				foreach (ModuleBase moduleBase in modules)
				{
					if (moduleBase is ITriggerPressPreventerModule { ClientBlockTrigger: not false })
					{
						return true;
					}
					if (moduleBase is IBusyIndicatorModule { IsBusy: not false } && !IgnoredBusyModules.Contains(moduleBase))
					{
						return true;
					}
				}
				return false;
			}
		}

		private void ServerSetTrigger(bool isHeld)
		{
			SendRpc((NetworkWriter x) =>
			{
				x.WriteBool(isHeld);
			});
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			if (!base.IsLocalPlayer)
			{
				return;
			}
			bool triggerStatus = TriggerHeld;
			if (_clientData.IsHeld != triggerStatus)
			{
				_clientData.Set(triggerStatus);
				SendCmd((NetworkWriter x) =>
				{
					x.WriteBool(triggerStatus);
				});
			}
		}

		internal override void OnClientReady()
		{
			base.OnClientReady();
			SyncData.Clear();
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			ServerSetTrigger(reader.ReadBool());
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			ReceivedData data = GetData(serial);
			bool flag = reader.ReadBool();
			if (flag != data.IsHeld)
			{
				data.Set(flag);
			}
		}

		internal static ReceivedData GetData(ushort serial)
		{
			return SyncData.GetOrAdd(serial, () => new ReceivedData());
		}
	}
}

using System.Runtime.InteropServices;
using InventorySystem.Items.Pickups;
using Mirror;
using Scp914;
using UnityEngine;

namespace InventorySystem.Items.Jailbird
{
	public class JailbirdPickup : CollisionDetectionPickup, IUpgradeTrigger
	{
		[SyncVar]
		public JailbirdWearState Wear;

		[SerializeField]
		private JailbirdMaterialController _materialController;

		private JailbirdWearState _prevWear;

		public float TotalMelee { get; set; }

		public int TotalCharges { get; set; }

		public JailbirdWearState NetworkWear
		{
			get
			{
				return Wear;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref Wear, 2uL, null);
			}
		}

		public void ServerOnUpgraded(Scp914KnobSetting setting)
		{
			if (NetworkServer.active)
			{
				if (setting == Scp914KnobSetting.Coarse)
				{
					TotalCharges = JailbirdDeteriorationTracker.Scp914CoarseCharges;
					TotalMelee = JailbirdDeteriorationTracker.Scp914CoarseDamage;
					NetworkWear = JailbirdWearState.AlmostBroken;
				}
				else
				{
					TotalCharges = 0;
					TotalMelee = 0f;
					NetworkWear = JailbirdWearState.Healthy;
				}
			}
		}

		private void Update()
		{
			if (_prevWear != Wear)
			{
				UpdateWearFromSyncvar();
			}
		}

		private void UpdateWearFromSyncvar()
		{
			_prevWear = Wear;
			JailbirdDeteriorationTracker.ReceivedStates[Info.Serial] = Wear;
		}

		protected override void Start()
		{
			base.Start();
			UpdateWearFromSyncvar();
			_materialController.SetSerial(Info.Serial);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				GeneratedNetworkCode._Write_InventorySystem_002EItems_002EJailbird_002EJailbirdWearState(writer, Wear);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				GeneratedNetworkCode._Write_InventorySystem_002EItems_002EJailbird_002EJailbirdWearState(writer, Wear);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref Wear, null, GeneratedNetworkCode._Read_InventorySystem_002EItems_002EJailbird_002EJailbirdWearState(reader));
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref Wear, null, GeneratedNetworkCode._Read_InventorySystem_002EItems_002EJailbird_002EJailbirdWearState(reader));
			}
		}
	}
}

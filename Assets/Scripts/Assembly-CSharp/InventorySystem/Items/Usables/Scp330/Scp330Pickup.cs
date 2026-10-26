using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using InventorySystem.Items.Pickups;
using InventorySystem.Searching;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp330
{
	public class Scp330Pickup : CollisionDetectionPickup
	{
		[Serializable]
		private struct IndividualCandy
		{
			[SerializeField]
			private CandyKindID _kind;

			[SerializeField]
			private GameObject _candyObject;

			public void Refresh(CandyKindID exposed)
			{
				_candyObject.SetActive(exposed == _kind);
			}
		}

		[SyncVar]
		public CandyKindID ExposedCandy;

		[SerializeField]
		private IndividualCandy[] _candyTypes;

		private int _prevExposed = -1;

		public List<CandyKindID> StoredCandies { get; set; } = new List<CandyKindID>();

		public CandyKindID NetworkExposedCandy
		{
			get
			{
				return ExposedCandy;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref ExposedCandy, 2uL, null);
			}
		}

		public override PickupSearchCompletor GetPickupSearchCompletor(SearchCoordinator coordinator, float sqrDistance)
		{
			return new Scp330SearchCompletor(coordinator.Hub, this, sqrDistance);
		}

		protected override void Start()
		{
			base.Start();
			UpdateExposed();
		}

		private void Update()
		{
			UpdateExposed();
		}

		private void UpdateExposed()
		{
			int exposedCandy = (int)ExposedCandy;
			if (_prevExposed != exposedCandy)
			{
				IndividualCandy[] candyTypes = _candyTypes;
				foreach (IndividualCandy individualCandy in candyTypes)
				{
					individualCandy.Refresh(ExposedCandy);
				}
				_prevExposed = exposedCandy;
				if (NetworkServer.active && StoredCandies.Count == 0)
				{
					DestroySelf();
				}
			}
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
				GeneratedNetworkCode._Write_InventorySystem_002EItems_002EUsables_002EScp330_002ECandyKindID(writer, ExposedCandy);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				GeneratedNetworkCode._Write_InventorySystem_002EItems_002EUsables_002EScp330_002ECandyKindID(writer, ExposedCandy);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref ExposedCandy, null, GeneratedNetworkCode._Read_InventorySystem_002EItems_002EUsables_002EScp330_002ECandyKindID(reader));
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref ExposedCandy, null, GeneratedNetworkCode._Read_InventorySystem_002EItems_002EUsables_002EScp330_002ECandyKindID(reader));
			}
		}
	}
}

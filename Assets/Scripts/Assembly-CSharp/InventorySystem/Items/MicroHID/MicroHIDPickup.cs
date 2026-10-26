using System;
using System.Collections.Generic;
using InventorySystem.Items.MicroHID.Modules;
using InventorySystem.Items.Pickups;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.MicroHID
{
	public class MicroHIDPickup : CollisionDetectionPickup
	{
		public static readonly Dictionary<ushort, MicroHIDPickup> PickupsBySerial = new Dictionary<ushort, MicroHIDPickup>();

		[SerializeField]
		private MicroHIDParticles _particles;

		[SerializeField]
		private Transform _simulatedOwnerCam;

		private CycleController _cycleController;

		public event Action OnSelfDestroyed;

		private void Update()
		{
			if (NetworkServer.active)
			{
				_cycleController.ServerUpdatePickup(this);
			}
		}

		protected override void Start()
		{
			base.Start();
			ushort serial = Info.Serial;
			PickupsBySerial[serial] = this;
			_particles.Init(serial, _simulatedOwnerCam);
			if (NetworkServer.active)
			{
				_cycleController = CycleSyncModule.GetCycleController(serial);
			}
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			OnSelfDestroyed?.Invoke();
			PickupsBySerial.Remove(Info.Serial);
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}

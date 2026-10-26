using InventorySystem.Items.Firearms.Modules;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace InventorySystem.Items.MicroHID.Modules
{
	public class MovementSpeedModule : ModuleBase, IMovementSpeedModifier
	{
		[SerializeField]
		private float _movementSpeedLimit;

		public bool MovementModifierActive => true;

		public float MovementSpeedMultiplier => 1f;

		public float MovementSpeedLimit => _movementSpeedLimit;
	}
}

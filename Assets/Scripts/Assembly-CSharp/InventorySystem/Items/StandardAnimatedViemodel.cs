using CameraShaking;
using InventorySystem.Items.SwayControllers;
using UnityEngine;

namespace InventorySystem.Items
{
	public class StandardAnimatedViemodel : AnimatedViewmodelBase
	{
		[SerializeField]
		protected Transform HandsPivot;

		[SerializeField]
		private Transform _trackerCamera;

		[SerializeField]
		private float _trackerForceScale = 1f;

		[SerializeField]
		private Vector3 _trackerOffset;

		[SerializeField]
		private float _fov = 50f;

		private IItemSwayController _swayController;

		public override IItemSwayController SwayController => _swayController;

		public override float ViewmodelCameraFOV => _fov;

		internal override void OnEquipped()
		{
			base.OnEquipped();
			if (_swayController == null)
			{
				_swayController = GetNewSwayController();
			}
			CameraShakeController.AddEffect(new TrackerShake(_trackerCamera, Quaternion.Euler(_trackerOffset), _trackerForceScale));
		}

		public override void InitSpectator(ReferenceHub ply, ItemIdentifier id, bool wasEquipped)
		{
			base.InitSpectator(ply, id, wasEquipped);
			if (_swayController == null)
			{
				_swayController = GetNewSwayController();
			}
		}

		protected virtual IItemSwayController GetNewSwayController()
		{
			return new GoopSway(new GoopSway.GoopSwaySettings(HandsPivot, 0.65f, 0.0035f, 0.04f, 7f, 6.5f, 0.03f, 1.6f, invertSway: false), base.Hub);
		}
	}
}

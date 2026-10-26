using UnityEngine;

namespace Interactables.Interobjects.DoorButtons
{
	public class SimpleButton : BasicDoorButton
	{
		[SerializeField]
		private Material _openMat;

		[SerializeField]
		private Material _closedMat;

		[SerializeField]
		private Material _movingMat;

		[SerializeField]
		private Material _lockedMat;

		[SerializeField]
		private MeshRenderer _renderer;

		protected override void SetMoving()
		{
			_renderer.sharedMaterial = _movingMat;
		}

		protected override void SetAsDestroyed()
		{
			base.SetAsDestroyed();
			_renderer.sharedMaterial = _lockedMat;
		}

		protected override void SetIdle()
		{
			_renderer.sharedMaterial = (base.ParentDoor.TargetState ? _openMat : _closedMat);
		}

		protected override void SetLocked()
		{
			_renderer.sharedMaterial = _lockedMat;
		}
	}
}

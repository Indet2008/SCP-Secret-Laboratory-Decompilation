using System;
using UnityEngine;

namespace Interactables.Interobjects.DoorButtons
{
	public class LcdButton : SimpleButton
	{
		[Serializable]
		private struct MovingIndicator
		{
			[SerializeField]
			private RectTransform _mover;

			[SerializeField]
			private RectTransform _openReference;

			[SerializeField]
			private RectTransform _closedReference;

			public readonly void SetStatus(float openPercent)
			{
				_mover.position = Vector3.Lerp(_closedReference.position, _openReference.position, openPercent);
			}
		}

		[SerializeField]
		private MovingIndicator _leftIndicator;

		[SerializeField]
		private MovingIndicator _rightIndicator;

		[SerializeField]
		private GameObject _movingState;

		[SerializeField]
		private GameObject _openState;

		[SerializeField]
		private GameObject _closedState;

		[SerializeField]
		private GameObject _nonBroken;

		[SerializeField]
		private GameObject _broken;

		[SerializeField]
		private float _refreshCooldown;

		private float _remainingCooldown;

		protected override void SetIdle()
		{
			base.SetIdle();
			_openState.SetActive(base.ParentDoor.TargetState);
			_closedState.SetActive(!base.ParentDoor.TargetState);
			_movingState.SetActive(value: false);
		}

		protected override void SetAsDestroyed()
		{
			base.SetAsDestroyed();
			_broken.SetActive(value: true);
			_nonBroken.SetActive(value: false);
		}

		protected override void RestoreNonDestroyed()
		{
			base.RestoreNonDestroyed();
			_broken.SetActive(value: false);
			_nonBroken.SetActive(value: true);
		}

		protected override void UpdateMoving()
		{
			base.UpdateMoving();
			if (_remainingCooldown > 0f)
			{
				_remainingCooldown -= Time.deltaTime;
			}
			else
			{
				UpdateIndicators();
			}
		}

		protected override void SetMoving()
		{
			base.SetMoving();
			_openState.SetActive(value: false);
			_closedState.SetActive(value: false);
			_movingState.SetActive(value: true);
			UpdateIndicators();
		}

		private void UpdateIndicators()
		{
			float exactState = base.ParentDoor.GetExactState();
			_leftIndicator.SetStatus(exactState);
			_rightIndicator.SetStatus(exactState);
			_remainingCooldown = _refreshCooldown;
		}
	}
}

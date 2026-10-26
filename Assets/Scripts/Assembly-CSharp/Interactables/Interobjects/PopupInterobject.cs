using Interactables.Verification;
using UnityEngine;

namespace Interactables.Interobjects
{
	public abstract class PopupInterobject : MonoBehaviour, IClientInteractable, IInteractable
	{
		protected enum PopupState : byte
		{
			Off = 0,
			Enabling = 1,
			On = 2,
			Disabling = 3
		}

		public float FadeSpeedSeconds = 0.2f;

		private static PopupInterobject _masterInstance;

		public float CloseAutomaticallyDistance;

		protected static Vector4 TrackedPosition;

		private static PopupInterobject _currentInstance;

		private static float _timer;

		private static PopupState _currentState;

		protected static PopupState CurrentState
		{
			get
			{
				return _currentState;
			}
			set
			{
				if (_currentState != value)
				{
					_currentState = value;
					if (_currentInstance != null)
					{
						_currentInstance.OnClientStateChange();
					}
				}
			}
		}

		public IVerificationRule VerificationRule => StandardDistanceVerification.Default;

		public void ClientInteract(InteractableCollider colliderId)
		{
			if (CurrentState != PopupState.Off)
			{
				CurrentState = PopupState.Disabling;
				return;
			}
			_currentInstance = this;
			_timer = 0f;
			CurrentState = PopupState.Enabling;
			TrackedPosition.w = CloseAutomaticallyDistance;
		}

		private void Update()
		{
			if (_masterInstance == null || !_masterInstance.gameObject.activeSelf)
			{
				_masterInstance = this;
			}
			if (_masterInstance != this)
			{
				return;
			}
			switch (CurrentState)
			{
			case PopupState.Enabling:
				_timer += Time.deltaTime;
				if (_timer >= _currentInstance.FadeSpeedSeconds)
				{
					CurrentState = PopupState.On;
				}
				_currentInstance.OnClientUpdate(_timer / _currentInstance.FadeSpeedSeconds);
				if (!IsInRange())
				{
					CurrentState = PopupState.Disabling;
				}
				break;
			case PopupState.Disabling:
				_timer -= Time.deltaTime;
				if (_timer <= 0f)
				{
					CurrentState = PopupState.Off;
				}
				_currentInstance.OnClientUpdate(_timer / _currentInstance.FadeSpeedSeconds);
				break;
			case PopupState.On:
				if (!IsInRange() || Input.GetKeyDown(InteractionCoordinator.InteractKey) || Cursor.visible)
				{
					CurrentState = PopupState.Disabling;
				}
				break;
			}
		}

		private static bool IsInRange()
		{
			if (TrackedPosition.w <= 0f)
			{
				return true;
			}
			if (!ReferenceHub.TryGetLocalHub(out var hub))
			{
				return false;
			}
			return Vector3.Distance(TrackedPosition, hub.transform.position) < TrackedPosition.w;
		}

		protected abstract void OnClientStateChange();

		protected abstract void OnClientUpdate(float enableRatio);
	}
}

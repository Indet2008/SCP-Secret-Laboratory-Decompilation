using Interactables.Interobjects.DoorUtils;
using Interactables.Verification;
using Mirror;
using Mirror.RemoteCalls;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace Interactables.Interobjects
{
	public class EmergencyDoorRelease : NetworkBehaviour, IServerInteractable, IInteractable, IVerificationRule
	{
		private const float InactiveButtonPositionOffset = -0.06f;

		private static readonly int EmissionColor;

		private static readonly CachedLayerMask AnticheatMask;

		[SerializeField]
		private float _initialTimer;

		[SerializeField]
		private AnimationCurve _clickAnim;

		[SerializeField]
		private Transform _animatedButton;

		[SerializeField]
		private DoorVariant _controlledDoor;

		[SerializeField]
		private Light _backplateLight;

		[SerializeField]
		private MeshRenderer[] _backplateRenderers;

		[SerializeField]
		private AnimationCurve _lightAnim;

		[SerializeField]
		[ColorUsage(true, true)]
		private Color _activeEmissionColor;

		[SerializeField]
		private float _activeLightIntensity;

		private MaterialPropertyBlock _propertyBlock;

		private AudioSource _clickSource;

		private float _lightsDuration;

		private float _remainingAnim;

		private float _animDuration;

		private float _releaseTimer;

		private bool _isReady;

		public IVerificationRule VerificationRule => this;

		public bool ClientCanInteract(InteractableCollider collider, RaycastHit hit)
		{
			return StandardDistanceVerification.Default.ClientCanInteract(collider, hit);
		}

		public bool ServerCanInteract(ReferenceHub hub, InteractableCollider collider)
		{
			if (!StandardDistanceVerification.Default.ServerCanInteract(hub, collider))
			{
				return false;
			}
			if (!(hub.roleManager.CurrentRole is IFpcRole))
			{
				return false;
			}
			Vector3 position = hub.PlayerCameraReference.position;
			Vector3 position2 = collider.transform.position;
			if (!Physics.Raycast(position, position2 - position, out var hitInfo, 5f, AnticheatMask))
			{
				return false;
			}
			if (!hitInfo.collider.TryGetComponent<InteractableCollider>(out var component))
			{
				return false;
			}
			MonoBehaviour target = component.Target;
			MonoBehaviour target2 = collider.Target;
			return target == target2;
		}

		public void ServerInteract(ReferenceHub ply, byte colliderId)
		{
			if (_isReady && !_controlledDoor.TargetState)
			{
				DoorLockMode mode = DoorLockUtils.GetMode((DoorLockReason)((!ply.serverRoles.BypassMode) ? _controlledDoor.ActiveLocks : 0));
				if ((mode.HasFlagFast(DoorLockMode.CanOpen) || (ply.IsSCP() && mode.HasFlagFast(DoorLockMode.ScpOverride))) && _controlledDoor.AllowInteracting(ply, colliderId))
				{
					RpcTriggerClick();
					_controlledDoor.NetworkTargetState = true;
				}
			}
		}

		[ClientRpc]
		private void RpcTriggerClick()
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			SendRPCInternal("System.Void Interactables.Interobjects.EmergencyDoorRelease::RpcTriggerClick()", -1791182937, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		private void Awake()
		{
			_releaseTimer = _initialTimer;
			_animDuration = _clickAnim.keys[^1].time;
			_lightsDuration = _lightAnim.keys[^1].time;
			_propertyBlock = new MaterialPropertyBlock();
			_clickSource = GetComponent<AudioSource>();
		}

		private void Update()
		{
			ButtonIdle();
			ButtonAnimate();
		}

		private void UpdateLight(float animProgress)
		{
			Color value = Color.Lerp(Color.black, _activeEmissionColor, animProgress);
			for (int i = 0; i < _backplateRenderers.Length; i++)
			{
				MeshRenderer meshRenderer = _backplateRenderers[i];
				if (i == 0)
				{
					meshRenderer.GetPropertyBlock(_propertyBlock);
				}
				_propertyBlock.SetColor(EmissionColor, value);
				meshRenderer.SetPropertyBlock(_propertyBlock);
			}
			_backplateLight.intensity = Mathf.Lerp(0f, _activeLightIntensity, animProgress);
		}

		private void ButtonIdle()
		{
			if (_controlledDoor.TargetState)
			{
				_isReady = false;
				_releaseTimer = _initialTimer;
				_animatedButton.localPosition = Vector3.forward * -0.06f;
				UpdateLight(0f);
			}
			else if (!_controlledDoor.TargetState && !_isReady)
			{
				_animatedButton.localPosition = Vector3.forward * -0.06f;
				_releaseTimer -= Time.deltaTime;
				if (_releaseTimer <= 0f)
				{
					_isReady = true;
					_clickSource.Play();
					_animatedButton.localPosition = Vector3.forward * 0f;
				}
			}
		}

		private void ButtonAnimate()
		{
			if (!_controlledDoor.TargetState && _releaseTimer <= _lightsDuration)
			{
				float animProgress = _lightAnim.Evaluate(_releaseTimer);
				UpdateLight(animProgress);
			}
			if (!(_remainingAnim <= 0f))
			{
				_remainingAnim -= Time.deltaTime;
				float time = _animDuration - _remainingAnim;
				float num = _clickAnim.Evaluate(time);
				_animatedButton.localPosition = Vector3.forward * num;
			}
		}

		static EmergencyDoorRelease()
		{
			EmissionColor = Shader.PropertyToID("_EmissiveColor");
			AnticheatMask = new CachedLayerMask("Default", "Glass", "Door", "InteractableNoPlayerCollision");
			RemoteProcedureCalls.RegisterRpc(typeof(EmergencyDoorRelease), "System.Void Interactables.Interobjects.EmergencyDoorRelease::RpcTriggerClick()", InvokeUserCode_RpcTriggerClick);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcTriggerClick()
		{
			_isReady = false;
			_releaseTimer = _initialTimer;
			if (_clickSource.isPlaying)
			{
				_clickSource.Stop();
			}
			_clickSource.Play();
			_remainingAnim = _animDuration;
		}

		protected static void InvokeUserCode_RpcTriggerClick(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcTriggerClick called on server.");
			}
			else
			{
				((EmergencyDoorRelease)obj).UserCode_RpcTriggerClick();
			}
		}
	}
}

using Interactables.Interobjects.DoorButtons;
using Interactables.Interobjects.DoorUtils;
using Mirror;
using Mirror.RemoteCalls;
using UnityEngine;

namespace Interactables.Interobjects
{
	public class BasicDoor : DoorVariant
	{
		private static readonly int AnimHash;

		[Header("General settings")]
		[SerializeField]
		internal Animator MainAnimator;

		[SerializeField]
		internal AudioSource MainSource;

		[SerializeField]
		private float _cooldownDuration;

		[SerializeField]
		private float _consideredOpenThreshold = 0.7f;

		[SerializeField]
		private float _anticheatPassableThreshold = 0.2f;

		[SerializeField]
		internal DoorAudioSettings AudioSettings;

		[Header("These values are used to get the exact state")]
		[SerializeField]
		private Transform _stateMoveable;

		[SerializeField]
		private Transform _stateStator;

		[SerializeField]
		private float _stateMinDis;

		[SerializeField]
		private float _stateMaxDis;

		private float _remainingAnimCooldown;

		private bool _animationNeedsRefreshing;

		private bool? _lastAppliedAnimationState;

		protected virtual float AnimationInterruptThreshold => 0.85f;

		public override bool AllowInteracting(ReferenceHub ply, byte colliderId)
		{
			if (_remainingAnimCooldown <= 0f)
			{
				return !_animationNeedsRefreshing;
			}
			return false;
		}

		public override float GetExactState()
		{
			Vector3 position = _stateMoveable.position;
			Vector3 position2 = _stateStator.position;
			float value = Mathf.Abs(position.x - position2.x) + Mathf.Abs(position.y - position2.y) + Mathf.Abs(position.z - position2.z);
			return Mathf.Clamp01(Mathf.InverseLerp(_stateMinDis, _stateMaxDis, value));
		}

		public override bool IsConsideredOpen()
		{
			return GetExactState() > _consideredOpenThreshold;
		}

		public override bool AnticheatPassageApproved()
		{
			if (!IsConsideredOpen())
			{
				if (!TargetState)
				{
					return GetExactState() > _anticheatPassableThreshold;
				}
				return false;
			}
			return true;
		}

		public override void LockBypassDenied(ReferenceHub ply, byte colliderId)
		{
			RpcPlayBeepSound();
		}

		public override void PermissionsDenied(ReferenceHub ply, byte colliderId)
		{
			RpcPlayBeepSound();
			PlayDeniedButtonAnims(ply.GetCombinedPermissions(this));
		}

		[ClientRpc]
		private void RpcPlayBeepSound()
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			SendRPCInternal("System.Void Interactables.Interobjects.BasicDoor::RpcPlayBeepSound()", 1846284446, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		[ClientRpc]
		private void PlayDeniedButtonAnims(DoorPermissionFlags perms)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			GeneratedNetworkCode._Write_Interactables_002EInterobjects_002EDoorUtils_002EDoorPermissionFlags(writer, perms);
			SendRPCInternal("System.Void Interactables.Interobjects.BasicDoor::PlayDeniedButtonAnims(Interactables.Interobjects.DoorUtils.DoorPermissionFlags)", -2075370311, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		private bool TryApplyNewStateAnimation()
		{
			if (_lastAppliedAnimationState.HasValue)
			{
				if (_lastAppliedAnimationState.Value == TargetState)
				{
					return true;
				}
				float exactState = GetExactState();
				if (TargetState)
				{
					if (exactState > 1f - AnimationInterruptThreshold)
					{
						return false;
					}
				}
				else if (exactState < AnimationInterruptThreshold)
				{
					return false;
				}
			}
			MainAnimator.SetBool(AnimHash, TargetState);
			_lastAppliedAnimationState = TargetState;
			if (MainSource != null && AudioSettings != null)
			{
				AudioClip clip = (TargetState ? AudioSettings.RandomOpeningSound : AudioSettings.RandomClosingSound);
				if (clip != null)
				{
					MainSource.PlayOneShot(clip);
				}
			}
			if (NetworkServer.active)
			{
				_remainingAnimCooldown = _cooldownDuration;
			}
			return true;
		}

		protected override void Update()
		{
			base.Update();
			if (_animationNeedsRefreshing)
			{
				_animationNeedsRefreshing = !TryApplyNewStateAnimation();
			}
			if (NetworkServer.active && _remainingAnimCooldown > 0f)
			{
				_remainingAnimCooldown -= Time.deltaTime;
			}
		}

		protected void Start()
		{
			MainAnimator.SetBool(AnimHash, TargetState);
		}

		internal override void TargetStateChanged()
		{
			_animationNeedsRefreshing = true;
		}

		static BasicDoor()
		{
			AnimHash = Animator.StringToHash("isOpen");
			RemoteProcedureCalls.RegisterRpc(typeof(BasicDoor), "System.Void Interactables.Interobjects.BasicDoor::RpcPlayBeepSound()", InvokeUserCode_RpcPlayBeepSound);
			RemoteProcedureCalls.RegisterRpc(typeof(BasicDoor), "System.Void Interactables.Interobjects.BasicDoor::PlayDeniedButtonAnims(Interactables.Interobjects.DoorUtils.DoorPermissionFlags)", InvokeUserCode_PlayDeniedButtonAnims__DoorPermissionFlags);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcPlayBeepSound()
		{
			MainSource.PlayOneShot(AudioSettings.AccessDenied);
		}

		protected static void InvokeUserCode_RpcPlayBeepSound(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcPlayBeepSound called on server.");
			}
			else
			{
				((BasicDoor)obj).UserCode_RpcPlayBeepSound();
			}
		}

		protected void UserCode_PlayDeniedButtonAnims__DoorPermissionFlags(DoorPermissionFlags perms)
		{
			ButtonVariant[] buttons = base.Buttons;
			for (int i = 0; i < buttons.Length; i++)
			{
				if (buttons[i] is BasicDoorButton basicDoorButton)
				{
					basicDoorButton.TriggerDoorDenied(perms);
				}
			}
		}

		protected static void InvokeUserCode_PlayDeniedButtonAnims__DoorPermissionFlags(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC PlayDeniedButtonAnims called on server.");
			}
			else
			{
				((BasicDoor)obj).UserCode_PlayDeniedButtonAnims__DoorPermissionFlags(GeneratedNetworkCode._Read_Interactables_002EInterobjects_002EDoorUtils_002EDoorPermissionFlags(reader));
			}
		}
	}
}

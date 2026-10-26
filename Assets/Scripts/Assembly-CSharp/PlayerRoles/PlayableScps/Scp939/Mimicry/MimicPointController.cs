using System;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Subroutines;
using RelativePositioning;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939.Mimicry
{
	public class MimicPointController : StandardSubroutine<Scp939Role>
	{
		private enum RpcStateMsg
		{
			None = 0,
			PlacedByUser = 25,
			RemovedByUser = 26,
			DestroyedByDistance = 27
		}

		[SerializeField]
		private Renderer _mimicPointIcon;

		private bool _active;

		private RelativePosition _syncPos;

		private RpcStateMsg _syncMessage;

		private readonly AbilityCooldown _cooldown = new AbilityCooldown();

		private const float CooldownDuration = 0.2f;

		[field: SerializeField]
		public Transform MimicPointTransform { get; private set; }

		[field: SerializeField]
		public float MaxDistance { get; private set; }

		public bool Active
		{
			get
			{
				return _active;
			}
			private set
			{
				if (value != _active)
				{
					_active = value;
					if (value)
					{
						UpdateMimicPoint();
						MainCameraController.OnUpdated += UpdateIcon;
						FirstPersonMovementModule.OnPositionUpdated += UpdateMimicPoint;
					}
					else
					{
						MimicPointTransform.localPosition = Vector3.zero;
						_mimicPointIcon.enabled = false;
						MainCameraController.OnUpdated -= UpdateIcon;
						FirstPersonMovementModule.OnPositionUpdated -= UpdateMimicPoint;
					}
				}
			}
		}

		public float Distance => Vector3.Distance(base.CastRole.FpcModule.Position, MimicPointTransform.position);

		private bool Visible
		{
			get
			{
				if (ReferenceHub.TryGetPovHub(out var hub))
				{
					return hub.IsSCP();
				}
				return false;
			}
		}

		public event Action<Scp939HudTranslation> OnMessageReceived;

		private void UpdateMimicPoint()
		{
			Vector3 position = _syncPos.Position;
			MimicPointTransform.position = position;
			UpdateIcon();
			if (NetworkServer.active && !(Distance < MaxDistance))
			{
				_syncMessage = RpcStateMsg.DestroyedByDistance;
				ServerSendRpc(toAll: true);
			}
		}

		private void UpdateIcon()
		{
			if (Visible)
			{
				_mimicPointIcon.enabled = true;
				MimicPointTransform.forward = MainCameraController.CurrentCamera.forward;
			}
			else
			{
				_mimicPointIcon.enabled = false;
			}
		}

		private void OnHubAdded(ReferenceHub hub)
		{
			if (NetworkServer.active)
			{
				ServerSendRpc(hub);
			}
		}

		private void OnDestroy()
		{
			ReferenceHub.OnPlayerAdded -= OnHubAdded;
		}

		protected override void Awake()
		{
			base.Awake();
			ReferenceHub.OnPlayerAdded += OnHubAdded;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			Active = false;
			_cooldown.Clear();
		}

		public void ClientToggle()
		{
			if (_cooldown.IsReady)
			{
				ClientSendCmd();
				_cooldown.Trigger(0.20000000298023224);
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (Active)
			{
				_syncMessage = RpcStateMsg.RemovedByUser;
				Active = false;
			}
			else
			{
				_syncMessage = RpcStateMsg.PlacedByUser;
				_syncPos = new RelativePosition(base.CastRole.FpcModule.Position);
				Active = true;
			}
			ServerSendRpc(toAll: true);
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteByte((byte)_syncMessage);
			if (Active)
			{
				writer.WriteRelativePosition(_syncPos);
			}
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			_syncMessage = (RpcStateMsg)reader.ReadByte();
			switch (_syncMessage)
			{
			case RpcStateMsg.None:
				return;
			case RpcStateMsg.PlacedByUser:
				_syncPos = reader.ReadRelativePosition();
				Active = true;
				break;
			default:
				Active = false;
				break;
			}
			OnMessageReceived?.Invoke((Scp939HudTranslation)_syncMessage);
		}
	}
}

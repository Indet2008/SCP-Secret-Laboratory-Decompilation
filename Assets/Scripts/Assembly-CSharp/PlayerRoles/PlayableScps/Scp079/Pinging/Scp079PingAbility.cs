using LabApi.Events.Arguments.Scp079Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.PlayableScps.Scp079.GUI;
using PlayerRoles.Spectating;
using RelativePositioning;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Pinging
{
	public class Scp079PingAbility : Scp079KeyAbilityBase
	{
		[SerializeField]
		private int _cost;

		[SerializeField]
		private float _instantCooldown;

		[SerializeField]
		private float _groupCooldown;

		[SerializeField]
		private int _groupSize;

		[SerializeField]
		private Scp079PingInstance _prefab;

		[SerializeField]
		private Sprite[] _icons;

		private string _abilityName;

		private string _cooldownMsg;

		private RateLimiter _rateLimiter;

		private byte _syncProcessorIndex;

		private RelativePosition _syncPos;

		private Vector3 _syncNormal;

		private const float RaycastMaxDis = 130f;

		private static readonly IPingProcessor[] PingProcessors = new IPingProcessor[7]
		{
			new GeneratorPingProcessor(),
			new ProjectilePingProcessor(),
			new MicroHidPingProcesssor(),
			new HumanPingProcessor(),
			new ElevatorPingProcessor(),
			new DoorPingProcessor(),
			new DefaultPingProcessor()
		};

		public override ActionName ActivationKey => ActionName.Scp079PingLocation;

		public override bool IsReady
		{
			get
			{
				if (base.AuxManager.CurrentAux >= (float)_cost)
				{
					return _rateLimiter.AllReady;
				}
				return false;
			}
		}

		public override bool IsVisible => !Scp079CursorManager.LockCameras;

		public override string AbilityName => string.Format(_abilityName, _cost);

		public override string FailMessage
		{
			get
			{
				if (!(base.AuxManager.CurrentAux < (float)_cost))
				{
					if (!_rateLimiter.RateReady)
					{
						return _cooldownMsg;
					}
					return null;
				}
				return GetNoAuxMessage(_cost);
			}
		}

		private void SpawnIndicator(int processorIndex, RelativePosition pos, Vector3 normal)
		{
		}

		private void WriteSyncVars(NetworkWriter writer)
		{
			writer.WriteByte(_syncProcessorIndex);
			writer.WriteRelativePosition(_syncPos);
			writer.WriteVector3(_syncNormal);
		}

		private bool ServerCheckReceiver(ReferenceHub hub, Vector3 point, int processorIndex)
		{
			PlayerRoleBase currentRole = hub.roleManager.CurrentRole;
			if (!(currentRole is FpcStandardScp fpcStandardScp))
			{
				if (!hub.IsSCP())
				{
					return currentRole is SpectatorRole;
				}
				return true;
			}
			float range = PingProcessors[processorIndex].Range;
			float num = range * range;
			return (fpcStandardScp.FpcModule.Position - point).sqrMagnitude < num;
		}

		protected override void Start()
		{
			base.Start();
			_rateLimiter = new RateLimiter(_instantCooldown, _groupSize, _groupCooldown);
			_abilityName = Translations.Get(Scp079HudTranslation.PingLocation);
			_cooldownMsg = Translations.Get(Scp079HudTranslation.PingRateLimited);
		}

		protected override void Trigger()
		{
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			WriteSyncVars(writer);
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (!IsReady || !base.Role.TryGetOwner(out var _) || base.LostSignalHandler.Lost)
			{
				return;
			}
			_syncProcessorIndex = reader.ReadByte();
			if (_syncProcessorIndex >= PingProcessors.Length)
			{
				return;
			}
			_syncPos = reader.ReadRelativePosition();
			_syncNormal = reader.ReadVector3();
			Scp079PingingEventArgs e = new Scp079PingingEventArgs(base.Owner, _syncPos.Position, _syncNormal, _syncProcessorIndex);
			Scp079Events.OnPinging(e);
			if (e.IsAllowed)
			{
				_syncPos = new RelativePosition(e.Position);
				_syncNormal = e.Normal;
				_syncProcessorIndex = (byte)e.PingType;
				ServerSendRpc((ReferenceHub x) => ServerCheckReceiver(x, _syncPos.Position, _syncProcessorIndex));
				base.AuxManager.CurrentAux -= _cost;
				_rateLimiter.RegisterInput();
				Scp079Events.OnPinged(new Scp079PingedEventArgs(base.Owner, _syncPos.Position, _syncNormal, _syncProcessorIndex));
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			WriteSyncVars(writer);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			SpawnIndicator(reader.ReadByte(), reader.ReadRelativePosition(), reader.ReadVector3());
		}
	}
}

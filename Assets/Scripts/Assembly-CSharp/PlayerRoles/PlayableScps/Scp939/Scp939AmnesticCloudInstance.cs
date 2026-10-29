using System.Collections.Generic;
using System.Runtime.InteropServices;
using CustomPlayerEffects;
using Hazards;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using Mirror.RemoteCalls;
using PlayerRoles.PlayableScps.Subroutines;
using PlayerRoles.Subroutines;
using PlayerStatsSystem;
using RelativePositioning;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp939
{
	public class Scp939AmnesticCloudInstance : TemporaryHazard
	{
		public enum CloudState
		{
			Spawning = 0,
			Created = 1,
			Destroyed = 2
		}

		public static readonly List<Scp939AmnesticCloudInstance> ActiveInstances;

		private static readonly int HashRadiusPercent;

		private static readonly int HashStatusPercent;

		private readonly AbilityCooldown _overallCooldown = new AbilityCooldown();

		private readonly Dictionary<uint, AbilityCooldown> _individualCooldown = new Dictionary<uint, AbilityCooldown>();

		private Scp939AmnesticCloudAbility _cloud;

		private Scp939LungeAbility _lunge;

		private Scp939ClawAbility _claw;

		private Scp939Role _scpRole;

		private Transform _t;

		private Material _mat;

		private bool _abilitiesSet;

		private float _targetDuration;

		private float _lastHoldTime;

		private float _prevRange;

		private bool _localOwner;

		private bool _alreadyCreated;

		[SyncVar]
		private byte _syncHoldTime;

		[SyncVar]
		private byte _syncState;

		[SyncVar]
		private uint _syncOwner;

		[SyncVar]
		private RelativePosition _syncPos;

		[Header("Balance")]
		[SerializeField]
		private float _minHoldTime;

		[SerializeField]
		private float _maxHoldTime;

		[SerializeField]
		private AnimationCurve _rangeOverHeldTime;

		[SerializeField]
		private AnimationCurve _durationOverHeldTime;

		[SerializeField]
		private float _amnesiaDuration;

		[SerializeField]
		private float _pauseDuration;

		[Header("Audiovisual")]
		[SerializeField]
		private float _destroyTime;

		[SerializeField]
		private float _soundDropRate;

		[SerializeField]
		private float _sizeLerpTime;

		[SerializeField]
		private float _colorLerpTime;

		[SerializeField]
		private AudioSource _deploySound;

		[SerializeField]
		private AudioSource _chargeupSound;

		[SerializeField]
		private AnimationCurve _chargeupVolumeOverSize;

		[SerializeField]
		private DecalProjector _decalProjector;

		private float _decaySpeedOverride = -1f;

		public float NormalizedHoldTime => Mathf.Clamp01(_cloud.HoldDuration / _maxHoldTime);

		public ReferenceHub Owner
		{
			get
			{
				if (!ReferenceHub.TryGetHubNetID(_syncOwner, out var hub))
				{
					return null;
				}
				return hub;
			}
			set
			{
				Network_syncOwner = value.netId;
			}
		}

		public RelativePosition SyncedPosition
		{
			get
			{
				return _syncPos;
			}
			set
			{
				Network_syncPos = value;
			}
		}

		public byte HoldDuration
		{
			get
			{
				return _syncHoldTime;
			}
			set
			{
				Network_syncHoldTime = value;
			}
		}

		public float PauseDuration
		{
			get
			{
				return _pauseDuration;
			}
			set
			{
				_pauseDuration = value;
			}
		}

		public float AmnesiaDuration
		{
			get
			{
				return _amnesiaDuration;
			}
			set
			{
				_amnesiaDuration = value;
			}
		}

		public CloudState State
		{
			get
			{
				return (CloudState)_syncState;
			}
			set
			{
				Network_syncState = (byte)value;
			}
		}

		public override float HazardDuration
		{
			get
			{
				return _targetDuration;
			}
			set
			{
				_targetDuration = value;
			}
		}

		public override float DecaySpeed
		{
			get
			{
				if (_decaySpeedOverride >= 0f)
				{
					return _decaySpeedOverride;
				}
				if (State != CloudState.Created)
				{
					return 0f;
				}
				return 1f;
			}
			set
			{
				_decaySpeedOverride = value;
			}
		}

		public Vector2 MinMaxTime => new Vector2(_minHoldTime, _maxHoldTime);

		public byte Network_syncHoldTime
		{
			get
			{
				return _syncHoldTime;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _syncHoldTime, 1uL, null);
			}
		}

		public byte Network_syncState
		{
			get
			{
				return _syncState;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _syncState, 2uL, null);
			}
		}

		public uint Network_syncOwner
		{
			get
			{
				return _syncOwner;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _syncOwner, 4uL, null);
			}
		}

		public RelativePosition Network_syncPos
		{
			get
			{
				return _syncPos;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _syncPos, 8uL, null);
			}
		}

		[Server]
		public override void ServerDestroy()
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void PlayerRoles.PlayableScps.Scp939.Scp939AmnesticCloudInstance::ServerDestroy()' called when server was not active");
				return;
			}
			base.ServerDestroy();
			_abilitiesSet = false;
			State = CloudState.Destroyed;
		}

		public override bool OnEnter(ReferenceHub player)
		{
			if (!HitboxIdentity.IsEnemy(Team.SCPs, player.GetTeam()) || player.IsFlamingo())
			{
				return false;
			}
			if (!base.OnEnter(player))
			{
				return false;
			}
			PlayerEvents.OnEnteredHazard(new PlayerEnteredHazardEventArgs(player, this));
			return true;
		}

		public override void OnStay(ReferenceHub player)
		{
			base.OnStay(player);
			if (State == CloudState.Created && IsActive && _overallCooldown.IsReady && (!_individualCooldown.TryGetValue(player.netId, out var value) || value.IsReady))
			{
				PlayerEffectsController playerEffectsController = player.playerEffectsController;
				if (!playerEffectsController.TryGetEffect<Invigorated>(out var playerEffect) || !playerEffect.IsEnabled)
				{
					playerEffectsController.EnableEffect<AmnesiaVision>(_amnesiaDuration);
				}
			}
		}

		public override bool OnExit(ReferenceHub player)
		{
			if (!base.OnExit(player))
			{
				return false;
			}
			PlayerEvents.OnLeftHazard(new PlayerLeftHazardEventArgs(player, this));
			return true;
		}

		public void PauseAll()
		{
			foreach (ReferenceHub affectedPlayer in base.AffectedPlayers)
			{
				if (!affectedPlayer.playerEffectsController.TryGetEffect<AmnesiaVision>(out var playerEffect))
				{
					return;
				}
				playerEffect.IsEnabled = false;
			}
			_overallCooldown.Trigger(_pauseDuration);
		}

		protected override void Start()
		{
			_t = base.transform;
			_mat = new Material(_decalProjector.material);
			_decalProjector.material = _mat;
			ActiveInstances.Add(this);
			if (ReferenceHub.TryGetHubNetID(_syncOwner, out var hub) && hub.isLocalPlayer)
			{
				_localOwner = true;
				SetAbilityCache();
			}
			if (Owner == null || (ReferenceHub.TryGetPovHub(out var hub2) && !(hub2.roleManager.CurrentRole is Scp939Role)))
			{
				_chargeupSound.mute = true;
			}
			ClientApplyDecalSize();
			base.Start();
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			ActiveInstances.Remove(this);
			PlayerStats.OnAnyPlayerDamaged -= OnAnyPlayerDamaged;
			if (_lunge != null)
			{
				_lunge.OnStateChanged -= OnLungeStateChanged;
			}
			if (_claw != null)
			{
				_claw.OnAttacked -= OnAttacked;
			}
		}

		protected override void Update()
		{
			base.Update();
			if (_localOwner)
			{
				UpdateLocal();
			}
			else
			{
				UpdateVisuals((float)(int)_syncHoldTime / 255f, Time.deltaTime * _sizeLerpTime);
			}
			if (NetworkServer.active)
			{
				switch (State)
				{
				case CloudState.Spawning:
					ServerUpdateSpawning();
					break;
				case CloudState.Destroyed:
					ServerUpdateDestroyed();
					break;
				}
			}
		}

		private void TryGetPlayer(out bool is939, out bool isOwner)
		{
			is939 = false;
			isOwner = false;
			if (ReferenceHub.TryGetPovHub(out var hub))
			{
				is939 = hub.roleManager.CurrentRole is Scp939Role;
				isOwner = hub.netId == _syncOwner;
			}
		}

		private void OnAttacked(AttackResult attackResult)
		{
			if (attackResult != AttackResult.None)
			{
				PauseAll();
			}
		}

		private void OnAnyPlayerDamaged(ReferenceHub hub, DamageHandlerBase dhb)
		{
			if (hub.netId == _syncOwner && dhb is AttackerDamageHandler attackerDamageHandler)
			{
				AbilityCooldown abilityCooldown = new AbilityCooldown();
				abilityCooldown.Trigger(_pauseDuration);
				uint attackerId = attackerDamageHandler.Attacker.NetId;
				_individualCooldown[attackerId] = abilityCooldown;
				if (base.AffectedPlayers.TryGetFirst((ReferenceHub x) => x.netId == attackerId, out var first) && first.playerEffectsController.TryGetEffect<AmnesiaVision>(out var playerEffect))
				{
					playerEffect.IsEnabled = false;
				}
			}
		}

		private void OnLungeStateChanged(Scp939LungeState state)
		{
			if (state == Scp939LungeState.LandHit)
			{
				PauseAll();
			}
		}

		private void SetAbilityCache()
		{
			_abilitiesSet = false;
			if (ReferenceHub.TryGetHubNetID(_syncOwner, out var hub) && hub.roleManager.CurrentRole is Scp939Role scpRole)
			{
				_scpRole = scpRole;
				_abilitiesSet = _scpRole.SubroutineModule.TryGetSubroutine<Scp939AmnesticCloudAbility>(out _cloud) && _scpRole.SubroutineModule.TryGetSubroutine<Scp939LungeAbility>(out _lunge) && _scpRole.SubroutineModule.TryGetSubroutine<Scp939ClawAbility>(out _claw);
			}
		}

		private void RefreshPosition(ReferenceHub owner)
		{
			_t.position = owner.PlayerCameraReference.position;
		}

		private void UpdateLocal()
		{
			if (_abilitiesSet && ReferenceHub.TryGetLocalHub(out var hub))
			{
				switch (State)
				{
				case CloudState.Destroyed:
					_cloud.ClientCancel(Scp939HudTranslation.CloudFailedSizeInsufficient);
					break;
				case CloudState.Created:
					_cloud.ClientCancel(Scp939HudTranslation.PressKeyToLunge);
					break;
				}
				if (!_cloud.ValidateFloor())
				{
					_cloud.ClientCancel((_cloud.HoldDuration < _minHoldTime) ? Scp939HudTranslation.CloudFailedSizeInsufficient : Scp939HudTranslation.PressKeyToLunge);
				}
				if (_cloud.TargetState)
				{
					UpdateVisuals(NormalizedHoldTime, 1f);
					RefreshPosition(hub);
				}
				else if (State != CloudState.Spawning)
				{
					_localOwner = false;
				}
			}
		}

		private void UpdateVisuals(float normalizedSize, float lerpTime)
		{
			_deploySound.mute = ReferenceHub.TryGetPovHub(out var hub) && HitboxIdentity.IsEnemy(Team.SCPs, hub.GetTeam());
			TryGetPlayer(out var @is, out var isOwner);
			_decalProjector.enabled = @is;
			_t.position = _syncPos.Position;
			UpdateFade(State != CloudState.Destroyed);
			UpdateRadius(normalizedSize, lerpTime);
			UpdateChargeup(normalizedSize, isOwner);
		}

		private void UpdateChargeup(float normalizedSize, bool isOwner)
		{
			_chargeupSound.mute = !isOwner;
			if (State == CloudState.Spawning)
			{
				_chargeupSound.volume = _chargeupVolumeOverSize.Evaluate(normalizedSize);
			}
			else
			{
				_chargeupSound.volume -= Time.deltaTime;
			}
		}

		private void UpdateFade(bool isVisible)
		{
			float b = (isVisible ? 1 : 0);
			DecalProjector decalProjector = _decalProjector;
			decalProjector.fadeFactor = Mathf.Lerp(t: Time.deltaTime * _colorLerpTime, a: decalProjector.fadeFactor, b: b);
		}

		private void UpdateRadius(float normSize, float lerpTime)
		{
			float time = normSize * _maxHoldTime;
			_prevRange = Mathf.Lerp(_prevRange, _rangeOverHeldTime.Evaluate(time), lerpTime);
			_mat.SetFloat(HashRadiusPercent, _prevRange * 2f / _decalProjector.size.x);
			if (State == CloudState.Created)
			{
				float a = _mat.GetFloat(HashStatusPercent);
				float t = Time.deltaTime * _colorLerpTime;
				float value = Mathf.Lerp(a, 1f, t);
				_mat.SetFloat(HashStatusPercent, value);
			}
		}

		private void ClientApplyDecalSize()
		{
			_decalProjector.size = Vector3.Scale(_decalProjector.size, base.transform.localScale);
			base.transform.localScale = Vector3.one;
		}

		[Server]
		private void ServerUpdateSpawning()
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void PlayerRoles.PlayableScps.Scp939.Scp939AmnesticCloudInstance::ServerUpdateSpawning()' called when server was not active");
				return;
			}
			if (!_abilitiesSet || !ReferenceHub.TryGetHubNetID(_syncOwner, out var hub) || _scpRole == null || _scpRole.Pooled)
			{
				ServerDestroy();
				return;
			}
			RefreshPosition(hub);
			Network_syncPos = new RelativePosition(_t.position);
			if (_cloud.TargetState)
			{
				_lastHoldTime = _cloud.HoldDuration;
				Network_syncHoldTime = (byte)Mathf.RoundToInt(NormalizedHoldTime * 255f);
				if (_lastHoldTime < _maxHoldTime)
				{
					return;
				}
			}
			if (_lastHoldTime < _minHoldTime && !_cloud.Cooldown.IsReady)
			{
				_cloud.ServerFailPlacement();
				ServerDestroy();
				return;
			}
			_targetDuration = _durationOverHeldTime.Evaluate(_lastHoldTime);
			_cloud.ServerConfirmPlacement(_targetDuration);
			MaxDistance = _rangeOverHeldTime.Evaluate(_lastHoldTime);
			State = CloudState.Created;
			RpcPlayCreateSound();
		}

		[Server]
		private void ServerUpdateDestroyed()
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void PlayerRoles.PlayableScps.Scp939.Scp939AmnesticCloudInstance::ServerUpdateDestroyed()' called when server was not active");
				return;
			}
			_destroyTime -= Time.deltaTime;
			if (!(_destroyTime > 0f))
			{
				NetworkServer.Destroy(base.gameObject);
			}
		}

		[ClientRpc]
		private void RpcPlayCreateSound()
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			SendRPCInternal("System.Void PlayerRoles.PlayableScps.Scp939.Scp939AmnesticCloudInstance::RpcPlayCreateSound()", -193115792, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		[Server]
		public void ServerSetup(ReferenceHub owner)
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void PlayerRoles.PlayableScps.Scp939.Scp939AmnesticCloudInstance::ServerSetup(ReferenceHub)' called when server was not active");
				return;
			}
			Network_syncOwner = owner.netId;
			SetAbilityCache();
			_lunge.OnStateChanged += OnLungeStateChanged;
			PlayerStats.OnAnyPlayerDamaged += OnAnyPlayerDamaged;
			_claw.OnAttacked += OnAttacked;
		}

		static Scp939AmnesticCloudInstance()
		{
			ActiveInstances = new List<Scp939AmnesticCloudInstance>();
			HashRadiusPercent = Shader.PropertyToID("_RadiusPercent");
			HashStatusPercent = Shader.PropertyToID("_StatusPercent");
			RemoteProcedureCalls.RegisterRpc(typeof(Scp939AmnesticCloudInstance), "System.Void PlayerRoles.PlayableScps.Scp939.Scp939AmnesticCloudInstance::RpcPlayCreateSound()", InvokeUserCode_RpcPlayCreateSound);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcPlayCreateSound()
		{
			if (!_alreadyCreated)
			{
				_deploySound.Play();
				if (ReferenceHub.TryGetHubNetID(_syncOwner, out var hub) && hub.roleManager.CurrentRole is Scp939Role scp939Role && scp939Role.FpcModule.CharacterModelInstance is Scp939Model scp939Model)
				{
					_alreadyCreated = true;
					scp939Model.PlayCloudRelease();
				}
			}
		}

		protected static void InvokeUserCode_RpcPlayCreateSound(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcPlayCreateSound called on server.");
			}
			else
			{
				((Scp939AmnesticCloudInstance)obj).UserCode_RpcPlayCreateSound();
			}
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				NetworkWriterExtensions.WriteByte(writer, _syncHoldTime);
				NetworkWriterExtensions.WriteByte(writer, _syncState);
				writer.WriteUInt(_syncOwner);
				writer.WriteRelativePosition(_syncPos);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				NetworkWriterExtensions.WriteByte(writer, _syncHoldTime);
			}
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				NetworkWriterExtensions.WriteByte(writer, _syncState);
			}
			if ((base.syncVarDirtyBits & 4L) != 0L)
			{
				writer.WriteUInt(_syncOwner);
			}
			if ((base.syncVarDirtyBits & 8L) != 0L)
			{
				writer.WriteRelativePosition(_syncPos);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _syncHoldTime, null, NetworkReaderExtensions.ReadByte(reader));
				GeneratedSyncVarDeserialize(ref _syncState, null, NetworkReaderExtensions.ReadByte(reader));
				GeneratedSyncVarDeserialize(ref _syncOwner, null, reader.ReadUInt());
				GeneratedSyncVarDeserialize(ref _syncPos, null, reader.ReadRelativePosition());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _syncHoldTime, null, NetworkReaderExtensions.ReadByte(reader));
			}
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _syncState, null, NetworkReaderExtensions.ReadByte(reader));
			}
			if ((num & 4L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _syncOwner, null, reader.ReadUInt());
			}
			if ((num & 8L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _syncPos, null, reader.ReadRelativePosition());
			}
		}
	}
}

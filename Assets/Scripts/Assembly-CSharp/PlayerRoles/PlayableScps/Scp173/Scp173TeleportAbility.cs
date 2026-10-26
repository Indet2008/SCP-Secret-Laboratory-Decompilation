using System;
using System.Collections.Generic;
using LabApi.Events.Arguments.Scp173Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Spectating;
using PlayerRoles.Subroutines;
using RelativePositioning;
using UnityEngine;
using UnityEngine.Rendering;
using Utils.Networking;

namespace PlayerRoles.PlayableScps.Scp173
{
	public class Scp173TeleportAbility : KeySubroutine<Scp173Role>
	{
		[Flags]
		private enum CmdTeleportData
		{
			Aiming = 1,
			WantsToTeleport = 2
		}

		public const float BlinkDistance = 8f;

		private const float BreakneckDistanceMultiplier = 1.8f;

		private const float KillRadiusSqr = 1.66f;

		private const float KillHeight = 2.2f;

		private const float KillBacktracking = 0.4f;

		private const float ClientDistanceAddition = 0.1f;

		private const int GlassLayerMask = 16384;

		private const float GlassDestroyRadius = 0.8f;

		private static readonly Collider[] DetectedColliders = new Collider[8];

		private Scp173MovementModule _fpcModule;

		private Scp173ObserversTracker _observersTracker;

		private Scp173BreakneckSpeedsAbility _breakneckSpeedsAbility;

		private Scp173BlinkTimer _blinkTimer;

		private Scp173AudioPlayer _audioSubroutine;

		private bool _isAiming;

		private float _targetDis;

		private Vector3 _tpPosition;

		private float _lastBlink;

		private CmdTeleportData _cmdData;

		[SerializeField]
		private Scp173TeleportIndicator _tpIndicator;

		[SerializeField]
		private AnimationCurve _blinkIntensity;

		[SerializeField]
		private Volume _blinkEffect;

		private float EffectiveBlinkDistance => 8f * (_breakneckSpeedsAbility.IsActive ? 1.8f : 1f);

		protected override ActionName TargetKey => ActionName.Zoom;

		public ReferenceHub BestTarget
		{
			get
			{
				ReferenceHub result = null;
				float num = float.MaxValue;
				foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
				{
					if (!HitboxIdentity.IsEnemy(base.Owner, allHub) || !(allHub.roleManager.CurrentRole is IFpcRole fpcRole))
					{
						continue;
					}
					Vector3 position = fpcRole.FpcModule.Position;
					Vector3 tpPosition = _tpPosition;
					if ((position - tpPosition).MagnitudeOnlyY() < 2.2f)
					{
						position.y = 0f;
						tpPosition.y = 0f;
					}
					float sqrMagnitude = (position - tpPosition).sqrMagnitude;
					if (!(sqrMagnitude > num))
					{
						if (Physics.Linecast(tpPosition, position, PlayerRolesUtils.AttackMask))
						{
							num = Mathf.Min(sqrMagnitude, 1.66f);
							continue;
						}
						num = sqrMagnitude;
						result = allHub;
					}
				}
				if (!(num > 1.66f))
				{
					return result;
				}
				return null;
			}
		}

		protected override void Awake()
		{
			base.Awake();
			_fpcModule = base.CastRole.FpcModule as Scp173MovementModule;
			SubroutineManagerModule subroutineModule = base.CastRole.SubroutineModule;
			subroutineModule.TryGetSubroutine<Scp173ObserversTracker>(out _observersTracker);
			subroutineModule.TryGetSubroutine<Scp173BreakneckSpeedsAbility>(out _breakneckSpeedsAbility);
			subroutineModule.TryGetSubroutine<Scp173AudioPlayer>(out _audioSubroutine);
			subroutineModule.TryGetSubroutine<Scp173BlinkTimer>(out _blinkTimer);
		}

		protected override void Update()
		{
			base.Update();
			if (!base.Role.IsControllable && !base.Owner.IsLocallySpectated())
			{
				if (_isAiming)
				{
					_isAiming = false;
					_tpIndicator.UpdateVisibility(isVisible: false);
				}
				return;
			}
			bool flag = IsKeyHeld && (!Cursor.visible || base.Role.IsEmulatedDummy);
			bool flag2 = (base.Role.IsControllable ? flag : HasDataFlag(CmdTeleportData.Aiming));
			if (_isAiming)
			{
				UpdateAiming(!flag2);
			}
			else if (flag2)
			{
				_isAiming = true;
			}
		}

		private void UpdateAiming(bool wantsToTeleport)
		{
			bool flag = _fpcModule.TryGetTeleportPos(EffectiveBlinkDistance, out _tpPosition, out _targetDis);
			if (!wantsToTeleport)
			{
				_tpIndicator.UpdateVisibility(flag && _blinkTimer.AbilityReady);
				_tpIndicator.transform.position = _tpPosition;
				if (!HasDataFlag(CmdTeleportData.Aiming))
				{
					_cmdData = CmdTeleportData.Aiming;
					ClientSendCmd();
				}
			}
			else
			{
				if (base.Role.IsControllable)
				{
					_cmdData = ((!flag) ? CmdTeleportData.Aiming : CmdTeleportData.WantsToTeleport);
					ClientSendCmd();
				}
				_isAiming = false;
				_tpIndicator.UpdateVisibility(isVisible: false);
			}
		}

		private bool TryBlink(float maxDis)
		{
			maxDis = Mathf.Clamp(maxDis, 0f, EffectiveBlinkDistance);
			if (!_blinkTimer.AbilityReady)
			{
				return false;
			}
			if (!_fpcModule.TryGetTeleportPos(maxDis, out _tpPosition, out var _))
			{
				return false;
			}
			Scp173TeleportingEventArgs e = new Scp173TeleportingEventArgs(base.Owner, _tpPosition);
			Scp173Events.OnTeleporting(e);
			if (!e.IsAllowed)
			{
				return false;
			}
			_tpPosition = e.Position;
			float num = _fpcModule.CharController.height / 2f;
			_blinkTimer.ServerBlink(_tpPosition + Vector3.up * num);
			Scp173Events.OnTeleported(new Scp173TeleportedEventArgs(base.Owner, _tpPosition));
			return true;
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			base.ClientWriteCmd(writer);
			writer.WriteByte((byte)_cmdData);
			if (HasDataFlag(CmdTeleportData.WantsToTeleport))
			{
				writer.WriteQuaternion(base.Owner.PlayerCameraReference.rotation);
				writer.WriteFloat(_targetDis + 0.1f);
				writer.WriteReferenceHub(BestTarget);
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			_cmdData = (CmdTeleportData)reader.ReadByte();
			if (!HasDataFlag(CmdTeleportData.WantsToTeleport))
			{
				ServerSendRpc(toAll: true);
			}
			else
			{
				if (!_blinkTimer.AbilityReady)
				{
					return;
				}
				Transform playerCameraReference = base.Owner.PlayerCameraReference;
				HashSet<ReferenceHub> prevObservers = new HashSet<ReferenceHub>(_observersTracker.Observers);
				CmdTeleportData cmdData = _cmdData;
				_cmdData = (CmdTeleportData)0;
				ServerSendRpc(toAll: true);
				_cmdData = cmdData;
				Quaternion rotation = playerCameraReference.rotation;
				playerCameraReference.rotation = reader.ReadQuaternion();
				bool num = TryBlink(reader.ReadFloat());
				playerCameraReference.rotation = rotation;
				if (!num)
				{
					return;
				}
				prevObservers.UnionWith(_observersTracker.Observers);
				ServerSendRpc((ReferenceHub x) => prevObservers.Contains(x));
				_audioSubroutine.ServerSendSound(Scp173AudioPlayer.Scp173SoundId.Teleport);
				if (_breakneckSpeedsAbility.IsActive)
				{
					return;
				}
				int num2 = Physics.OverlapSphereNonAlloc(_fpcModule.Position, 0.8f, DetectedColliders, 16384);
				for (int num3 = 0; num3 < num2; num3++)
				{
					if (DetectedColliders[num3].TryGetComponent<BreakableWindow>(out var component))
					{
						component.Damage(component.Health, base.CastRole.DamageHandler, Vector3.zero);
					}
				}
				ReferenceHub referenceHub = reader.ReadReferenceHub();
				if (!(referenceHub == null) && HitboxIdentity.IsEnemy(base.Owner, referenceHub) && referenceHub.roleManager.CurrentRole is IFpcRole fpcRole)
				{
					Bounds bounds = fpcRole.FpcModule.Tracer.GenerateBounds(0.4f, ignoreTeleports: true);
					Vector3 position = fpcRole.FpcModule.Position;
					bounds.Encapsulate(new Bounds(position, Vector3.up * 2.2f));
					if (!(bounds.SqrDistance(_fpcModule.Position) > 1.66f) && !Physics.Linecast(_tpPosition, position, PlayerRolesUtils.AttackMask) && referenceHub.playerStats.DealDamage(base.CastRole.DamageHandler) && base.CastRole.SubroutineModule.TryGetSubroutine<Scp173AudioPlayer>(out var subroutine))
					{
						Hitmarker.SendHitmarkerDirectly(base.Owner, 1f);
						subroutine.ServerSendSound(Scp173AudioPlayer.Scp173SoundId.Snap);
					}
				}
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteByte((byte)_cmdData);
			if (HasDataFlag(CmdTeleportData.WantsToTeleport))
			{
				writer.WriteRelativePosition(new RelativePosition(_fpcModule.Position));
			}
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			_cmdData = (CmdTeleportData)reader.ReadByte();
			if (HasDataFlag(CmdTeleportData.WantsToTeleport))
			{
				RelativePosition receivedPosition = reader.ReadRelativePosition();
				_fpcModule.Motor.ReceivedPosition = receivedPosition;
				_fpcModule.Position = receivedPosition.Position;
				_lastBlink = Time.timeSinceLevelLoad;
				_blinkEffect.weight = 1f;
				(_fpcModule.CharacterModelInstance as Scp173CharacterModel).Frozen = false;
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_lastBlink = 0f;
		}

		private bool HasDataFlag(CmdTeleportData ctd)
		{
			return (_cmdData & ctd) == ctd;
		}
	}
}

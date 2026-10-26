using System.Runtime.InteropServices;
using GameCore;
using Mirror;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace PlayerRoles.PlayableScps.HumanTracker
{
	public class LastHumanTracker : NetworkBehaviour
	{
		private const float VisibleTime = 5f;

		private const float InvisibleTime = 4f;

		private const float DistanceLimit = 100f;

		private const float AccurateTrackingDistanceThld = 20f;

		private static LastHumanTracker _singleton;

		private static bool _singletonSet;

		[SerializeField]
		private ParticleSystem _orbParticleSystem;

		[SyncVar]
		private Vector3? _lastTargetPos;

		[SyncVar]
		private uint _lastTargetNetId;

		private float _markerPulseTimer;

		private bool _enableEmissions;

		private ParticleSystem.MinMaxCurve _defaultRateOverTime;

		private ParticleSystem.MinMaxCurve _defaultRateOverDistance;

		public static bool IsLocalLastTarget
		{
			get
			{
				if (_singletonSet)
				{
					return _singleton.IsPOVHubLastTarget;
				}
				return false;
			}
		}

		public static bool IsOneTargetLeft
		{
			get
			{
				if (!_singletonSet)
				{
					return false;
				}
				if (!_singleton._lastTargetPos.HasValue)
				{
					return false;
				}
				ReferenceHub hub;
				return ReferenceHub.TryGetHubNetID(_singleton._lastTargetNetId, out hub);
			}
		}

		private bool IsPOVHubLastTarget
		{
			get
			{
				if (!_lastTargetPos.HasValue)
				{
					return false;
				}
				if (!ReferenceHub.TryGetPovHub(out var hub))
				{
					return false;
				}
				if (hub.netId != _lastTargetNetId)
				{
					return false;
				}
				return true;
			}
		}

		public Vector3? Network_lastTargetPos
		{
			get
			{
				return _lastTargetPos;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _lastTargetPos, 1uL, null);
			}
		}

		public uint Network_lastTargetNetId
		{
			get
			{
				return _lastTargetNetId;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _lastTargetNetId, 2uL, null);
			}
		}

		public static bool IsLastTarget(ReferenceHub target)
		{
			if (!_singletonSet)
			{
				return false;
			}
			if (target == null)
			{
				return false;
			}
			return target.netId == _singleton._lastTargetNetId;
		}

		private void Awake()
		{
			_singleton = this;
			_singletonSet = true;
			_defaultRateOverTime = _orbParticleSystem.emission.rateOverTime;
			_defaultRateOverDistance = _orbParticleSystem.emission.rateOverDistance;
			ClientUpdateEmissions();
		}

		private void OnDestroy()
		{
			_singletonSet = false;
		}

		private void LateUpdate()
		{
			if (RoundStart.RoundStarted)
			{
				if (NetworkServer.active)
				{
					ServerUpdateLastHumanTracking();
				}
				ClientUpdateTracking();
				ClientUpdateEmissions();
			}
		}

		private void ServerUpdateLastHumanTracking()
		{
			if (!TryGetLastTarget(out var lastTarget))
			{
				Network_lastTargetNetId = 0u;
				Network_lastTargetPos = null;
			}
			else
			{
				Network_lastTargetPos = lastTarget.GetPosition();
				Network_lastTargetNetId = lastTarget.netId;
			}
		}

		private void ClientUpdateTracking()
		{
			if (!_lastTargetPos.HasValue || !ReferenceHub.TryGetHubNetID(_lastTargetNetId, out var hub))
			{
				_markerPulseTimer = 0f;
				_enableEmissions = false;
				return;
			}
			_markerPulseTimer += Time.deltaTime;
			if (_markerPulseTimer > 5f)
			{
				_enableEmissions = false;
			}
			if (_markerPulseTimer > 9f)
			{
				_markerPulseTimer = 0f;
				_enableEmissions = true;
			}
			if (!ReferenceHub.TryGetPovHub(out var hub2) || !hub2.IsSCP())
			{
				_enableEmissions = false;
				return;
			}
			float sqrMagnitude = (MainCameraController.LastPosition - _lastTargetPos.Value).sqrMagnitude;
			if (sqrMagnitude > 10000f)
			{
				_enableEmissions = false;
			}
			else if (_enableEmissions)
			{
				bool flag = sqrMagnitude < 400f;
				_orbParticleSystem.transform.position = (flag ? hub.GetPosition() : _lastTargetPos.Value);
			}
		}

		private void ClientUpdateEmissions()
		{
			ParticleSystem.EmissionModule emission = _orbParticleSystem.emission;
			emission.rateOverTime = (_enableEmissions ? _defaultRateOverTime : ((ParticleSystem.MinMaxCurve)0f));
			emission.rateOverDistance = (_enableEmissions ? _defaultRateOverDistance : ((ParticleSystem.MinMaxCurve)0f));
		}

		private static bool TryGetLastTarget(out ReferenceHub lastTarget)
		{
			lastTarget = null;
			int num = 0;
			int num2 = 0;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.IsHuman())
				{
					num++;
					lastTarget = allHub;
				}
				else if (allHub.IsSCP())
				{
					num2++;
				}
			}
			if (num == 1)
			{
				return num2 > 0;
			}
			return false;
		}

		public override bool Weaved()
		{
			return true;
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteVector3Nullable(_lastTargetPos);
				writer.WriteUInt(_lastTargetNetId);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WriteVector3Nullable(_lastTargetPos);
			}
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				writer.WriteUInt(_lastTargetNetId);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _lastTargetPos, null, reader.ReadVector3Nullable());
				GeneratedSyncVarDeserialize(ref _lastTargetNetId, null, reader.ReadUInt());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _lastTargetPos, null, reader.ReadVector3Nullable());
			}
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _lastTargetNetId, null, reader.ReadUInt());
			}
		}
	}
}

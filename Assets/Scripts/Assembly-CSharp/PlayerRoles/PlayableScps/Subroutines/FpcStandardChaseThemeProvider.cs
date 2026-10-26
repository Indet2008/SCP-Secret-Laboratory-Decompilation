using System.Collections.Generic;
using AudioPooling;
using CustomRendering;
using FacilitySoundtrack.ChaseThemes;
using GameObjectPools;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Subroutines
{
	public abstract class FpcStandardChaseThemeProvider<T> : SubroutineBase, IChaseThemeProvider, IPoolResettable where T : FpcStandardScp
	{
		private enum LosResult
		{
			Direct = 0,
			OutsideFov = 1,
			None = 2
		}

		private readonly List<ModelReferencePoint> _lineOfSightPointsCache = new List<ModelReferencePoint>();

		private bool _lineOfSightPointsCacheSet;

		private float _remainingHold;

		private int _losRaycastClock;

		private const float FogDistanceScale = 0.9f;

		private const float FarAwayThld = 35f;

		private const int MaxLosRaycastsPerFrame = 2;

		public List<DesiredChaseClip> ClipsToPlay { get; private set; } = new List<DesiredChaseClip>();

		public virtual float DominanceScale => GetDominanceFromDistance();

		public virtual int Priority => 0;

		protected virtual float InitialHoldSeconds => 5f;

		protected virtual float RefreshHoldSeconds => 4f;

		protected virtual float LosHoldCountdownSpeed => 0.35f;

		protected virtual float FarAwayHoldCountdownSpeed => 4.5f;

		protected T ScpRole { get; private set; }

		protected override void Awake()
		{
			base.Awake();
			ScpRole = base.Role as T;
		}

		public void ResetObject()
		{
			_lineOfSightPointsCacheSet = false;
		}

		public virtual AudioPoolSession? OnChaseStarted(List<AudioPoolSession> alreadyPlayedStingers)
		{
			_remainingHold = InitialHoldSeconds;
			return null;
		}

		public virtual void OnChaseStopped()
		{
		}

		public virtual bool TryStartChase()
		{
			float num = FogController.FogFarPlaneDistance * 0.9f;
			float num2 = num * num;
			Vector3 lastPosition = MainCameraController.LastPosition;
			if (ScpRole.SqrDistanceTo(lastPosition) > num2)
			{
				return false;
			}
			if (!ReferenceHub.TryGetLocalHub(out var hub))
			{
				return false;
			}
			Vector3 position = ScpRole.FpcModule.Position;
			if (GetLineOfSight(hub, position) == LosResult.Direct)
			{
				return true;
			}
			if (!_lineOfSightPointsCacheSet)
			{
				ScpRole.FpcModule.CharacterModelInstance.GetHardpointsOfType(RefpointType.LineOfSightPoint, _lineOfSightPointsCache);
				_lineOfSightPointsCacheSet = true;
			}
			int count = _lineOfSightPointsCache.Count;
			int num3 = Mathf.Min(count, 2);
			for (int i = 0; i < num3; i++)
			{
				_losRaycastClock = (_losRaycastClock + 1) % count;
				Vector3 position2 = _lineOfSightPointsCache[i].FastTr.position;
				if (GetLineOfSight(hub, position2) == LosResult.Direct && !Physics.Linecast(lastPosition, position, VisionInformation.VisionLayerMask))
				{
					return true;
				}
			}
			return false;
		}

		public virtual bool UpdateChase()
		{
			if (!ReferenceHub.TryGetLocalHub(out var hub))
			{
				return false;
			}
			float num = 1f;
			if (TryStartChase())
			{
				num = 0f;
				_remainingHold = Mathf.Max(_remainingHold, RefreshHoldSeconds);
			}
			else
			{
				Vector3 position = ScpRole.FpcModule.Position;
				if ((MainCameraController.LastPosition - position).sqrMagnitude > 1225f)
				{
					num = FarAwayHoldCountdownSpeed;
				}
				else if (GetLineOfSight(hub, position) != LosResult.None)
				{
					num = LosHoldCountdownSpeed;
				}
			}
			_remainingHold -= Time.deltaTime * num;
			return _remainingHold > 0f;
		}

		protected float GetPerceivedJumpscareDistance()
		{
			Vector3 position = ScpRole.FpcModule.Position;
			Vector3 vector = MainCameraController.LastPosition - position;
			float magnitude = vector.magnitude;
			if (magnitude < 3f || !base.Role.TryGetOwner(out var hub))
			{
				return magnitude;
			}
			float value = Vector3.Dot(vector / magnitude, hub.PlayerCameraReference.forward);
			float t = Mathf.InverseLerp(0.2f, -0.4f, value);
			float num = Mathf.Lerp(1f, 2f, t);
			return magnitude * num;
		}

		protected float GetDominanceFromDistance()
		{
			float num = ScpRole.SqrDistanceTo(MainCameraController.LastPosition);
			return Mathf.Clamp(800f / (num + 700f), 0.4f, 1f);
		}

		protected static AudioPoolSession PlayStinger(AudioClip clip)
		{
			return new AudioPoolSession(AudioSourcePoolManager.Play2D(clip, 1f, MixerChannel.NoDucking));
		}

		private static LosResult GetLineOfSight(ReferenceHub lhub, Vector3 endPoint)
		{
			if (Physics.Linecast(MainCameraController.LastPosition, endPoint, VisionInformation.VisionLayerMask))
			{
				return LosResult.None;
			}
			if (!VisionInformation.TargetInViewDirection(lhub, endPoint, 0f, out var _))
			{
				return LosResult.OutsideFov;
			}
			return LosResult.Direct;
		}
	}
}

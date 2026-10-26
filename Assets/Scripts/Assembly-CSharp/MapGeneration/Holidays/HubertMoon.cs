using System.Runtime.InteropServices;
using CustomPlayerEffects;
using Footprinting;
using Mirror;
using PlayerRoles;
using UnityEngine;
using Utils;

namespace MapGeneration.Holidays
{
	public class HubertMoon : NetworkBehaviour
	{
		private const float DefaultHeight = 690f;

		private const float TargetHeight = 362f;

		private const float ExplosionHeight = 390f;

		private const float EventRoundDuration = 1800f;

		private const float WarheadWaitTime = 110f;

		private const float BombardmentWaitTime = 114f;

		private const float ExplosionWaitTime = 139f;

		private const float ExplosionDelay = 1.25f;

		private const int MaxExplosionsPerLoop = 6;

		[Range(1f, 30f)]
		public float AnimSpeedMult = 1f;

		[SyncVar]
		private float _elapsedMovementTime;

		private Transform _cachedTransform;

		private float _endingSequenceTimer;

		private float _explosionTimer;

		private float _startHeight;

		private static float ExplosionOffset
		{
			get
			{
				float num = Random.Range(5f, 14f);
				if (!(Random.value > 0.5f))
				{
					return num;
				}
				return 0f - num;
			}
		}

		public float Network_elapsedMovementTime
		{
			get
			{
				return _elapsedMovementTime;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _elapsedMovementTime, 1uL, null);
			}
		}

		private void Awake()
		{
			_cachedTransform = base.transform;
			_cachedTransform.position = new Vector3(0f, 690f, 0f);
		}

		private void Start()
		{
			_endingSequenceTimer = 0f;
			Network_elapsedMovementTime = 0f;
			_startHeight = _cachedTransform.localPosition.y;
		}

		private void Update()
		{
			if (RoundSummary.RoundInProgress())
			{
				if (NetworkServer.active)
				{
					ServerVerifyEnding();
				}
				UpdateHeight();
				ClientUpdatePosition();
			}
		}

		private void ServerVerifyEnding()
		{
			if (!(_cachedTransform.localPosition.y >= 390f))
			{
				ServerExplodeFacility();
			}
		}

		private void ServerExplodeFacility()
		{
			if (_endingSequenceTimer <= 0f)
			{
				DeadmanSwitch.InitiateProtocol();
			}
			_endingSequenceTimer += Time.deltaTime;
			if (_endingSequenceTimer <= 110f)
			{
				return;
			}
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.IsAlive())
				{
					allHub.playerEffectsController.EnableEffect<SoundtrackMute>();
				}
			}
			if (!(_endingSequenceTimer <= 114f))
			{
				ServerExplodePlayers();
			}
		}

		private void ServerExplodePlayers()
		{
			if (_explosionTimer > Time.time)
			{
				return;
			}
			_explosionTimer = Time.time + 1.25f;
			bool flag = _endingSequenceTimer >= 139f;
			int num = 0;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.IsAlive())
				{
					Vector3 position = allHub.transform.position;
					if (flag || allHub.IsSCP())
					{
						ExplosionUtils.ServerExplode(allHub, ExplosionType.PinkCandy);
					}
					else
					{
						float x = position.x + ExplosionOffset;
						float z = position.z + ExplosionOffset;
						position.x = x;
						position.z = z;
						ExplosionUtils.ServerExplode(position, new Footprint(allHub), ExplosionType.PinkCandy);
					}
					if (num++ >= 6)
					{
						break;
					}
				}
			}
		}

		private void UpdateHeight()
		{
			if (NetworkServer.active)
			{
				Network_elapsedMovementTime = _elapsedMovementTime + Time.deltaTime * AnimSpeedMult;
			}
			Vector3 position = _cachedTransform.position;
			float t = Mathf.Clamp01(_elapsedMovementTime / 1800f);
			float y = Mathf.Lerp(_startHeight, 362f, t);
			_cachedTransform.localPosition = new Vector3(position.x, y, position.z);
		}

		private void ClientUpdatePosition()
		{
			if (ReferenceHub.TryGetLocalHub(out var hub))
			{
				Vector3 position = hub.transform.position;
				float y = _cachedTransform.position.y;
				_cachedTransform.position = new Vector3(position.x, y, position.z);
				_cachedTransform.LookAt(position);
			}
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
				writer.WriteFloat(_elapsedMovementTime);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WriteFloat(_elapsedMovementTime);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _elapsedMovementTime, null, reader.ReadFloat());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _elapsedMovementTime, null, reader.ReadFloat());
			}
		}
	}
}

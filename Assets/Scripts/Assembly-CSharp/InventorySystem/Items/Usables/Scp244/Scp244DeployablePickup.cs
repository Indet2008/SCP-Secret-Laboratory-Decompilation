using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.InteropServices;
using AudioPooling;
using Interactables.Interobjects.DoorUtils;
using InventorySystem.Items.Pickups;
using InventorySystem.Searching;
using MapGeneration;
using MapGeneration.StaticHelpers;
using Mirror;
using PlayerStatsSystem;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp244
{
	public class Scp244DeployablePickup : CollisionDetectionPickup, IDestructible, IBlockStaticBatching
	{
		private const float SquaredDisUpdateDiff = 1f;

		private const float ForceBoundsUpdateSqrtDiff = 100f;

		private const float UpdateCooldownTime = 2.2f;

		private const int VertsPerFrame = 30;

		private const float ParticleSize = 3.5f;

		public static readonly HashSet<Scp244DeployablePickup> Instances = new HashSet<Scp244DeployablePickup>();

		public float MaxDiameter;

		public AnimationCurve FogDistanceCurve;

		public AnimationCurve FogLerpCurve;

		[SyncVar]
		private byte _syncSizePercent;

		[SyncVar]
		private byte _syncState;

		[SerializeField]
		private AnimationCurve _growSpeedOverLifetime;

		[SerializeField]
		private float _timeToDecay;

		[SerializeField]
		private float _transitionDistance;

		[SerializeField]
		private float _fullSubmergeDistance;

		[SerializeField]
		private GameObject _visibleModel;

		[SerializeField]
		private float _minimalInfluenceDistance;

		[SerializeField]
		private float _activationDot;

		[SerializeField]
		private float _health;

		[SerializeField]
		private float _deployedPickupTime;

		[SerializeField]
		private float _heightRadiusRatio;

		[SerializeField]
		private ParticleSystem _mainEffect;

		[SerializeField]
		private GameObject _destroyedModel;

		[SerializeField]
		private Mesh _referenceMesh;

		[SerializeField]
		private AnimationCurve _emissionOverPercent;

		[SerializeField]
		private AnimationCurve _sizeOverDiameter;

		[SerializeField]
		private AudioClip[] _destroyClips;

		[SerializeField]
		private AudioSource _emissionSoundSource;

		private Vector3[] _templateVerticles;

		private Vector3[] _updatedVerticles;

		private int _meshVertsCount;

		private int _particleTimer;

		private Mesh _generatedMesh;

		private Vector2 _initialSize;

		private Vector3 _previousPos;

		private float _lastActiveSize;

		private float _lastUpdateTime;

		private bool _conditionsSet;

		private readonly Stopwatch _lifeTime = Stopwatch.StartNew();

		private float GrowSpeed => Time.deltaTime * (MaxDiameter / TimeToGrow);

		private float TimeToGrow => 1f / _growSpeedOverLifetime.Evaluate((float)_lifeTime.Elapsed.TotalSeconds);

		private float CurTime => Time.timeSinceLevelLoad;

		private Rigidbody Rb => (base.PhysicsModule as PickupStandardPhysics).Rb;

		public bool ModelDestroyed
		{
			get
			{
				if (State != Scp244State.Destroyed)
				{
					return State == Scp244State.PickedUp;
				}
				return true;
			}
		}

		public float CurrentDiameter
		{
			get
			{
				if (State == Scp244State.Active)
				{
					_lastActiveSize = CurrentSizePercent * MaxDiameter;
				}
				return _lastActiveSize;
			}
		}

		public Bounds CurrentBounds { get; private set; }

		public float CurrentSizePercent { get; private set; }

		public Scp244TransferCondition[] Conditions { get; private set; }

		public Scp244State State
		{
			get
			{
				return (Scp244State)_syncState;
			}
			set
			{
				Network_syncState = (byte)value;
			}
		}

		public uint NetworkId => base.netId;

		public Vector3 CenterOfMass => Rb.worldCenterOfMass;

		public byte Network_syncSizePercent
		{
			get
			{
				return _syncSizePercent;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _syncSizePercent, 2uL, null);
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
				GeneratedSyncVarSetter(value, ref _syncState, 4uL, null);
			}
		}

		public override PickupSearchCompletor GetPickupSearchCompletor(SearchCoordinator coordinator, float sqrDistance)
		{
			if (!InventoryItemLoader.TryGetItem<ItemBase>(Info.ItemId, out var result))
			{
				return null;
			}
			return new Scp244SearchCompletor(coordinator.Hub, this, result, sqrDistance);
		}

		private void Update()
		{
			UpdateCurrentRoom();
			UpdateConditions();
			UpdateRange();
			UpdateEffects();
		}

		protected override void Awake()
		{
			base.Awake();
			(base.PhysicsModule as PickupStandardPhysics).OnParentSetByWaypoint += () =>
			{
				Transform parent = base.transform.parent;
				ParticleSystem.MainModule main = _mainEffect.main;
				if (parent == null)
				{
					main.simulationSpace = ParticleSystemSimulationSpace.World;
				}
				else
				{
					main.simulationSpace = ParticleSystemSimulationSpace.Custom;
					main.customSimulationSpace = parent;
				}
			};
		}

		protected override void Start()
		{
			base.Start();
			Instances.Add(this);
			SetupEffects();
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			Instances.Remove(this);
		}

		private void UpdateCurrentRoom()
		{
			Vector3 position = base.transform.position;
			if (!((position - _previousPos).sqrMagnitude < 1f) && !(_lastUpdateTime + 2.2f > CurTime) && SeedSynchronizer.MapGenerated)
			{
				Conditions = Scp244TransferCondition.GenerateTransferConditions(this);
				_previousPos = position;
				_lastUpdateTime = CurTime;
				_conditionsSet = true;
			}
		}

		private void UpdateConditions()
		{
			if (!_conditionsSet)
			{
				return;
			}
			bool flag = true;
			Bounds currentBounds = default;
			Scp244TransferCondition[] conditions = Conditions;
			foreach (Scp244TransferCondition scp244TransferCondition in conditions)
			{
				bool flag2 = true;
				DoorVariant[] doors = scp244TransferCondition.Doors;
				for (int j = 0; j < doors.Length; j++)
				{
					if (!doors[j].IsConsideredOpen())
					{
						flag2 = false;
						break;
					}
				}
				if (flag2)
				{
					if (flag)
					{
						currentBounds = scp244TransferCondition.BoundsToEncapsulate;
					}
					else
					{
						currentBounds.Encapsulate(scp244TransferCondition.BoundsToEncapsulate);
					}
					flag = false;
				}
			}
			Bounds bounds = new Bounds(base.transform.position, Vector3.one * CurrentDiameter);
			currentBounds.SetMinMax(Vector3.Max(bounds.min, currentBounds.min), Vector3.Min(bounds.max, currentBounds.max));
			if ((CurrentBounds.center - currentBounds.center).sqrMagnitude < 100f)
			{
				Vector3 vector = CurrentBounds.size - currentBounds.size;
				float growSpeed = GrowSpeed;
				growSpeed = ((vector.x == 0f || vector.z == 0f) ? (growSpeed / 2f) : (growSpeed * 2f));
				Vector3 center = Vector3.MoveTowards(CurrentBounds.center, currentBounds.center, growSpeed / 2f);
				Vector3 size = Vector3.MoveTowards(CurrentBounds.size, currentBounds.size, growSpeed);
				CurrentBounds = new Bounds(center, size);
			}
			else
			{
				CurrentBounds = currentBounds;
			}
		}

		private void UpdateRange()
		{
			if (ModelDestroyed && _visibleModel.activeSelf)
			{
				Rb.constraints = RigidbodyConstraints.FreezeAll;
				_visibleModel.SetActive(value: false);
				_emissionSoundSource.enabled = false;
				if (State == Scp244State.Destroyed)
				{
					AudioSourcePoolManager.PlayOnTransform(_destroyClips.RandomItem(), base.transform, MaxDiameter, 1f, FalloffType.Exponential, MixerChannel.Weapons);
					Transform obj = Object.Instantiate(_destroyedModel).transform;
					obj.transform.SetPositionAndRotation(base.transform.position, base.transform.rotation);
					obj.localScale = Vector3.one;
					Rigidbody[] componentsInChildren = obj.GetComponentsInChildren<Rigidbody>();
					foreach (Rigidbody obj2 in componentsInChildren)
					{
						Object.Destroy(obj2.GetComponent<Collider>(), _timeToDecay);
						Object.Destroy(obj2, _timeToDecay);
					}
				}
			}
			if (!NetworkServer.active)
			{
				CurrentSizePercent = (int)_syncSizePercent;
				CurrentSizePercent /= 255f;
				return;
			}
			if (State == Scp244State.Idle && Vector3.Dot(base.transform.up, Vector3.up) < _activationDot)
			{
				State = Scp244State.Active;
				_lifeTime.Restart();
			}
			float num = ((State == Scp244State.Active) ? TimeToGrow : (0f - _timeToDecay));
			CurrentSizePercent = Mathf.Clamp01(CurrentSizePercent + Time.deltaTime / num);
			Network_syncSizePercent = (byte)Mathf.RoundToInt(CurrentSizePercent * 255f);
			if (ModelDestroyed && !(CurrentSizePercent > 0f))
			{
				_timeToDecay -= Time.deltaTime;
				if (_timeToDecay <= 0f)
				{
					NetworkServer.Destroy(base.gameObject);
				}
			}
		}

		private void SetupEffects()
		{
			_templateVerticles = _referenceMesh.vertices;
			_updatedVerticles = _referenceMesh.vertices;
			_meshVertsCount = _templateVerticles.Length;
			ParticleSystem.MainModule main = _mainEffect.main;
			_initialSize = new Vector2(main.startSize.constantMin, main.startSize.constantMax);
			_generatedMesh = new Mesh
			{
				vertices = new Vector3[_meshVertsCount],
				triangles = _referenceMesh.triangles,
				normals = _referenceMesh.normals
			};
			ParticleSystem.ShapeModule shape = _mainEffect.shape;
			shape.mesh = _generatedMesh;
		}

		private void UpdateEffects()
		{
			bool num = _emissionSoundSource.enabled;
			bool flag = State == Scp244State.Active;
			if (num != flag)
			{
				_emissionSoundSource.enabled = flag;
				_lifeTime.Restart();
			}
			ParticleSystem.EmissionModule emission = _mainEffect.emission;
			emission.rateOverTimeMultiplier = _emissionOverPercent.Evaluate(CurrentSizePercent);
			float num2 = CurrentDiameter / 2f - 3.5f;
			float num3 = _sizeOverDiameter.Evaluate(CurrentDiameter);
			ParticleSystem.MainModule main = _mainEffect.main;
			main.startSize = new ParticleSystem.MinMaxCurve(_initialSize.x * num3, _initialSize.y * num3);
			if (State == Scp244State.Idle)
			{
				return;
			}
			Bounds currentBounds = CurrentBounds;
			currentBounds.size -= new Vector3(3.5f, 0f, 3.5f);
			currentBounds.center -= base.transform.position;
			for (int i = 0; i < 30; i++)
			{
				Vector3 point = _templateVerticles[_particleTimer] * num2;
				_updatedVerticles[_particleTimer] = currentBounds.ClosestPoint(point);
				if (++_particleTimer >= _meshVertsCount)
				{
					_particleTimer = 0;
				}
			}
			_generatedMesh.vertices = _updatedVerticles;
			_mainEffect.transform.rotation = Quaternion.identity;
		}

		public float FogPercentForPoint(Vector3 worldPoint)
		{
			if (State == Scp244State.Idle)
			{
				return 0f;
			}
			Vector3 vector = base.transform.position - worldPoint;
			float sqrMagnitude = vector.sqrMagnitude;
			float num = CurrentDiameter * 0.5f;
			float num2 = num + _transitionDistance;
			if (sqrMagnitude > num2 * num2)
			{
				return 0f;
			}
			float num3 = Mathf.Sqrt(sqrMagnitude);
			Vector3 vector2 = ((num3 == 0f) ? Vector3.zero : (vector / num3));
			float num4 = Mathf.LerpUnclamped(num, num * _heightRadiusRatio, Mathf.Abs(vector2.y));
			Bounds bounds = new Bounds(CurrentBounds.center, CurrentBounds.size);
			bounds.Expand(0f - _fullSubmergeDistance);
			float a = Vector3.Distance(bounds.ClosestPoint(worldPoint), worldPoint);
			float b = num3 - num4 + _fullSubmergeDistance;
			float num5 = 1f - Mathf.Clamp01(Mathf.Max(a, b) / _transitionDistance);
			if (ModelDestroyed)
			{
				num5 *= CurrentSizePercent;
			}
			if (num < _minimalInfluenceDistance)
			{
				num5 *= num / _minimalInfluenceDistance;
			}
			return num5;
		}

		public bool Damage(float damage, DamageHandlerBase handler, Vector3 exactHitPos)
		{
			if (!(handler is ExplosionDamageHandler))
			{
				return false;
			}
			if (_health <= 0f || ModelDestroyed)
			{
				return false;
			}
			_health -= damage;
			if (_health <= 0f)
			{
				State = Scp244State.Destroyed;
			}
			return true;
		}

		public override float SearchTimeForPlayer(ReferenceHub hub)
		{
			float num = base.SearchTimeForPlayer(hub);
			if (State == Scp244State.Active)
			{
				num += _deployedPickupTime;
			}
			return num;
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
				NetworkWriterExtensions.WriteByte(writer, _syncSizePercent);
				NetworkWriterExtensions.WriteByte(writer, _syncState);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				NetworkWriterExtensions.WriteByte(writer, _syncSizePercent);
			}
			if ((base.syncVarDirtyBits & 4L) != 0L)
			{
				NetworkWriterExtensions.WriteByte(writer, _syncState);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _syncSizePercent, null, NetworkReaderExtensions.ReadByte(reader));
				GeneratedSyncVarDeserialize(ref _syncState, null, NetworkReaderExtensions.ReadByte(reader));
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _syncSizePercent, null, NetworkReaderExtensions.ReadByte(reader));
			}
			if ((num & 4L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _syncState, null, NetworkReaderExtensions.ReadByte(reader));
			}
		}
	}
}

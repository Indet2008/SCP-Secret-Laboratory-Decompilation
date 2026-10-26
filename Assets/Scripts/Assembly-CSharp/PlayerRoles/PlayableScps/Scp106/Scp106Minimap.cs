using CursorManagement;
using Interactables.Interobjects;
using MapGeneration;
using MapGeneration.Rooms;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp106
{
	public class Scp106Minimap : MonoBehaviour, ICursorOverride
	{
		[SerializeField]
		private Transform _rotorTransform;

		[SerializeField]
		private Transform _offsetTransform;

		[SerializeField]
		private Transform _rangeTransform;

		[SerializeField]
		private Scp106MinimapElement _template;

		[SerializeField]
		private float _gridScale;

		[SerializeField]
		private float _radiusScale;

		[SerializeField]
		private GameObject _errorLevel;

		[SerializeField]
		private GameObject _errorElevator;

		[SerializeField]
		private RectTransform _cursor;

		private bool _setUp;

		private float _lastElevatorRide;

		private int _poolSize;

		private int _usedRooms;

		private float _scaleCache;

		private Transform _tr;

		private static Scp106MinimapElement[] _pool;

		private const float HeightRange = 100f;

		private const float ElevatorCooldown = 0.2f;

		private const float FadeSpeed = 19f;

		private float CurTime => Time.timeSinceLevelLoad;

		private bool InElevator => CurTime - _lastElevatorRide < 0.2f;

		private float Scale
		{
			get
			{
				return _scaleCache;
			}
			set
			{
				_scaleCache = Mathf.Clamp01(value);
				_tr.localScale = Vector3.one * _scaleCache;
			}
		}

		public CursorOverrideMode CursorOverride
		{
			get
			{
				if (!IsVisible)
				{
					return CursorOverrideMode.NoOverride;
				}
				return CursorOverrideMode.Free;
			}
		}

		public bool LockMovement => false;

		public bool IsVisible { get; set; }

		public Vector3 LastWorldPos { get; set; }

		public static Scp106Minimap Singleton { get; private set; }

		private void Setup()
		{
			_poolSize = RoomIdentifier.AllRoomIdentifiers.Count;
			if (_pool == null || _poolSize > _pool.Length)
			{
				_pool = new Scp106MinimapElement[_poolSize];
			}
			for (int i = 0; i < _poolSize; i++)
			{
				Scp106MinimapElement scp106MinimapElement = Object.Instantiate(_template, _offsetTransform);
				scp106MinimapElement.Rt.localScale = Vector3.one;
				_pool[i] = scp106MinimapElement;
			}
			_setUp = true;
		}

		private void OnElevatorMoved(Bounds elevatorBounds, ElevatorChamber chamber, Vector3 deltaPos, Quaternion deltaRot)
		{
			if (elevatorBounds.Contains(MainCameraController.CurrentCamera.position))
			{
				_lastElevatorRide = CurTime;
			}
		}

		private void Awake()
		{
			CursorManager.Register(this);
			ElevatorChamber.OnElevatorMoved += OnElevatorMoved;
			Singleton = this;
			_tr = base.transform;
		}

		private void OnDestroy()
		{
			CursorManager.Unregister(this);
			ElevatorChamber.OnElevatorMoved -= OnElevatorMoved;
		}

		private void Update()
		{
			if (!SeedSynchronizer.MapGenerated)
			{
				return;
			}
			if (!_setUp)
			{
				Setup();
			}
			if (Scp106MinimapElement.AnyHighlighted)
			{
				RectTransform rt = Scp106MinimapElement.LastHighlighted.Rt;
				_cursor.SetParent(rt);
				_cursor.position = Input.mousePosition;
				_cursor.gameObject.SetActive(value: true);
			}
			else
			{
				_cursor.gameObject.SetActive(value: false);
			}
			Scale = Mathf.MoveTowards(Scale, IsVisible ? 1 : 0, 19f * Time.deltaTime);
			if (Scale <= 0f)
			{
				return;
			}
			Transform currentCamera = MainCameraController.CurrentCamera;
			Vector3 position = currentCamera.position;
			int usedRooms = _usedRooms;
			_usedRooms = 0;
			if (InElevator)
			{
				_errorLevel.SetActive(value: false);
				_errorElevator.SetActive(value: true);
			}
			else
			{
				_errorElevator.SetActive(value: false);
				bool flag = false;
				bool flag2 = false;
				if (position.TryGetRoom(out var room))
				{
					flag = room.Zone == FacilityZone.Surface;
					flag2 = room is MultiLevelRoomIdentifier multiLevelRoomIdentifier && multiLevelRoomIdentifier.TryGetLevel(position, out var levelName) && (levelName == RoomLevelName.Hcz049Sublevel || levelName == RoomLevelName.NukeSilo);
				}
				bool flag3 = flag | flag2;
				_errorLevel.SetActive(flag3);
				if (!flag3)
				{
					SetupRooms(currentCamera, position);
					RefreshRange();
				}
			}
			for (int i = _usedRooms; i < usedRooms; i++)
			{
				_pool[i].Img.enabled = false;
			}
			Vector3 vector = _template.Rt.InverseTransformPoint(Input.mousePosition) / _gridScale;
			LastWorldPos = new Vector3(0f - vector.x, position.y, 0f - vector.y);
		}

		private void RefreshRange()
		{
			if (ReferenceHub.TryGetLocalHub(out var hub) && hub.playerStats.TryGetModule<VigorStat>(out var module))
			{
				float num = module.NormalizedValue / 0.015f;
				_rangeTransform.localScale = Vector3.one / (_radiusScale * num);
			}
		}

		private void SetupRooms(Transform camTr, Vector3 camPos)
		{
			foreach (RoomIdentifier allRoomIdentifier in RoomIdentifier.AllRoomIdentifiers)
			{
				Transform transform = allRoomIdentifier.transform;
				Vector3 position = transform.position;
				if (allRoomIdentifier.Zone != FacilityZone.None && !(Mathf.Abs(position.y - camPos.y) > 100f))
				{
					Scp106MinimapElement obj = _pool[_usedRooms];
					obj.Room = allRoomIdentifier;
					obj.Img.sprite = allRoomIdentifier.Icon;
					obj.Img.enabled = true;
					obj.Rt.localEulerAngles = Vector3.back * transform.eulerAngles.y;
					obj.Rt.localPosition = new Vector3(position.x, position.z, 0f) * _gridScale;
					_usedRooms++;
				}
			}
			Vector3 vector = camPos * _gridScale;
			_offsetTransform.localPosition = -new Vector3(vector.x, vector.z, 0f);
			_rotorTransform.localEulerAngles = Vector3.forward * camTr.eulerAngles.y;
		}
	}
}

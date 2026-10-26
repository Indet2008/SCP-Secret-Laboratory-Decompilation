using System;
using System.Collections.Generic;
using Interactables.Interobjects;
using MapGeneration;
using UnityEngine;

namespace ProgressiveCulling
{
	public class RoomCullingConnection : CullableBehaviour, IBoundsCullable, ICullable
	{
		public readonly struct CoordsPair : IEquatable<CoordsPair>
		{
			public readonly Vector3Int CoordsA;

			public readonly Vector3Int CoordsB;

			public CoordsPair(Vector3Int coordsA, Vector3Int coordsB)
			{
				CoordsA = coordsA;
				CoordsB = coordsB;
			}

			public bool Equals(CoordsPair other)
			{
				if (CoordsA == other.CoordsA)
				{
					return CoordsB == other.CoordsB;
				}
				return false;
			}

			public override bool Equals(object obj)
			{
				if (obj is CoordsPair other)
				{
					return Equals(other);
				}
				return false;
			}

			public override int GetHashCode()
			{
				return HashCode.Combine(CoordsA, CoordsB);
			}
		}

		public readonly struct RoomLink
		{
			public readonly CoordsPair Coords;

			public readonly CoordsPair InvCoords;

			public readonly RoomIdentifier RoomA;

			public readonly RoomIdentifier RoomB;

			public readonly RoomIdentifier[] Rooms;

			public readonly CullableRoom CullableA;

			public readonly CullableRoom CullableB;

			public readonly CullableRoom[] Cullables;

			public readonly bool Valid;

			public bool BothCulled
			{
				get
				{
					if (CullableA.IsCulled)
					{
						return CullableB.IsCulled;
					}
					return false;
				}
			}

			public RoomLink(RoomIdentifier a, RoomIdentifier b)
			{
				RoomA = a;
				RoomB = b;
				bool flag = a.TryGetComponent<CullableRoom>(out CullableA);
				bool flag2 = b.TryGetComponent<CullableRoom>(out CullableB);
				Valid = flag & flag2;
				Vector3Int mainCoords = a.MainCoords;
				Vector3Int mainCoords2 = b.MainCoords;
				Coords = new CoordsPair(mainCoords, mainCoords2);
				InvCoords = new CoordsPair(mainCoords2, mainCoords);
				if (Valid)
				{
					Rooms = new RoomIdentifier[2] { RoomA, RoomB };
					Cullables = new CullableRoom[2] { CullableA, CullableB };
				}
				else
				{
					Rooms = new RoomIdentifier[0];
					Cullables = new CullableRoom[0];
				}
			}
		}

		public static readonly HashSet<RoomCullingConnection> AllInstances = new HashSet<RoomCullingConnection>();

		private static readonly Dictionary<CoordsPair, RoomCullingConnection> SmallestInstancesByPair = new Dictionary<CoordsPair, RoomCullingConnection>();

		private readonly AutoCuller _autoCuller = new AutoCuller();

		private bool _isSmallest;

		[SerializeField]
		private Bounds _bounds;

		public RoomLink Link { get; private set; }

		public IRoomConnector Connector { get; private set; }

		public Bounds WorldspaceBounds { get; private set; }

		public override bool ShouldBeVisible
		{
			get
			{
				if (!Link.Valid)
				{
					return CullingCamera.CheckBoundsVisibility(WorldspaceBounds);
				}
				return !Link.BothCulled;
			}
		}

		private float BoundsArea => _bounds.size.x * _bounds.size.y;

		private void Awake()
		{
			AllInstances.Add(this);
			Connector = GetComponent<IRoomConnector>();
			Connector.OnRoomsRegistered += OnRoomsRegistered;
			_autoCuller.Generate(base.gameObject, null, null, ignoreDoNotCullTag: true);
			if (Connector.RoomsAlreadyRegistered)
			{
				OnRoomsRegistered();
			}
		}

		private void OnDestroy()
		{
			AllInstances.Remove(this);
			if (_isSmallest)
			{
				SmallestInstancesByPair.Remove(Link.Coords);
				SmallestInstancesByPair.Remove(Link.InvCoords);
			}
		}

		private Bounds GenerateWorldspaceBounds()
		{
			Transform obj = base.transform;
			Vector3 center = obj.TransformPoint(_bounds.center);
			Vector3 v = obj.rotation * _bounds.size;
			return new Bounds(center, v.Abs());
		}

		private void OnRoomsRegistered()
		{
			RoomIdentifier[] rooms = Connector.Rooms;
			if (rooms.Length != 2)
			{
				return;
			}
			Link = new RoomLink(rooms[0], rooms[1]);
			WorldspaceBounds = GenerateWorldspaceBounds();
			if (Link.Valid)
			{
				AddVisibilityListener(Link.CullableA);
				AddVisibilityListener(Link.CullableB);
				if (TryRegisterSmallest())
				{
					SmallestInstancesByPair[Link.Coords] = this;
					SmallestInstancesByPair[Link.InvCoords] = this;
					_isSmallest = true;
				}
				((ICullable)this).UpdateState();
			}
		}

		private bool TryRegisterSmallest()
		{
			if (!SmallestInstancesByPair.TryGetValue(Link.Coords, out var value))
			{
				return true;
			}
			if (BoundsArea > value.BoundsArea)
			{
				return false;
			}
			value._isSmallest = false;
			return true;
		}

		private void AddVisibilityListener(CullableRoom cb)
		{
			cb.OnVisibilityUpdated += ((ICullable)this).UpdateState;
		}

		protected override void OnVisibilityChanged(bool isVisible)
		{
			_autoCuller.SetVisibility(isVisible);
		}

		protected override void OnDrawGizmosSelected()
		{
			Gizmos.color = Color.green;
			Bounds bounds = GenerateWorldspaceBounds();
			Gizmos.DrawWireCube(bounds.center, bounds.size);
		}

		public static bool TryGetConnection(Vector3Int a, Vector3Int b, out RoomCullingConnection conn)
		{
			return SmallestInstancesByPair.TryGetValue(new CoordsPair(a, b), out conn);
		}
	}
}

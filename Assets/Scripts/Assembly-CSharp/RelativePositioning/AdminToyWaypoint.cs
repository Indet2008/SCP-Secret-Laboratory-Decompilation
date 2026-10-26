using System.Collections.Generic;
using AdminToys;
using UnityEngine;

namespace RelativePositioning
{
	public class AdminToyWaypoint : WaypointBase, IMovableWaypoint, IBacktrackableWaypoint
	{
		private struct BacktrackFrame
		{
			public Vector3 Position;

			public Quaternion Rotation;
		}

		private const int BacktrackFrameCount = 15;

		private const int BacktrackFixedUpdateCooldown = 3;

		public float Priority;

		public bool IsStatic;

		[SerializeField]
		private WaypointToy _waypointToy;

		private Transform _transform;

		private List<IChildWaypointObject> _children = new List<IChildWaypointObject>();

		private BacktrackFrame[] _backtrackFrames = new BacktrackFrame[15];

		private byte _backtrackIndexClock;

		private byte _backtrackCooldownTimer;

		protected override bool AutoAssign => false;

		Transform IMovableWaypoint.transform => base.transform;

		protected void Awake()
		{
			_transform = base.transform;
		}

		protected void FixedUpdate()
		{
			if (IsStatic)
			{
				return;
			}
			if (_backtrackCooldownTimer > 0)
			{
				_backtrackCooldownTimer--;
				return;
			}
			if (++_backtrackIndexClock >= 15)
			{
				_backtrackIndexClock = 0;
			}
			_backtrackCooldownTimer = 3;
			_backtrackFrames[_backtrackIndexClock] = new BacktrackFrame
			{
				Position = _transform.position,
				Rotation = _transform.rotation
			};
		}

		public void Add(IChildWaypointObject child)
		{
			_children.Add(child);
		}

		public void Remove(IChildWaypointObject child)
		{
			_children.Remove(child);
		}

		public void OnMoved(Vector3 deltaPos, Quaternion deltaRot)
		{
			foreach (IChildWaypointObject child in _children)
			{
				child.OnWaypointMoved(_transform, deltaPos, deltaRot);
			}
		}

		public byte ServerAssignId()
		{
			byte b = FindFreeId();
			AssignSelfToList();
			SetId(b);
			return b;
		}

		public void ClientAssignId(byte id)
		{
			AssignSelfToList();
			SetId(id);
		}

		protected override float SqrDistanceTo(Vector3 pos)
		{
			float num = Priority * Priority * Mathf.Sign(Priority);
			Vector3 vector = _transform.position - pos;
			if (IsStatic)
			{
				return vector.sqrMagnitude - num;
			}
			Vector3 v = Quaternion.Inverse(_transform.rotation) * vector;
			Vector3 vector2 = _waypointToy.BoundsSize / 2f - v.Abs();
			if (!(vector2.x < 0f) && !(vector2.y < 0f) && !(vector2.z < 0f))
			{
				return v.sqrMagnitude - num;
			}
			return float.MaxValue;
		}

		public override Vector3 GetWorldspacePosition(Vector3 relPosition)
		{
			return _transform.TransformPoint(relPosition);
		}

		public override Vector3 GetRelativePosition(Vector3 worldPoint)
		{
			return _transform.InverseTransformPoint(worldPoint);
		}

		public override Quaternion GetWorldspaceRotation(Quaternion relRotation)
		{
			return _transform.rotation * relRotation;
		}

		public override Quaternion GetRelativeRotation(Quaternion worldRot)
		{
			return Quaternion.Inverse(_transform.rotation) * worldRot;
		}

		public void Backtrack(double lagCompensation)
		{
			if (!IsStatic)
			{
				float num = (float)(lagCompensation / (double)(Time.fixedDeltaTime * 4f));
				int num2 = Mathf.Min(14, Mathf.FloorToInt(num));
				int num3 = Mathf.Min(14, num2 + 1);
				float t = num - (float)num2;
				BacktrackFrame backtrackFrame = _backtrackFrames[Wrap(_backtrackIndexClock - num2)];
				BacktrackFrame backtrackFrame2 = _backtrackFrames[Wrap(_backtrackIndexClock - num3)];
				_transform.SetPositionAndRotation(Vector3.Lerp(backtrackFrame.Position, backtrackFrame2.Position, t), Quaternion.Lerp(backtrackFrame.Rotation, backtrackFrame2.Rotation, t));
			}
		}

		private int Wrap(int x)
		{
			if (x < 0)
			{
				x += 15;
			}
			return x;
		}
	}
}

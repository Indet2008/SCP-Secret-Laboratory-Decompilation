using System.Collections.Generic;
using Interactables.Interobjects;
using UnityEngine;

namespace RelativePositioning
{
	public class ElevatorWaypoint : WaypointBase, IMovableWaypoint
	{
		[SerializeField]
		private ElevatorChamber _elevator;

		private Transform _transform;

		private bool _transformSet;

		private List<IChildWaypointObject> _children = new List<IChildWaypointObject>();

		private Transform ElevatorTransform
		{
			get
			{
				if (!_transformSet)
				{
					_transform = _elevator.transform;
					_transformSet = true;
				}
				return _transform;
			}
		}

		protected override bool AutoAssign => false;

		Transform IMovableWaypoint.transform => base.transform;

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
				child.OnWaypointMoved(ElevatorTransform, deltaPos, deltaRot);
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
			if (!_elevator.WorldspaceBounds.Contains(pos))
			{
				return float.MaxValue;
			}
			return -1f;
		}

		public override Vector3 GetWorldspacePosition(Vector3 relPosition)
		{
			return ElevatorTransform.TransformPoint(relPosition);
		}

		public override Vector3 GetRelativePosition(Vector3 worldPoint)
		{
			return ElevatorTransform.InverseTransformPoint(worldPoint);
		}

		public override Quaternion GetWorldspaceRotation(Quaternion relRotation)
		{
			return ElevatorTransform.rotation * relRotation;
		}

		public override Quaternion GetRelativeRotation(Quaternion worldRot)
		{
			return Quaternion.Inverse(ElevatorTransform.rotation) * worldRot;
		}
	}
}

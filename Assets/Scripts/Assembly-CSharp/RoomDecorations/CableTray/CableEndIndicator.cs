using System.Collections.Generic;
using MapGeneration;
using UnityEngine;

namespace RoomDecorations.CableTray
{
	public class CableEndIndicator : MonoBehaviour
	{
		public static readonly HashSet<CableEndIndicator> UnconnectedInstances = new HashSet<CableEndIndicator>();

		public static readonly HashSet<CableEndIndicator> AllInstances = new HashSet<CableEndIndicator>();

		private const float BorderTolerance = 0.2f;

		private const float ConnectionTolerance = 0.16f;

		private bool _isUnconnected;

		public Vector3 Position { get; private set; }

		[field: SerializeField]
		public bool OpenEnded { get; private set; }

		private void Awake()
		{
			Position = base.transform.position;
			AllInstances.Add(this);
			if (!IsRoomBorder())
			{
				return;
			}
			foreach (CableEndIndicator unconnectedInstance in UnconnectedInstances)
			{
				if (!((Position - unconnectedInstance.Position).sqrMagnitude > 0.16f))
				{
					unconnectedInstance.RemoveFromUnconnected();
					return;
				}
			}
			_isUnconnected = true;
			UnconnectedInstances.Add(this);
		}

		private void OnDestroy()
		{
			RemoveFromUnconnected();
			AllInstances.Remove(this);
		}

		private void RemoveFromUnconnected()
		{
			if (_isUnconnected)
			{
				_isUnconnected = false;
				UnconnectedInstances.Remove(this);
			}
		}

		private bool IsRoomBorder()
		{
			Vector3 fwd = Position + Vector3.forward * 0.2f;
			if (CompareCoords(fwd, Vector3.back) && CompareCoords(fwd, Vector3.left))
			{
				return !CompareCoords(fwd, Vector3.right);
			}
			return true;
		}

		private bool CompareCoords(Vector3 fwd, Vector3 dir)
		{
			return fwd.CompareCoords(Position + dir * 0.2f);
		}
	}
}

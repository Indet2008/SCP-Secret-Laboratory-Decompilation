using UnityEngine;

namespace RelativePositioning
{
	public abstract class WaypointFollowerBase : MonoBehaviour
	{
		private RelativePosition _lastPosition;

		public RelativePosition LastPosition
		{
			get
			{
				return _lastPosition;
			}
			protected set
			{
				if (_lastPosition.WaypointId != value.WaypointId)
				{
					OnWaypointChanged(_lastPosition.WaypointId, value.WaypointId);
				}
				_lastPosition = value;
			}
		}

		protected virtual void OnWaypointChanged(byte oldId, byte newId)
		{
			if (WaypointBase.TryGetWaypoint(oldId, out IMovableWaypoint wp))
			{
				base.transform.SetParent(null);
			}
			if (WaypointBase.TryGetWaypoint(newId, out wp))
			{
				base.transform.SetParent(wp.transform);
			}
		}
	}
}

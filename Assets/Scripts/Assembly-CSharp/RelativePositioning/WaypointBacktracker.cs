using System;
using UnityEngine;

namespace RelativePositioning
{
	public class WaypointBacktracker : IDisposable
	{
		private Vector3 _prevPosition;

		private Quaternion _prevRotation;

		private WaypointBase _waypoint;

		public WaypointBacktracker(byte waypointId, double lagCompensation)
		{
			if (WaypointBase.TryGetWaypoint(waypointId, out var wp))
			{
				Setup(wp, lagCompensation);
			}
		}

		public WaypointBacktracker(WaypointBase wp, double lagCompensation)
		{
			Setup(wp, lagCompensation);
		}

		public void Dispose()
		{
			if (_waypoint != null)
			{
				_waypoint.transform.SetPositionAndRotation(_prevPosition, _prevRotation);
			}
		}

		private void Setup(WaypointBase wp, double lagCompensation)
		{
			if (wp is IBacktrackableWaypoint backtrackableWaypoint)
			{
				_waypoint = wp;
				wp.transform.GetPositionAndRotation(out _prevPosition, out _prevRotation);
				backtrackableWaypoint.Backtrack(lagCompensation);
			}
		}
	}
}

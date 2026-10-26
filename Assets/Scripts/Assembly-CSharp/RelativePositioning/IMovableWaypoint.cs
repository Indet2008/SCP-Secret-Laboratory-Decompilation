using UnityEngine;

namespace RelativePositioning
{
	public interface IMovableWaypoint
	{
		Transform transform { get; }

		void Add(IChildWaypointObject child);

		void Remove(IChildWaypointObject child);
	}
}

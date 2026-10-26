using UnityEngine;

namespace RelativePositioning
{
	public interface IChildWaypointObject
	{
		void OnWaypointMoved(Transform transform, Vector3 deltaPos, Quaternion deltaRot);
	}
}

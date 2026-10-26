using MapGeneration;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Map
{
	public interface IZoneMap
	{
		Bounds RectBounds { get; }

		FacilityZone Zone { get; }

		bool Ready { get; }

		void Generate();

		bool TryGetCenterTransform(Scp079Camera curCam, out Vector3 center);

		bool TrySetPlayerIndicator(ReferenceHub ply, RectTransform indicator, bool exact);

		void UpdateOpened(Scp079Camera curCam);

		bool TryGetCamera(out Scp079Camera target);
	}
}

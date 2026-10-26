using System;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using UnityEngine;

namespace MapGeneration.Holidays
{
	public class Scp079HolidayCameraManager : MonoBehaviour
	{
		[Serializable]
		private struct Holiday079Camera
		{
			public Scp079HolidayCameraBase Base;

			public HolidayType HolidayType;

			public FacilityZone Zone;
		}

		[SerializeField]
		private Holiday079Camera[] _holidayCameras;

		private void Awake()
		{
			Scp079Camera.OnInstanceCreated += Scp079CameraOnInstanceCreated;
		}

		private void OnDestroy()
		{
			Scp079Camera.OnInstanceCreated -= Scp079CameraOnInstanceCreated;
		}

		private void Scp079CameraOnInstanceCreated(Scp079Camera camera)
		{
			HolidayType activeHoliday = HolidayUtils.GetActiveHoliday();
			FacilityZone zone = camera.Room.Zone;
			if (activeHoliday == HolidayType.None)
			{
				return;
			}
			Holiday079Camera[] holidayCameras = _holidayCameras;
			for (int i = 0; i < holidayCameras.Length; i++)
			{
				Holiday079Camera holiday079Camera = holidayCameras[i];
				if (activeHoliday == holiday079Camera.HolidayType && zone == holiday079Camera.Zone)
				{
					Transform parent = ((holiday079Camera.Zone == FacilityZone.Entrance) ? camera.HorizontalAxis.Pivot : camera.CameraAnchor);
					UnityEngine.Object.Instantiate(holiday079Camera.Base, parent).Initialize(camera);
					break;
				}
			}
		}
	}
}

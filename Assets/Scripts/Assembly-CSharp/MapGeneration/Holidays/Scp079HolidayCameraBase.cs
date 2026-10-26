using PlayerRoles.PlayableScps.Scp079.Cameras;
using UnityEngine;

namespace MapGeneration.Holidays
{
	public abstract class Scp079HolidayCameraBase : MonoBehaviour
	{
		public Scp079Camera CameraParent { get; private set; }

		public void Initialize(Scp079Camera cameraParent)
		{
			CameraParent = cameraParent;
			OnInitialize();
		}

		protected virtual void OnInitialize()
		{
		}
	}
}

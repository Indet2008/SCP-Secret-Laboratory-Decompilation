using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson
{
	public class ModelReferencePoint : MonoBehaviour
	{
		private Transform _transformCache;

		public RefpointType Type;

		public Transform FastTr
		{
			get
			{
				if ((object)_transformCache == null)
				{
					_transformCache = base.transform;
				}
				return _transformCache;
			}
		}
	}
}

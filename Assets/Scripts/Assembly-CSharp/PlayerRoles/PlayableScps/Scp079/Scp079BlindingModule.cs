using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

namespace PlayerRoles.PlayableScps.Scp079
{
	public class Scp079BlindingModule : MonoBehaviour
	{
		private const float ModelRadius = 0.25f;

		private const float VisionTriggerDistance = 60f;

		public Volume ExposureVolume;

		[SerializeField]
		private float _enableSpeed;

		[SerializeField]
		private float _disableSpeed;

		private readonly List<ReferenceHub> _orangePlayers = new List<ReferenceHub>();
	}
}

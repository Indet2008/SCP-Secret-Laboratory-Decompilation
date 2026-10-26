using System;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939.Ripples
{
	public class SpawnableRipple : MonoBehaviour
	{
		[field: SerializeField]
		public float Range { get; private set; }

		public static event Action<SpawnableRipple> OnSpawned;

		private void OnEnabled()
		{
			OnSpawned?.Invoke(this);
		}
	}
}

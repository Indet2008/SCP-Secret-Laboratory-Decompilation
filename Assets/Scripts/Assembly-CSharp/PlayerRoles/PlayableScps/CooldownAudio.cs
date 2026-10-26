using AudioPooling;
using Mirror;
using UnityEngine;

namespace PlayerRoles.PlayableScps
{
	public class CooldownAudio : MonoBehaviour
	{
		public double Cooldown;

		[SerializeField]
		private AudioClip _cooldownAudio;

		[SerializeField]
		private PlayerRoleBase _player;

		private double _lastTime;

		public void PlayAudio()
		{
			if (!(NetworkTime.time < _lastTime))
			{
				_lastTime = NetworkTime.time + Cooldown;
				AudioSourcePoolManager.Play2DWithParent(_cooldownAudio, _player.transform);
			}
		}
	}
}

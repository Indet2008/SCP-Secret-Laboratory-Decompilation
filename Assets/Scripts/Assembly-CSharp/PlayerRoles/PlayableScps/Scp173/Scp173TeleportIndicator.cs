using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp173
{
	public class Scp173TeleportIndicator : MonoBehaviour
	{
		[SerializeField]
		private float _volumeAdjustmentSpeed;

		[SerializeField]
		private AudioSource _soundSource;

		[SerializeField]
		private GameObject _normalIndicator;

		[SerializeField]
		private GameObject _killIndicator;

		[SerializeField]
		private GameObject _neutralIndicator;

		[SerializeField]
		private SubroutineManagerModule _subroutineManager;

		private float _targetVolume;

		private Scp173TeleportAbility _teleportAbility;

		private Scp173BreakneckSpeedsAbility _breakneckSpeedsAbility;

		private void Awake()
		{
			_subroutineManager.TryGetSubroutine<Scp173TeleportAbility>(out _teleportAbility);
			_subroutineManager.TryGetSubroutine<Scp173BreakneckSpeedsAbility>(out _breakneckSpeedsAbility);
		}

		private void Update()
		{
			_soundSource.volume = Mathf.MoveTowards(_soundSource.volume, _targetVolume, _volumeAdjustmentSpeed * Time.deltaTime);
		}

		private void SetupVisiblity(bool normal = false, bool kill = false, bool neutral = false)
		{
			_normalIndicator.SetActive(normal);
			_killIndicator.SetActive(kill);
			_neutralIndicator.SetActive(neutral);
		}

		public void UpdateVisibility(bool isVisible)
		{
			_targetVolume = (isVisible ? 1 : 0);
			if (!isVisible)
			{
				SetupVisiblity();
				return;
			}
			if (_breakneckSpeedsAbility.IsActive)
			{
				SetupVisiblity(normal: false, kill: false, neutral: true);
				return;
			}
			bool flag = _teleportAbility.BestTarget != null;
			SetupVisiblity(!flag, flag);
		}
	}
}

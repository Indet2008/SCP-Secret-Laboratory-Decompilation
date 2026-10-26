using PlayerRoles;
using UnityEngine;

namespace Respawning.Waves
{
	public class ChaosWaveAnimation : WaveAnimationBase<ChaosSpawnWave>
	{
		[SerializeField]
		private AudioSource _announcement;

		protected override void OnAnimationEnd()
		{
			base.OnAnimationEnd();
			if (ReferenceHub.TryGetLocalHub(out var hub))
			{
				Team team = hub.GetTeam();
				if (team == Team.Dead || team.GetFaction() == Faction.FoundationEnemy)
				{
					_announcement.Play();
				}
			}
		}
	}
}

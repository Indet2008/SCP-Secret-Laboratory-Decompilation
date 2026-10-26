using InventorySystem.Items.Firearms.Modules;
using InventorySystem.Items.Firearms.ShotEvents;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class DisruptorMuzzleExtension : ShootingEffectsExtensionBase
	{
		[SerializeField]
		private ParticleCollection _singleShotEffects;

		[SerializeField]
		private ParticleCollection _rapidFireEffects;

		protected override void PlayEffects(ShotEvent ev)
		{
			if (ev is DisruptorShotEvent { State: var state })
			{
				switch (state)
				{
				case DisruptorActionModule.FiringState.FiringSingle:
					_singleShotEffects.Play();
					break;
				case DisruptorActionModule.FiringState.FiringRapid:
					_rapidFireEffects.Play();
					break;
				}
			}
		}
	}
}

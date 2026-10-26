using InventorySystem.Items.Firearms.ShotEvents;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class ShootingParticlesExtension : ShootingEffectsExtensionBase
	{
		[SerializeField]
		private ParticleCollection[] _systemsPerBarrel;

		protected override void Awake()
		{
			base.Awake();
			ParticleCollection[] systemsPerBarrel = _systemsPerBarrel;
			foreach (ParticleCollection particleCollection in systemsPerBarrel)
			{
				particleCollection.ConvertLights();
			}
		}

		protected override void PlayEffects(ShotEvent ev)
		{
			if (ev is IMultiBarreledShot multiBarreledShot && _systemsPerBarrel.TryGet(multiBarreledShot.BarrelId, out var element))
			{
				element.Play();
			}
		}
	}
}

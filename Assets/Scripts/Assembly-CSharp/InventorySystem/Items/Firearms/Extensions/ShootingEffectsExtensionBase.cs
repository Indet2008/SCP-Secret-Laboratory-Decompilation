using System;
using System.Collections.Generic;
using InventorySystem.Items.Firearms.ShotEvents;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public abstract class ShootingEffectsExtensionBase : MixedExtension
	{
		[Serializable]
		protected struct ParticleCollection
		{
			public ParticleSystem[] ParticleSystems;

			public readonly void Play()
			{
				ParticleSystem[] particleSystems = ParticleSystems;
				for (int i = 0; i < particleSystems.Length; i++)
				{
					particleSystems[i].Play(withChildren: true);
				}
			}

			public readonly void ConvertLights()
			{
				ParticleSystems.ForEach(WorldspaceLightParticleConverter.Convert);
			}
		}

		private static readonly HashSet<ShootingEffectsExtensionBase> Instances = new HashSet<ShootingEffectsExtensionBase>();

		private bool _standbyMode;

		protected virtual void OnEnable()
		{
			_standbyMode = false;
		}

		protected virtual void OnDisable()
		{
			_standbyMode = true;
		}

		protected virtual void Awake()
		{
			Instances.Add(this);
		}

		protected virtual void OnDestroy()
		{
			Instances.Remove(this);
		}

		protected abstract void PlayEffects(ShotEvent ev);

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			ShotEventManager.OnShot += Play;
		}

		public static void Play(ShotEvent ev)
		{
			foreach (ShootingEffectsExtensionBase instance in Instances)
			{
				if (!instance._standbyMode && !(instance.Identifier != ev.ItemId))
				{
					instance.PlayEffects(ev);
				}
			}
		}
	}
}

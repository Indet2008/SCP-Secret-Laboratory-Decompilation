using System;
using System.Collections.Generic;
using MapGeneration;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.VFX;

namespace CustomRendering
{
	// The ripped VFX Graph assets cannot run (their compute shaders failed to import), so their
	// VisualEffect components are swapped for Particle Systems built here. Settings are hand-tuned
	// approximations of the originals, in the effect's local space so the room's scale still applies.
	public static class VfxParticleFallback
	{
		private const string ChildName = "ParticleFallback";

		private const string MaterialFolder = "VfxFallback/";

		private static readonly Dictionary<string, Material> Materials = new Dictionary<string, Material>();

		private static readonly Dictionary<string, Action<VisualEffect, GameObject>> Builders = new Dictionary<string, Action<VisualEffect, GameObject>>
		{
			["VFX_Fire"] = BuildFire,
			["VFX_DustParticles"] = BuildDust,
			["Extinguisher_Smoke"] = BuildSteam,
			["VFX_Smoke_Trail_Unlit"] = BuildSmokeTrail,
			["VFX_Sparks"] = BuildSparks
		};

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			SceneManager.sceneLoaded += delegate
			{
				ReplaceAll();
			};
			SeedSynchronizer.OnGenerationFinished += ReplaceAll;
		}

		public static void ReplaceAll()
		{
			VisualEffect[] array = UnityEngine.Object.FindObjectsByType<VisualEffect>(FindObjectsInactive.Include, FindObjectsSortMode.None);
			foreach (VisualEffect vfx in array)
			{
				TryReplace(vfx);
			}
		}

		public static bool TryReplace(VisualEffect vfx)
		{
			if (vfx == null || vfx.visualEffectAsset == null || !Builders.TryGetValue(vfx.visualEffectAsset.name, out var value))
			{
				return false;
			}
			if (vfx.transform.Find(ChildName) != null)
			{
				return true;
			}
			vfx.enabled = false;
			GameObject gameObject = new GameObject(ChildName);
			gameObject.layer = vfx.gameObject.layer;
			Transform transform = gameObject.transform;
			transform.SetParent(vfx.transform, worldPositionStays: false);
			transform.localPosition = Vector3.zero;
			transform.localRotation = Quaternion.identity;
			transform.localScale = Vector3.one;
			try
			{
				value(vfx, gameObject);
			}
			catch (Exception exception)
			{
				Debug.LogException(exception, vfx);
			}
			return true;
		}

		public static Material GetMaterial(string name)
		{
			if (!Materials.TryGetValue(name, out var value) || value == null)
			{
				value = Resources.Load<Material>(MaterialFolder + name);
				if (value == null)
				{
					Debug.LogWarning("[VfxParticleFallback] Missing material Resources/" + MaterialFolder + name);
				}
				Materials[name] = value;
			}
			return value;
		}

		private static ParticleSystem CreateSystem(GameObject go, string materialName, Vector3 localEuler)
		{
			ParticleSystem particleSystem = go.AddComponent<ParticleSystem>();
			particleSystem.Stop(withChildren: true, ParticleSystemStopBehavior.StopEmittingAndClear);
			go.transform.localRotation = Quaternion.Euler(localEuler);
			ParticleSystem.MainModule main = particleSystem.main;
			main.playOnAwake = true;
			main.loop = true;
			main.duration = 5f;
			main.simulationSpace = ParticleSystemSimulationSpace.Local;
			main.scalingMode = ParticleSystemScalingMode.Hierarchy;
			main.maxParticles = 300;
			ParticleSystemRenderer component = go.GetComponent<ParticleSystemRenderer>();
			component.sharedMaterial = GetMaterial(materialName);
			component.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
			component.receiveShadows = false;
			component.sortingFudge = 0f;
			return particleSystem;
		}

		private static void SetFlipbook(ParticleSystem ps, int tiles)
		{
			ParticleSystem.TextureSheetAnimationModule textureSheetAnimation = ps.textureSheetAnimation;
			textureSheetAnimation.enabled = true;
			textureSheetAnimation.mode = ParticleSystemAnimationMode.Grid;
			textureSheetAnimation.numTilesX = tiles;
			textureSheetAnimation.numTilesY = tiles;
			textureSheetAnimation.animation = ParticleSystemAnimationType.WholeSheet;
			textureSheetAnimation.frameOverTime = new ParticleSystem.MinMaxCurve(1f, AnimationCurve.Linear(0f, 0f, 1f, 1f));
		}

		private static void SetFade(ParticleSystem ps, float maxAlpha, float fadeIn, float fadeOut)
		{
			ParticleSystem.ColorOverLifetimeModule colorOverLifetime = ps.colorOverLifetime;
			colorOverLifetime.enabled = true;
			Gradient gradient = new Gradient();
			gradient.SetKeys(new GradientColorKey[2]
			{
				new GradientColorKey(Color.white, 0f),
				new GradientColorKey(Color.white, 1f)
			}, new GradientAlphaKey[4]
			{
				new GradientAlphaKey(0f, 0f),
				new GradientAlphaKey(maxAlpha, fadeIn),
				new GradientAlphaKey(maxAlpha, 1f - fadeOut),
				new GradientAlphaKey(0f, 1f)
			});
			colorOverLifetime.color = gradient;
		}

		private static void SetGrowth(ParticleSystem ps, float endMultiplier)
		{
			ParticleSystem.SizeOverLifetimeModule sizeOverLifetime = ps.sizeOverLifetime;
			sizeOverLifetime.enabled = true;
			sizeOverLifetime.size = new ParticleSystem.MinMaxCurve(1f, AnimationCurve.EaseInOut(0f, 1f, 1f, endMultiplier));
		}

		private static void SetNoise(ParticleSystem ps, float strength, float frequency)
		{
			ParticleSystem.NoiseModule noise = ps.noise;
			noise.enabled = true;
			noise.strength = strength;
			noise.frequency = frequency;
			noise.scrollSpeed = 0.3f;
			noise.quality = ParticleSystemNoiseQuality.Low;
		}

		private static void SetCone(ParticleSystem ps, float angle, float radius)
		{
			// Cone shapes emit along local +Z; the system's rotation aims that axis.
			ParticleSystem.ShapeModule shape = ps.shape;
			shape.enabled = true;
			shape.shapeType = ParticleSystemShapeType.Cone;
			shape.angle = angle;
			shape.radius = radius;
		}

		private static float ReadFloat(VisualEffect vfx, string name, float fallback)
		{
			try
			{
				return vfx.HasFloat(name) ? vfx.GetFloat(name) : fallback;
			}
			catch
			{
				return fallback;
			}
		}

		// SCP-914 fire: rising flipbook flames plus a few embers. Pointed up (+Y).
		private static void BuildFire(VisualEffect vfx, GameObject go)
		{
			ParticleSystem particleSystem = CreateSystem(go, "Fire", new Vector3(-90f, 0f, 0f));
			ParticleSystem.MainModule main = particleSystem.main;
			main.startLifetime = new ParticleSystem.MinMaxCurve(0.7f, 1.1f);
			main.startSpeed = new ParticleSystem.MinMaxCurve(0.25f, 0.5f);
			main.startSize = new ParticleSystem.MinMaxCurve(0.45f, 0.8f);
			main.startRotation = new ParticleSystem.MinMaxCurve(-0.3f, 0.3f);
			ParticleSystem.EmissionModule emission = particleSystem.emission;
			emission.rateOverTime = 18f;
			SetCone(particleSystem, 10f, 0.12f);
			SetFlipbook(particleSystem, 8);
			SetFade(particleSystem, 1f, 0.15f, 0.35f);
			SetGrowth(particleSystem, 1.3f);
			SetNoise(particleSystem, 0.15f, 1.5f);
			particleSystem.Play();
			GameObject gameObject = new GameObject("Embers");
			gameObject.layer = go.layer;
			// Child of the flame system, so it inherits the upward orientation.
			gameObject.transform.SetParent(go.transform, worldPositionStays: false);
			ParticleSystem particleSystem2 = CreateSystem(gameObject, "FireEmbers", Vector3.zero);
			ParticleSystem.MainModule main2 = particleSystem2.main;
			main2.startLifetime = new ParticleSystem.MinMaxCurve(1f, 1.8f);
			main2.startSpeed = new ParticleSystem.MinMaxCurve(0.5f, 1.2f);
			main2.startSize = new ParticleSystem.MinMaxCurve(0.02f, 0.05f);
			ParticleSystem.EmissionModule emission2 = particleSystem2.emission;
			emission2.rateOverTime = 6f;
			SetCone(particleSystem2, 25f, 0.15f);
			SetFade(particleSystem2, 1f, 0.05f, 0.5f);
			SetNoise(particleSystem2, 0.6f, 2f);
			particleSystem2.Play();
		}

		// SCP-914 room: slow dust motes floating in the air around the effect.
		private static void BuildDust(VisualEffect vfx, GameObject go)
		{
			ParticleSystem particleSystem = CreateSystem(go, "Dust", Vector3.zero);
			ParticleSystem.MainModule main = particleSystem.main;
			main.startLifetime = new ParticleSystem.MinMaxCurve(6f, 10f);
			main.startSpeed = new ParticleSystem.MinMaxCurve(0.01f, 0.04f);
			main.startSize = new ParticleSystem.MinMaxCurve(0.02f, 0.06f);
			main.prewarm = true;
			ParticleSystem.EmissionModule emission = particleSystem.emission;
			emission.rateOverTime = 8f;
			ParticleSystem.ShapeModule shape = particleSystem.shape;
			shape.enabled = true;
			shape.shapeType = ParticleSystemShapeType.Box;
			shape.scale = new Vector3(4f, 2.5f, 4f);
			SetFade(particleSystem, 0.35f, 0.2f, 0.3f);
			SetNoise(particleSystem, 0.05f, 0.4f);
			particleSystem.Play();
		}

		// HCZ water room: pressurised steam jets along the effect's local forward axis.
		private static void BuildSteam(VisualEffect vfx, GameObject go)
		{
			ParticleSystem particleSystem = CreateSystem(go, "Steam", Vector3.zero);
			ParticleSystem.MainModule main = particleSystem.main;
			main.startLifetime = new ParticleSystem.MinMaxCurve(0.6f, 1f);
			main.startSpeed = new ParticleSystem.MinMaxCurve(0.35f, 0.6f);
			main.startSize = new ParticleSystem.MinMaxCurve(0.05f, 0.1f);
			main.startRotation = new ParticleSystem.MinMaxCurve(0f, (float)Math.PI * 2f);
			main.prewarm = true;
			ParticleSystem.EmissionModule emission = particleSystem.emission;
			emission.rateOverTime = 22f;
			SetCone(particleSystem, 8f, 0.01f);
			SetFlipbook(particleSystem, 8);
			SetFade(particleSystem, 0.5f, 0.1f, 0.5f);
			SetGrowth(particleSystem, 3f);
			SetNoise(particleSystem, 0.05f, 1f);
			particleSystem.Play();
		}

		// HCZ incinerator: slow smoke rising out of the extraction pipes (+Y). Respects the "Alpha" override.
		private static void BuildSmokeTrail(VisualEffect vfx, GameObject go)
		{
			float maxAlpha = Mathf.Clamp01(ReadFloat(vfx, "Alpha", 0.46f));
			ParticleSystem particleSystem = CreateSystem(go, "SmokeTrail", new Vector3(-90f, 0f, 0f));
			ParticleSystem.MainModule main = particleSystem.main;
			main.startLifetime = new ParticleSystem.MinMaxCurve(2f, 3.2f);
			main.startSpeed = new ParticleSystem.MinMaxCurve(0.12f, 0.22f);
			main.startSize = new ParticleSystem.MinMaxCurve(0.12f, 0.2f);
			main.startRotation = new ParticleSystem.MinMaxCurve(0f, (float)Math.PI * 2f);
			main.prewarm = true;
			ParticleSystem.EmissionModule emission = particleSystem.emission;
			emission.rateOverTime = 7f;
			SetCone(particleSystem, 12f, 0.03f);
			SetFlipbook(particleSystem, 8);
			SetFade(particleSystem, maxAlpha, 0.15f, 0.5f);
			SetGrowth(particleSystem, 2.5f);
			SetNoise(particleSystem, 0.04f, 0.6f);
			particleSystem.Play();
		}

		// HCZ incinerator: bursts of short-lived sparks falling under gravity.
		private static void BuildSparks(VisualEffect vfx, GameObject go)
		{
			ParticleSystem particleSystem = CreateSystem(go, "Sparks", new Vector3(-90f, 0f, 0f));
			ParticleSystem.MainModule main = particleSystem.main;
			main.duration = 2.5f;
			main.startLifetime = new ParticleSystem.MinMaxCurve(0.35f, 0.8f);
			main.startSpeed = new ParticleSystem.MinMaxCurve(1.5f, 3.5f);
			main.startSize = new ParticleSystem.MinMaxCurve(0.015f, 0.035f);
			main.gravityModifier = 1f;
			main.simulationSpace = ParticleSystemSimulationSpace.World;
			ParticleSystem.EmissionModule emission = particleSystem.emission;
			emission.rateOverTime = 2f;
			emission.SetBursts(new ParticleSystem.Burst[2]
			{
				new ParticleSystem.Burst(0.2f, 12, 20),
				new ParticleSystem.Burst(1.4f, 6, 14)
			});
			SetCone(particleSystem, 35f, 0.05f);
			SetFade(particleSystem, 1f, 0.02f, 0.4f);
			ParticleSystemRenderer component = go.GetComponent<ParticleSystemRenderer>();
			component.renderMode = ParticleSystemRenderMode.Stretch;
			component.velocityScale = 0.04f;
			component.lengthScale = 1f;
			particleSystem.Play();
		}
	}
}

using UnityEngine;

public class WorldspaceLightParticleConverter : MonoBehaviour
{
	private const string MaterialPath = "StaticMaterials/Invisible";

	private const float MinFlashDur = 0.025f;

	private static Material _invisibleMat;

	private static bool _matLoaded;

	private static Material InvisibleMaterial
	{
		get
		{
			if (!_matLoaded)
			{
				_invisibleMat = Resources.Load<Material>("StaticMaterials/Invisible");
				_matLoaded = true;
			}
			return _invisibleMat;
		}
	}

	public static void Convert(ParticleSystem system, bool includeSubsystems)
	{
		if (includeSubsystems)
		{
			system.gameObject.ForEachComponentInChildren<ParticleSystem>(ConvertIndividual, includeInactive: true);
		}
		else
		{
			ConvertIndividual(system);
		}
	}

	public static void Convert(ParticleSystem system)
	{
		Convert(system, includeSubsystems: true);
	}

	private static void ConvertIndividual(ParticleSystem system)
	{
		if (!system.lights.enabled || system.lights.light == null)
		{
			return;
		}
		Transform transform = system.transform;
		ParticleSystem particleSystem = Object.Instantiate(system, transform);
		Transform transform2 = particleSystem.transform;
		ParticleSystem.MainModule main = particleSystem.main;
		transform2.localPosition = Vector3.zero;
		transform2.localRotation = Quaternion.identity;
		switch (main.scalingMode)
		{
		case ParticleSystemScalingMode.Local:
			transform2.localScale = transform.localScale;
			break;
		case ParticleSystemScalingMode.Hierarchy:
			transform2.localScale = Vector3.one;
			break;
		}
		particleSystem.gameObject.layer = 0;
		particleSystem.GetComponent<ParticleSystemRenderer>().sharedMaterial = InvisibleMaterial;
		main.duration = Mathf.Max(main.duration, 0.025f);
		Transform transform3 = particleSystem.lights.light.transform;
		for (int i = 0; i < transform2.childCount; i++)
		{
			Transform child = transform2.GetChild(i);
			if (!(child == transform3))
			{
				Object.Destroy(child.gameObject);
			}
		}
	}
}

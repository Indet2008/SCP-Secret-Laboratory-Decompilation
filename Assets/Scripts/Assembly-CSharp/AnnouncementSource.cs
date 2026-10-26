using System;
using System.Collections.Generic;
using MapGeneration;
using PlayerRoles.PlayableScps.Scp079;
using UnityEngine;
using UserSettings;
using UserSettings.AudioSettings;

public class AnnouncementSource : MonoBehaviour
{
	[Serializable]
	private class SourceSettingsPair
	{
		public AudioSource[] Sources;

		public AnimationCurve VolumeOverNormalizedDistance;

		public AnimationCurve SpatialBlendOverNormalizedDistance;

		private float[] _volumeMultipliers;

		public void Init()
		{
			_volumeMultipliers = new float[Sources.Length];
			for (int i = 0; i < Sources.Length; i++)
			{
				_volumeMultipliers[i] = 1f;
			}
		}

		public void SetVolumeScale(AudioSource target, float scale)
		{
			for (int i = 0; i < Sources.Length; i++)
			{
				AudioSource audioSource = Sources[i];
				if ((object)target == audioSource)
				{
					_volumeMultipliers[i] = scale;
					break;
				}
			}
		}

		public void SetDistance(float normalizedDistance)
		{
			float num = VolumeOverNormalizedDistance.Evaluate(normalizedDistance);
			float num2 = SpatialBlendOverNormalizedDistance.Evaluate(normalizedDistance);
			float spread = 360f * (1f - num2);
			for (int i = 0; i < Sources.Length; i++)
			{
				AudioSource obj = Sources[i];
				float num3 = _volumeMultipliers[i];
				obj.spatialBlend = num2;
				obj.spread = spread;
				obj.volume = num * num3;
			}
		}
	}

	private static readonly List<Vector3> AllSpeakerPositions = new List<Vector3>();

	private static readonly List<Vector3> NearbyPositions = new List<Vector3>();

	private static readonly CachedUserSetting<bool> SpatializationSetting = new CachedUserSetting<bool>(OtherAudioSetting.SpatialAnnouncements);

	private static AnnouncementSource _singleton;

	private Transform _tr;

	[SerializeField]
	private float _2dDistance;

	[SerializeField]
	private SourceSettingsPair[] _sources;

	private static Vector3 LastCamPos => MainCameraController.LastPosition;

	private void Awake()
	{
		_tr = base.transform;
		_singleton = this;
		MainCameraController.OnUpdated += OnCamPosUpdated;
		SourceSettingsPair[] sources = _singleton._sources;
		for (int i = 0; i < sources.Length; i++)
		{
			sources[i].Init();
		}
	}

	private void OnDestroy()
	{
		if ((object)_singleton == this)
		{
			_singleton = null;
		}
		MainCameraController.OnUpdated -= OnCamPosUpdated;
	}

	private void OnCamPosUpdated()
	{
		if (!SpatializationSetting.Value)
		{
			_sources.ForEach((SourceSettingsPair x) =>
			{
				x.SetDistance(1f);
			});
			return;
		}
		UpdateNearby();
		Vector3 sourcePos;
		float normalizedDistance;
		switch (NearbyPositions.Count)
		{
		case 0:
			sourcePos = default;
			normalizedDistance = 1f;
			break;
		case 1:
			sourcePos = NearbyPositions[0];
			normalizedDistance = GetNormalizedDistanceToCam(sourcePos);
			break;
		default:
			ResolveMultipleNearbySources(out sourcePos, out normalizedDistance);
			break;
		}
		SetSources(sourcePos, normalizedDistance);
	}

	private void UpdateNearby()
	{
		NearbyPositions.Clear();
		float num = _2dDistance * _2dDistance;
		Vector3 lastCamPos = LastCamPos;
		foreach (Vector3 allSpeakerPosition in AllSpeakerPositions)
		{
			if (!((allSpeakerPosition - lastCamPos).sqrMagnitude > num))
			{
				NearbyPositions.Add(allSpeakerPosition);
			}
		}
	}

	private void ResolveMultipleNearbySources(out Vector3 sourcePos, out float normalizedDistance)
	{
		Vector3 lastCamPos = LastCamPos;
		int count = NearbyPositions.Count;
		Vector3 zero = Vector3.zero;
		float num = float.MaxValue;
		float num2 = 0f;
		for (int i = 0; i < count; i++)
		{
			Vector3 vector = NearbyPositions[i];
			float normalizedDistanceToCam = GetNormalizedDistanceToCam(vector);
			num = Mathf.Min(num, normalizedDistanceToCam);
			float num3 = 1f - normalizedDistanceToCam * normalizedDistanceToCam;
			num2 += num3;
			zero += (vector - lastCamPos) * num3;
		}
		if (num2 < 0.01f)
		{
			sourcePos = default;
			normalizedDistance = 1f;
		}
		else
		{
			Vector3 vector2 = zero / num2;
			sourcePos = vector2 + lastCamPos;
			normalizedDistance = num;
		}
	}

	private void SetSources(Vector3 sourcePos, float normalizedDistance)
	{
		_tr.position = sourcePos;
		SourceSettingsPair[] sources = _sources;
		for (int i = 0; i < sources.Length; i++)
		{
			sources[i].SetDistance(normalizedDistance);
		}
	}

	private float GetNormalizedDistanceToCam(Vector3 pos)
	{
		return Mathf.Clamp01(Vector3.Distance(LastCamPos, pos) / _2dDistance);
	}

	[RuntimeInitializeOnLoadMethod]
	private static void Init()
	{
		SeedSynchronizer.OnGenerationFinished += RefreshPositions;
	}

	private static void RefreshPositions()
	{
		AllSpeakerPositions.Clear();
		foreach (Scp079InteractableBase allInstance in Scp079InteractableBase.AllInstances)
		{
			if (allInstance is Scp079Speaker)
			{
				AllSpeakerPositions.Add(allInstance.Position);
			}
		}
	}

	public static void SetVolumeScale(AudioSource target, float scale)
	{
		if ((object)_singleton != null)
		{
			SourceSettingsPair[] sources = _singleton._sources;
			for (int i = 0; i < sources.Length; i++)
			{
				sources[i].SetVolumeScale(target, scale);
			}
		}
	}
}

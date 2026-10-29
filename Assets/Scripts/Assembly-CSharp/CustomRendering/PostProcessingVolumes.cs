using UnityEngine;
using UnityEngine.Rendering;

namespace CustomRendering
{
	public class PostProcessingVolumes : MonoBehaviour
	{
		private static PostProcessingVolumes _singleton;

		private void Awake()
		{
			if (_singleton != null)
			{
				Object.Destroy(this);
			}
			else
			{
				_singleton = this;
			}
		}

		public static Volume SafeGetVolume(int layer, float priority, VolumeComponent[] settings)
		{
			GameObject gameObject = new GameObject("TemporaryPostProcessVolume");
			if (_singleton != null)
			{
				gameObject.transform.SetParent(_singleton.transform, worldPositionStays: true);
			}
			Volume volume = gameObject.AddComponent<Volume>();
			volume.blendDistance = 1f;
			volume.gameObject.layer = layer;
			volume.priority = priority;
			VolumeProfile volumeProfile = ScriptableObject.CreateInstance<VolumeProfile>();
			volumeProfile.components.AddRange(settings);
			volume.profile = volumeProfile;
			return volume;
		}

		public static void DestroyVolume(Volume volume)
		{
			if (!(volume == null))
			{
				Object.Destroy(volume.gameObject);
			}
		}
	}
}

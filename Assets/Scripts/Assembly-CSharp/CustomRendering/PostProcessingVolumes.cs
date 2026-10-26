using UnityEngine;

namespace CustomRendering
{
	public class PostProcessingVolumes : MonoBehaviour
	{
		private void Awake()
		{
			if (ServerStatic.IsDedicated)
			{
				Object.Destroy(base.gameObject);
			}
		}
	}
}

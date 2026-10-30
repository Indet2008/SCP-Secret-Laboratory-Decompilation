using UnityEngine;

public class VideoRepairer : MonoBehaviour
{
	private void Start()
	{
		Invoke("Repair", 5f);
	}

	private void Repair()
	{
		GetComponent<UnityEngine.Video.VideoPlayer>().targetMaterialProperty = "_EmissionMap";
	}
}

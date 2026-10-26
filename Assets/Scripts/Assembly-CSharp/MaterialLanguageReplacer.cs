using UnityEngine;

public class MaterialLanguageReplacer : MonoBehaviour
{
	public Material englishVersion;

	private void Start()
	{
		GetComponent<Renderer>().material = englishVersion;
	}

	private void OnDestroy()
	{
		Object.Destroy(GetComponent<Renderer>().material);
	}
}

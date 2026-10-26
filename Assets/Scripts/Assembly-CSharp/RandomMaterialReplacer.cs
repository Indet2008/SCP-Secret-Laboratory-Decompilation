using UnityEngine;

public class RandomMaterialReplacer : MonoBehaviour
{
	public Material[] mats;

	private void Start()
	{
		int num = Random.Range(0, mats.Length);
		MeshRenderer[] componentsInChildren = GetComponentsInChildren<MeshRenderer>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].material = mats[num];
		}
	}
}

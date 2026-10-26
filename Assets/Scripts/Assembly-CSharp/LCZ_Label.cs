using System.Collections.Generic;
using UnityEngine;

public class LCZ_Label : MonoBehaviour
{
	public static readonly HashSet<LCZ_Label> AllLabels = new HashSet<LCZ_Label>();

	public MeshRenderer chRend;

	public MeshRenderer numRend;

	private void Awake()
	{
		AllLabels.Add(this);
	}

	private void OnDestroy()
	{
		AllLabels.Remove(this);
	}

	public void Refresh(Material ch, Material num)
	{
		chRend.sharedMaterial = ch;
		numRend.sharedMaterial = num;
	}
}

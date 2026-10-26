using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

public class StackableGradientSky : MonoBehaviour
{
	[ColorUsage(true, true)]
	[SerializeField]
	private Color _top;

	[ColorUsage(true, true)]
	[SerializeField]
	private Color _middle;

	[ColorUsage(true, true)]
	[SerializeField]
	private Color _bottom;

	[SerializeField]
	private float _gradientDiffusion;

	private Volume _volume;

	private static readonly List<StackableGradientSky> ActiveInstances = new List<StackableGradientSky>();

	private float Weight
	{
		get
		{
			if (!_volume.enabled)
			{
				return 0f;
			}
			return _volume.weight;
		}
	}

	public static void GetCombinedColor(out Color top, out Color mid, out Color bottom, out float diffusion)
	{
		top = Color.black;
		mid = Color.black;
		bottom = Color.black;
		diffusion = 1f;
		foreach (StackableGradientSky activeInstance in ActiveInstances)
		{
			float weight = activeInstance.Weight;
			top = Color.Lerp(top, activeInstance._top, weight);
			mid = Color.Lerp(mid, activeInstance._middle, weight);
			bottom = Color.Lerp(bottom, activeInstance._bottom, weight);
			diffusion = Mathf.Lerp(diffusion, activeInstance._gradientDiffusion, weight);
		}
	}

	private void Awake()
	{
		_volume = GetComponent<Volume>();
		for (int i = 0; i < ActiveInstances.Count; i++)
		{
			if (!(_volume.priority > ActiveInstances[i]._volume.priority))
			{
				ActiveInstances.Insert(i, this);
				return;
			}
		}
		ActiveInstances.Add(this);
	}

	private void OnDestroy()
	{
		ActiveInstances.Remove(this);
	}
}

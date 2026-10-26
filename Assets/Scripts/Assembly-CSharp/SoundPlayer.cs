using System.Collections.Generic;
using UnityEngine;

public class SoundPlayer : MonoBehaviour
{
	protected AudioSource _source;

	public CurvePreset[] Curves;

	private readonly Dictionary<FalloffType, CurvePreset> _curves = new Dictionary<FalloffType, CurvePreset>();

	private void Start()
	{
		_source = GetComponent<AudioSource>();
		LoadInspectorCurves();
	}

	protected void LoadInspectorCurves()
	{
		CurvePreset[] curves = Curves;
		foreach (CurvePreset curvePreset in curves)
		{
			if (!_curves.ContainsKey(curvePreset.Type))
			{
				_curves.Add(curvePreset.Type, curvePreset);
			}
		}
	}

	public void Play(AudioClip clip, FalloffType falloff = FalloffType.Linear, float maxDistance = -1f)
	{
		if (_curves.TryGetValue(falloff, out var value))
		{
			_source.SetCustomCurve(AudioSourceCurveType.CustomRolloff, value.FalloffCurve);
			if (maxDistance > 0f)
			{
				_source.maxDistance = maxDistance;
			}
			_source.clip = clip;
			_source.Play();
		}
	}

	public void Stop()
	{
		if (_source.isPlaying)
		{
			_source.Stop();
		}
		_source.clip = null;
	}
}

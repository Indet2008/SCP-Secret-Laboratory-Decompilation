using Decals;
using UnityEngine;

// Restored from the client build (IL2CPP): fresh blood darkens from startColor to endColor over decayTimeSeconds.
public class BloodController : Decal
{
	public float decayTimeSeconds;

	public global::UnityEngine.Color startColor;

	public global::UnityEngine.Color endColor;

	private float _elapsed;

	public override void AttachToSurface(RaycastHit hitSurface)
	{
		base.AttachToSurface(hitSurface);
		_elapsed = 0f;
	}

	private void Update()
	{
		if (decayTimeSeconds <= 0f || _elapsed >= decayTimeSeconds)
		{
			return;
		}
		_elapsed += Time.deltaTime;
		InstancedColor = Color.Lerp(startColor, endColor, Mathf.Clamp01(_elapsed / decayTimeSeconds));
	}
}

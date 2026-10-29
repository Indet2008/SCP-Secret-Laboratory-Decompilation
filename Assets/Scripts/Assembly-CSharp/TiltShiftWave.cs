using CustomPlayerEffects;
using CustomRendering;
using UnityEngine.Rendering;

// Restored from the client build: waves the tilt-shift amount.
public class TiltShiftWave : PostProcessEffectWave
{
	private TiltShift _tiltShift;

	protected override float EffectValue
	{
		get
		{
			return _tiltShift != null ? _tiltShift.Amount.value : 0f;
		}
		set
		{
			if (_tiltShift != null)
			{
				_tiltShift.Amount.Override(value);
			}
		}
	}

	protected override void SetEffectType(VolumeProfile profile)
	{
		if (profile != null)
		{
			profile.TryGet(out _tiltShift);
		}
	}
}

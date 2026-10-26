namespace CameraShaking
{
	public interface IShakeEffect
	{
		bool GetEffect(ReferenceHub ply, out ShakeEffectValues shakeValues);
	}
}

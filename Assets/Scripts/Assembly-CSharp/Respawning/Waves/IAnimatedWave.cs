namespace Respawning.Waves
{
	public interface IAnimatedWave
	{
		float AnimationDuration { get; }

		bool IsAnimationPlaying { get; set; }
	}
}

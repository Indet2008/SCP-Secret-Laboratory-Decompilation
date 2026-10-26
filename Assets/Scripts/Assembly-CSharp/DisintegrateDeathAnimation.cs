using DeathAnimations;

public class DisintegrateDeathAnimation : DeathAnimation
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	[global::UnityEngine.SerializeField]
	private global::UnityEngine.Material _templateMaterial;


	public interface IDisintegrateDamageHandler
	{
		bool Disintegrate { get; }
	}
}

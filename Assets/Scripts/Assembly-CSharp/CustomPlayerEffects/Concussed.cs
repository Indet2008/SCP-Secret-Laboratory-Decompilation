namespace CustomPlayerEffects
{
	public class Concussed : StatusEffectBase, IHealableEffect
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.Tooltip("How much the blur effect will increase between 0 and 1 per 90 degrees camera movement.")]
		public float intensityIncreasePer90Degree;

		[global::UnityEngine.Tooltip("The time based blur factor for decreasing the intensity when not turning the camera")]
		public float intensityDecreaseTimeFactor;


		public bool IsHealable(ItemType it)
		{
			if (it != ItemType.SCP500 && it != ItemType.Adrenaline)
			{
				return it == ItemType.Painkillers;
			}
			return true;
		}
	}
}

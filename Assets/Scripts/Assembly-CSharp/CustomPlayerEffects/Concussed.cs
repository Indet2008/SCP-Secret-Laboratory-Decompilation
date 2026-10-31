using PlayerRoles.Spectating;
namespace CustomPlayerEffects
{
	public class Concussed : StatusEffectBase, IHealableEffect
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.Tooltip("How much the blur effect will increase between 0 and 1 per 90 degrees camera movement.")]
		public float intensityIncreasePer90Degree;

		[global::UnityEngine.Tooltip("The time based blur factor for decreasing the intensity when not turning the camera")]
		public float intensityDecreaseTimeFactor;


		// Client half restored from the client build (IL2CPP): blur grows while the camera turns and decays over time.
		private global::UnityEngine.Quaternion _prevRot;

		private DiminishingLerpVisuals _postProcessBehavior;

		protected override void Awake()
		{
			base.Awake();
			_postProcessBehavior = GetComponent<DiminishingLerpVisuals>();
		}

		protected override void Enabled()
		{
			base.Enabled();
			_prevRot = base.transform.rotation;
		}

		protected override void OnEffectUpdate()
		{
			base.OnEffectUpdate();
			if (base.Hub.isLocalPlayer || base.Hub.IsLocallySpectated())
			{
				global::UnityEngine.Quaternion rotation = base.transform.rotation;
				float num = global::UnityEngine.Mathf.Abs(global::UnityEngine.Quaternion.Dot(_prevRot, rotation));
				float num2 = ((num > 0.999999f) ? 0f : (global::UnityEngine.Mathf.Acos(global::UnityEngine.Mathf.Min(num, 1f)) * 2f * 57.29578f));
				float num3 = num2 / 90f * intensityIncreasePer90Degree;
				float num4 = RainbowTaste.CurrentMultiplier(base.Hub);
				_prevRot = rotation;
				_postProcessBehavior.Intensity -= global::UnityEngine.Time.deltaTime * intensityDecreaseTimeFactor / RainbowTaste.CurrentMultiplier(base.Hub);
				_postProcessBehavior.Intensity += num4 * num3;
			}
		}

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

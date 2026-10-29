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

		private float _blur;

		protected override void Awake()
		{
			base.Awake();
			_postProcessBehavior = GetComponent<DiminishingLerpVisuals>();
		}

		protected override void Enabled()
		{
			base.Enabled();
			_prevRot = base.transform.rotation;
			_blur = 0f;
		}

		protected override void OnEffectUpdate()
		{
			base.OnEffectUpdate();
			if (!IsPOV || _postProcessBehavior == null)
			{
				return;
			}
			global::UnityEngine.Quaternion rot = base.transform.rotation;
			float angle = global::UnityEngine.Quaternion.Angle(_prevRot, rot);
			_prevRot = rot;
			float multiplier = RainbowTaste.CurrentMultiplier(base.Hub);
			_blur += angle / 90f * intensityIncreasePer90Degree * multiplier;
			_blur -= global::UnityEngine.Time.deltaTime * intensityDecreaseTimeFactor;
			_blur = global::UnityEngine.Mathf.Clamp01(_blur);
			_postProcessBehavior.Weight = _blur * multiplier;
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

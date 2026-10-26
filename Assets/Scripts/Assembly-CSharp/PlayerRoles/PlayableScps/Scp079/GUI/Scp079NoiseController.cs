namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079NoiseController : global::PlayerRoles.PlayableScps.Scp079.GUI.Scp079GuiElementBase
	{
		[global::System.Serializable]
		private class NoiseAnimation
		{
			[global::UnityEngine.SerializeField]
			private float _animationSpeed;

			[global::UnityEngine.SerializeField]
			private global::UnityEngine.AnimationCurve _fadeCurve;

			[global::UnityEngine.SerializeField]
			private global::UnityEngine.AnimationCurve _additiveCurve;

			[global::UnityEngine.SerializeField]
			private global::UnityEngine.AnimationCurve _distortionCurve;

			[global::UnityEngine.SerializeField]
			private global::UnityEngine.AnimationCurve _darkenCurve;

			[global::UnityEngine.SerializeField]
			private global::UnityEngine.AnimationCurve _alphaCurve;

			public float PrevValue
			{
				[global::System.Runtime.CompilerServices.CompilerGenerated]
				get
				{
					return default;
				}
				[global::System.Runtime.CompilerServices.CompilerGenerated]
				set
				{
				}
			}

			public void ApplyTowards(global::PlayerRoles.PlayableScps.Scp079.GUI.Scp079NoiseController inst, float target, bool force)
			{
			}

			public void ApplyAnimation(global::PlayerRoles.PlayableScps.Scp079.GUI.Scp079NoiseController inst, float f)
			{
			}

			public NoiseAnimation()
			{
			}
		}

		[global::System.Serializable]
		private struct ZoneSwitchSounds
		{
			public global::UnityEngine.AudioClip Clip;

			public global::MapGeneration.FacilityZone Zone;
		}

		private global::PlayerRoles.PlayableScps.Scp079.Cameras.Scp079CurrentCameraSync _camSync;

		private global::PlayerRoles.PlayableScps.Scp079.Scp079LostSignalHandler _lostSignalHandler;

		private global::CustomRendering.Static _static;

		private global::PlayerRoles.PlayableScps.Scp079.Cameras.Scp079CurrentCameraSync.ClientSwitchState _prevSwitchState;

		private static readonly global::UnityEngine.Color TransparentWhite;

		private static readonly int ColorHash;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioClip _noiseClip;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.Image _darkenImage;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.Scp079.GUI.Scp079NoiseController.ZoneSwitchSounds[] _zoneOverrides;

		[global::UnityEngine.SerializeField]
		private float _pitchVariation;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.Scp079.GUI.Scp079NoiseController.NoiseAnimation _lostSignalAnim;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.Scp079.GUI.Scp079NoiseController.NoiseAnimation _startupAnim;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.Scp079.GUI.Scp079NoiseController.NoiseAnimation _regularSwitchAnim;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.Scp079.GUI.Scp079NoiseController.NoiseAnimation _zoneSwitchAnim;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.CanvasGroup _canvasFader;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.CanvasGroup _zoneSwitchFader;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Material _overconFader;

		public bool FullyDarkened
		{
			get
			{
				return default;
			}
		}

		internal override void Init(global::PlayerRoles.PlayableScps.Scp079.Scp079Role role, ReferenceHub owner)
		{
		}

		private void Update()
		{
		}

		private void UpdateSwitchState()
		{
		}

		public Scp079NoiseController()
		{
		}
	}
}

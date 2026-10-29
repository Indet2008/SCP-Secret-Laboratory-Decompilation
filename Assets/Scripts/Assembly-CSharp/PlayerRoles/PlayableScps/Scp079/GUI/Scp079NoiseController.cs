using System;
using CustomRendering;
using MapGeneration;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.UI;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079NoiseController : Scp079GuiElementBase
	{
		[Serializable]
		private class NoiseAnimation
		{
			[SerializeField]
			private float _animationSpeed;

			[SerializeField]
			private AnimationCurve _fadeCurve;

			[SerializeField]
			private AnimationCurve _additiveCurve;

			[SerializeField]
			private AnimationCurve _distortionCurve;

			[SerializeField]
			private AnimationCurve _darkenCurve;

			[SerializeField]
			private AnimationCurve _alphaCurve;

			public float PrevValue { get; private set; }

			public void ApplyTowards(Scp079NoiseController inst, float target, bool force)
			{
				float num = Mathf.MoveTowards(PrevValue, target, Time.deltaTime * _animationSpeed);
				if (PrevValue != num || force)
				{
					ApplyAnimation(inst, num);
				}
			}

			public void ApplyAnimation(Scp079NoiseController inst, float f)
			{
				if (inst._static != null)
				{
					inst._static.Fade.value = _fadeCurve.Evaluate(f);
					inst._static.FadeAdditive.value = _additiveCurve.Evaluate(f);
					inst._static.FadeDistortion.value = _distortionCurve.Evaluate(f);
				}
				inst._darkenImage.color = new Color(0f, 0f, 0f, Mathf.Clamp01(_darkenCurve.Evaluate(f)));
				float num = _alphaCurve.Evaluate(f);
				inst._overconFader.SetColor(ColorHash, Color.Lerp(TransparentWhite, Color.white, num));
				inst._canvasFader.alpha = num;
				PrevValue = f;
			}
		}

		[Serializable]
		private struct ZoneSwitchSounds
		{
			public AudioClip Clip;

			public FacilityZone Zone;
		}

		private Scp079CurrentCameraSync _camSync;

		private Scp079LostSignalHandler _lostSignalHandler;

		private Static _static;

		private Scp079CurrentCameraSync.ClientSwitchState _prevSwitchState;

		private static readonly Color TransparentWhite = new Color(1f, 1f, 1f, 0f);

		private static readonly int ColorHash = Shader.PropertyToID("_Color");

		[SerializeField]
		private AudioClip _noiseClip;

		[SerializeField]
		private Image _darkenImage;

		[SerializeField]
		private ZoneSwitchSounds[] _zoneOverrides;

		[SerializeField]
		private float _pitchVariation;

		[SerializeField]
		private NoiseAnimation _lostSignalAnim;

		[SerializeField]
		private NoiseAnimation _startupAnim;

		[SerializeField]
		private NoiseAnimation _regularSwitchAnim;

		[SerializeField]
		private NoiseAnimation _zoneSwitchAnim;

		[SerializeField]
		private CanvasGroup _canvasFader;

		[SerializeField]
		private CanvasGroup _zoneSwitchFader;

		[SerializeField]
		private Material _overconFader;

		public bool FullyDarkened => _darkenImage.color.a >= 1f;

		internal override void Init(Scp079Role role, ReferenceHub owner)
		{
			base.Init(role, owner);
			role.SubroutineModule.TryGetSubroutine<Scp079CurrentCameraSync>(out _camSync);
			role.SubroutineModule.TryGetSubroutine<Scp079LostSignalHandler>(out _lostSignalHandler);
			if (base.gameObject.TryGetComponent<Volume>(out var component))
			{
				component.profile.TryGet<Static>(out _static);
			}
			_startupAnim.ApplyAnimation(this, 1f);
		}

		private void Update()
		{
			if (_lostSignalHandler.Lost)
			{
				_regularSwitchAnim.ApplyAnimation(this, 0f);
				_zoneSwitchAnim.ApplyAnimation(this, 0f);
				_lostSignalAnim.ApplyTowards(this, 1f, force: true);
				_zoneSwitchFader.alpha = 0f;
				return;
			}
			UpdateSwitchState();
			_lostSignalAnim.ApplyTowards(this, 0f, force: false);
			if (!Scp079IntroCutscene.IsPlaying)
			{
				_startupAnim.ApplyTowards(this, 0f, force: false);
			}
		}

		private void UpdateSwitchState()
		{
			Scp079CurrentCameraSync.ClientSwitchState curClientSwitchState = _camSync.CurClientSwitchState;
			Scp079CurrentCameraSync.ClientSwitchState prevSwitchState = _prevSwitchState;
			_prevSwitchState = curClientSwitchState;
			switch (curClientSwitchState)
			{
			case Scp079CurrentCameraSync.ClientSwitchState.SwitchingRoom:
				if (prevSwitchState != Scp079CurrentCameraSync.ClientSwitchState.SwitchingRoom)
				{
					PlaySound(_noiseClip, UnityEngine.Random.Range(1f - _pitchVariation, 1f + _pitchVariation));
				}
				_regularSwitchAnim.ApplyTowards(this, 1f, force: true);
				break;
			case Scp079CurrentCameraSync.ClientSwitchState.SwitchingZone:
			{
				_regularSwitchAnim.ApplyTowards(this, 0f, force: true);
				_zoneSwitchAnim.ApplyTowards(this, 1f, force: true);
				_zoneSwitchFader.alpha = _darkenImage.color.a;
				if (prevSwitchState == Scp079CurrentCameraSync.ClientSwitchState.SwitchingZone)
				{
					break;
				}
				ZoneSwitchSounds[] zoneOverrides = _zoneOverrides;
				for (int i = 0; i < zoneOverrides.Length; i++)
				{
					ZoneSwitchSounds zoneSwitchSounds = zoneOverrides[i];
					if (zoneSwitchSounds.Zone == _camSync.CurClientTargetZone)
					{
						PlaySound(zoneSwitchSounds.Clip);
						return;
					}
				}
				PlaySound(_noiseClip);
				break;
			}
			default:
				_regularSwitchAnim.ApplyTowards(this, 0f, force: false);
				_zoneSwitchAnim.ApplyTowards(this, 0f, force: false);
				_zoneSwitchFader.alpha = _zoneSwitchAnim.PrevValue;
				break;
			}
		}
	}
}

using System.Collections.Generic;
using AudioPooling;
using Footprinting;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerStatsSystem;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class SeveredEyes : TickingEffectBase
	{
		public static readonly List<Footprint> AllSeveredEyes = new List<Footprint>();

		private static readonly int HashSeveredEyes = Animator.StringToHash("SeveredEyes");

		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[SerializeField]
		private AudioClip _severClip;

		[SerializeField]
		private AudioClip _severNonDiegeticClip;

		[SerializeField]
		private float _severSoundDistance;

		[SerializeField]
		private GameObject _severedEyesPrefab;

		[SerializeField]
		private float _damagePerTick;

		private AudioPoolSession _severSoundSession;

		public override bool AllowEnabling => true;

		protected override void Enabled()
		{
			base.Enabled();
			AllSeveredEyes.Add(new Footprint(base.Hub));
			Transform transform = base.Hub.transform;
			if (_severedEyesPrefab != null)
			{
				Object.Instantiate(_severedEyesPrefab, transform.position, transform.rotation);
			}
			ChangeEyesState(eyesCut: true);
			AudioSourcePoolManager.PlayOnTransform(_severClip, transform, _severSoundDistance, 1f, (FalloffType)1);
			if (base.IsLocalPlayer || base.IsSpectated)
			{
				_severSoundSession = new AudioPoolSession(AudioSourcePoolManager.Play2D(_severNonDiegeticClip, 1f, (MixerChannel)4));
			}
		}

		protected override void Disabled()
		{
			base.Disabled();
			ChangeEyesState(eyesCut: false);
			CloseSessions();
		}

		public override void OnStopSpectating()
		{
			base.OnStopSpectating();
			CloseSessions();
		}

		private void CloseSessions()
		{
			if (_severSoundSession.SameSession)
			{
				_severSoundSession.Source.Stop();
			}
		}

		// Plays the cut-eyes pose on the third-person model when its animator has the parameter.
		private void ChangeEyesState(bool eyesCut)
		{
			if (base.Hub.roleManager.CurrentRole is IFpcRole fpcRole && fpcRole.FpcModule.CharacterModelInstance is AnimatedCharacterModel animatedCharacterModel && animatedCharacterModel.HasParameter(HashSeveredEyes))
			{
				animatedCharacterModel.Animator.SetBool(HashSeveredEyes, eyesCut);
			}
		}

		protected override void OnTick()
		{
			if (NetworkServer.active)
			{
				base.Hub.playerStats.DealDamage(new UniversalDamageHandler(_damagePerTick, DeathTranslations.Scp1344));
			}
		}
	}
}

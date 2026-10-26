using System;
using System.Collections.Generic;
using AudioPooling;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace InventorySystem.Items.MarshmallowMan
{
	public class MarshmallowAudio : MonoBehaviour
	{
		[SerializeField]
		private AudioClip _holsterClip;

		[SerializeField]
		private AudioClip[] _hitClips;

		[SerializeField]
		private AudioClip[] _swingClips;

		[SerializeField]
		private AudioClip[] _footstepsClips;

		private ushort _trackedSerial;

		private Transform _audioParent;

		private static readonly List<MarshmallowAudio> Instances = new List<MarshmallowAudio>();

		private static bool _eventsSet;

		private const float StandardRange = 15f;

		public void Setup(ushort serial, Transform audioParent)
		{
			_trackedSerial = serial;
			_audioParent = audioParent;
		}

		private void OnEnable()
		{
			if (!_eventsSet)
			{
				SetupEvents();
			}
			Instances.Add(this);
		}

		private void OnDisable()
		{
			Instances.Remove(this);
		}

		private void PlaySound(AudioClip clip, float range)
		{
			Transform trackedTransform = ((_audioParent == null) ? base.transform : _audioParent);
			AudioSourcePoolManager.PlayOnTransform(clip, trackedTransform, range, 1f, FalloffType.Exponential, MixerChannel.NoDucking);
		}

		private static void SetupEvents()
		{
			_eventsSet = true;
			AnimatedCharacterModel.OnFootstepPlayed = (Action<AnimatedCharacterModel, float>)Delegate.Combine(AnimatedCharacterModel.OnFootstepPlayed, new Action<AnimatedCharacterModel, float>(OnFootstepPlayed));
			MarshmallowItem.OnHit += OnHit;
			MarshmallowItem.OnHolsterRequested += OnHolsterRequested;
			MarshmallowItem.OnSwing += OnSwing;
		}

		private static void OnSwing(ushort serial)
		{
			if (TryGetInstance(serial, out var inst))
			{
				inst.PlaySound(inst._swingClips.RandomItem(), 15f);
			}
		}

		private static void OnHolsterRequested(ushort serial)
		{
			if (TryGetInstance(serial, out var inst))
			{
				inst.PlaySound(inst._holsterClip, 15f);
			}
		}

		private static void OnHit(ushort serial)
		{
			if (TryGetInstance(serial, out var inst))
			{
				inst.PlaySound(inst._hitClips.RandomItem(), 15f);
			}
		}

		private static void OnFootstepPlayed(AnimatedCharacterModel model, float loudness)
		{
			if (TryGetInstance(model.OwnerHub.inventory.CurItem.SerialNumber, out var inst) && model.OwnerHub.roleManager.CurrentRole is IFpcRole fpcRole && !(fpcRole.FpcModule.CharacterModelInstance != model))
			{
				inst.PlaySound(inst._footstepsClips.RandomItem(), loudness);
			}
		}

		private static bool TryGetInstance(ushort serial, out MarshmallowAudio inst)
		{
			return Instances.TryGetFirst((MarshmallowAudio x) => x._trackedSerial == serial, out inst);
		}
	}
}

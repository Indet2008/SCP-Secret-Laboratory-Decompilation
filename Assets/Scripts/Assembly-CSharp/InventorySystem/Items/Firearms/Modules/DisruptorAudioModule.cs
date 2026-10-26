using System;
using System.Collections.Generic;
using AudioPooling;
using InventorySystem.Items.Autosync;
using InventorySystem.Items.Firearms.Extensions;
using PlayerRoles;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class DisruptorAudioModule : AudioModule
	{
		private readonly struct TrackedSource
		{
			public readonly AudioPoolSession Session;

			public readonly ushort Serial;

			public TrackedSource(PooledAudioSource src, ushort serial)
			{
				Session = new AudioPoolSession(src);
				Serial = serial;
			}
		}

		[Serializable]
		public struct FiringModeAudio
		{
			public const int TotalClips = 4;

			public const float ActionDistance = 15f;

			public AudioClip ClipActionNormal;

			public AudioClip ClipActionLast;

			public AudioClip ClipFiringNormal;

			public AudioClip ClipFiringLast;

			public readonly void Cache(int startIndex)
			{
				_allClipsGlobalCache[startIndex] = ClipActionNormal;
				_allClipsGlobalCache[startIndex + 1] = ClipActionLast;
				_allClipsGlobalCache[startIndex + 2] = ClipFiringNormal;
				_allClipsGlobalCache[startIndex + 3] = ClipFiringLast;
			}

			public readonly void Play(AudioModule audioModule, bool last)
			{
				audioModule.PlayGunshot(last ? ClipFiringLast : ClipFiringNormal);
				audioModule.PlayCustom(last ? ClipActionLast : ClipActionNormal, MixerChannel.NoDucking, 15f, applyPitch: false);
			}
		}

		private static readonly Queue<TrackedSource> TrackedSources = new Queue<TrackedSource>();

		private static AudioClip[] _allClipsGlobalCache;

		private ItemType _disruptorType;

		[SerializeField]
		private FiringModeAudio _singleShotAudio;

		[SerializeField]
		private FiringModeAudio _rapidFireAudio;

		private AudioClip[] AllClips
		{
			get
			{
				if (_allClipsGlobalCache == null)
				{
					_allClipsGlobalCache = new AudioClip[8];
					_singleShotAudio.Cache(0);
					_rapidFireAudio.Cache(4);
				}
				return _allClipsGlobalCache;
			}
		}

		private void ProcessSound(ItemIdentifier id, PlayerRoleBase role, PooledAudioSource newSource)
		{
			if (id.TypeId != _disruptorType)
			{
				return;
			}
			AudioClip clip = newSource.Source.clip;
			AudioClip[] allClips = AllClips;
			for (int i = 0; i < allClips.Length; i++)
			{
				if (!(allClips[i] != clip))
				{
					newSource.FastTransform.SetParent(null, worldPositionStays: false);
					TrackedSource trackedSource = new TrackedSource(newSource, id.SerialNumber);
					TrackedSources.Enqueue(trackedSource);
					TrackOwner(trackedSource);
					break;
				}
			}
		}

		private void TrackOwner(TrackedSource trackedSource)
		{
			ushort serial = trackedSource.Serial;
			Transform fastTransform = trackedSource.Session.HandledInstance.FastTransform;
			AudioSource source = trackedSource.Session.Source;
			if (BarrelTipExtension.TryFindWorldmodelBarrelTip(serial, out var foundExtension))
			{
				fastTransform.position = foundExtension.WorldspacePosition;
				source.Set3D();
				return;
			}
			foreach (AutosyncItem instance in AutosyncItem.Instances)
			{
				if (instance.ItemSerial == serial)
				{
					source.Set2D();
					return;
				}
			}
			if (InventoryExtensions.TryGetHubHoldingSerial(serial, out var hub))
			{
				fastTransform.position = hub.transform.position;
				source.Set3D();
			}
		}

		protected override void OnInit()
		{
			base.OnInit();
			AllClips.ForEach(base.RegisterClip);
			_disruptorType = base.Firearm.ItemTypeId;
		}

		internal override void OnTemplateReloaded(ModularAutosyncItem template, bool wasEverLoaded)
		{
			base.OnTemplateReloaded(template, wasEverLoaded);
			if (!wasEverLoaded)
			{
				AudioModule.OnSoundPlayed += ProcessSound;
			}
		}

		internal override void TemplateUpdate()
		{
			base.TemplateUpdate();
			int count = TrackedSources.Count;
			for (int i = 0; i < count; i++)
			{
				if (!TrackedSources.TryDequeue(out var result))
				{
					break;
				}
				if (result.Session.SameSession)
				{
					TrackOwner(result);
					TrackedSources.Enqueue(result);
				}
			}
		}

		public void PlayDisruptorShot(bool single, bool last)
		{
			if (single)
			{
				_singleShotAudio.Play(this, last);
			}
			else
			{
				_rapidFireAudio.Play(this, last);
			}
		}

		public void StopDisruptorShot()
		{
			foreach (TrackedSource trackedSource in TrackedSources)
			{
				if (trackedSource.Serial == base.Firearm.ItemSerial && trackedSource.Session.SameSession)
				{
					trackedSource.Session.Source.Stop();
				}
			}
		}
	}
}

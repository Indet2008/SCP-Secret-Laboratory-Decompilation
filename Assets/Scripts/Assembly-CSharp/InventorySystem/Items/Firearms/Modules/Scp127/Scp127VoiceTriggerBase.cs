using System;
using AudioPooling;
using InventorySystem.Items.Pickups;
using Mirror;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using ProgressiveCulling;
using UnityEngine;
using UserSettings;
using UserSettings.AudioSettings;

namespace InventorySystem.Items.Firearms.Modules.Scp127
{
	public abstract class Scp127VoiceTriggerBase : ModuleBase
	{
		public delegate void ServerPlayCallback(Scp127VoiceTriggerBase trigger, Action<NetworkWriter> extraData, AudioClip clip, byte priority);

		public enum VoiceLinePriority : byte
		{
			Low = 0,
			Normal = 1,
			High = 2,
			VeryHigh = 3
		}

		private static readonly CachedUserSetting<float> CachedVolumeSetting = new CachedUserSetting<float>(MixerAudioSettings.VolumeSliderSetting.Scp127Voice);

		private ServerPlayCallback _voicePlayCallback;

		private bool _eventsSet;

		protected virtual float DefaultAudioRange => 12f;

		protected virtual float DefaultAudioVolume => 0.8f;

		protected virtual float DefaultAudioStereo => 0.2f;

		protected virtual MixerChannel DefaultAudioMixerChannel => MixerChannel.DefaultSfx;

		protected virtual bool CheckEnemyLineOfSight => true;

		protected virtual bool RequireFriendship => true;

		protected bool HasFriendship => Scp127VoiceLineManagerModule.HasFriendship(base.ItemSerial, base.Item.Owner);

		protected float UserSettingsVoiceScale => CachedVolumeSetting.Value;

		protected void ServerPlayVoiceLine(AudioClip clip, Action<NetworkWriter> extraData = null, VoiceLinePriority priority = VoiceLinePriority.Normal)
		{
			if (base.IsServer && (!RequireFriendship || HasFriendship))
			{
				if (_voicePlayCallback == null)
				{
					string text = "Attempting to play a voice line on an unregistered Scp127VoiceTriggerBase - '" + base.name + "'.";
					string text2 = "Make sure this component is assigned to a child object of Scp127VoiceLineManagerModule.";
					throw new InvalidOperationException(text + " " + text2);
				}
				_voicePlayCallback(this, extraData, clip, (byte)priority);
			}
		}

		protected void ServerPlayVoiceLineFromCollection(Scp127VoiceLineCollection collection, Action<NetworkWriter> extraData = null, VoiceLinePriority priority = VoiceLinePriority.Normal)
		{
			if (collection.TryGetRandom(base.Firearm.Owner.GetRoleId(), out var voiceLine))
			{
				ServerPlayVoiceLine(voiceLine, extraData, priority);
			}
		}

		protected virtual bool ValidateReceivingOwner(ReferenceHub owner)
		{
			if (!ReferenceHub.TryGetLocalHub(out var hub))
			{
				return false;
			}
			if (CheckEnemyLineOfSight && HitboxIdentity.IsEnemy(hub, owner))
			{
				Vector3 position = owner.GetPosition();
				Vector3 lastCamPosition = CullingCamera.LastCamPosition;
				if (!CullingCamera.CheckBoundsVisibility(new Bounds(position, Vector3.one * 0.05f)))
				{
					return false;
				}
				if (Physics.Linecast(lastCamPosition, position, PlayerRolesUtils.LineOfSightMask))
				{
					return false;
				}
			}
			return true;
		}

		protected virtual void OnDestroy()
		{
			if (_eventsSet)
			{
				_eventsSet = false;
				UnregisterEvents();
			}
		}

		protected virtual bool ValidateReceivingWorldmodel(FirearmWorldmodel worldmodel)
		{
			return true;
		}

		protected virtual void RegisterEvents()
		{
		}

		protected virtual void UnregisterEvents()
		{
		}

		public void RegisterManager(ServerPlayCallback playCallback)
		{
			_voicePlayCallback = playCallback;
			MarkAsSubmodule();
		}

		public virtual void OnFriendshipCreated()
		{
		}

		public virtual AudioPoolSession? OnVoiceLineRequested(ushort serial, AudioClip clip, NetworkReader extraData)
		{
			Transform trackedTransform;
			if (Scp127VoiceLineManagerModule.TryFindOwner(serial, out var owner))
			{
				if (!ValidateReceivingOwner(owner))
				{
					return null;
				}
				trackedTransform = owner.transform;
			}
			else
			{
				if (!FirearmWorldmodel.Instances.TryGetValue(serial, out var value))
				{
					return null;
				}
				if (!ValidateReceivingWorldmodel(value))
				{
					return null;
				}
				trackedTransform = value.transform;
			}
			float volume = DefaultAudioVolume * UserSettingsVoiceScale;
			PooledAudioSource pooledAudioSource = AudioSourcePoolManager.PlayOnTransform(clip, trackedTransform, DefaultAudioRange, volume, FalloffType.Exponential, DefaultAudioMixerChannel);
			pooledAudioSource.Source.panStereo = DefaultAudioStereo;
			return new AudioPoolSession(pooledAudioSource);
		}

		public virtual void OnVoiceLineRejected(ushort serial, AudioClip clip, NetworkReader extraData)
		{
		}

		public abstract bool ContainsAudioClip(AudioClip clip);

		internal override void OnAdded()
		{
			base.OnAdded();
			if (!_eventsSet)
			{
				_eventsSet = true;
				RegisterEvents();
			}
		}

		internal override void OnRemoved(ItemPickupBase pickup)
		{
			base.OnRemoved(pickup);
			if (_eventsSet)
			{
				_eventsSet = false;
				UnregisterEvents();
			}
		}
	}
}

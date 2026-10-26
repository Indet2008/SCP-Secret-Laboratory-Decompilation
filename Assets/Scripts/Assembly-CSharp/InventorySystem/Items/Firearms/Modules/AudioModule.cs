using System;
using System.Collections.Generic;
using AudioPooling;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Modules.Misc;
using InventorySystem.Items.Firearms.Thirdperson;
using Mirror;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using PlayerRoles.Visibility;
using RelativePositioning;
using UnityEngine;
using UnityEngine.Events;

namespace InventorySystem.Items.Firearms.Modules
{
	public class AudioModule : ModuleBase
	{
		private const float SyncMinPitch = 0.3f;

		private const float SyncMaxPitch = 3f;

		private const float NearRange = 5f;

		private const float MidRange = 12f;

		private const float MaxHeightLoudnessSqr = 5000f;

		private const float SendDistanceBuffer = 20f;

		private const float SyncRangeAccuracy = 20f;

		[SerializeField]
		private float _gunshotSoundRandomization;

		[SerializeField]
		private AudioClip[] _eventClips;

		private readonly List<AudioClip> _registeredClips = new List<AudioClip>(64);

		private readonly Dictionary<AudioClip, int> _clipToIndex = new Dictionary<AudioClip, int>();

		[field: SerializeField]
		public float BaseGunshotRange { get; private set; }

		public float FinalGunshotRange => BaseGunshotRange * base.Firearm.AttachmentsValue(AttachmentParam.GunshotLoudnessMultiplier);

		private float RandomPitch
		{
			get
			{
				float gunshotSoundRandomization = _gunshotSoundRandomization;
				float num = UnityEngine.Random.Range(0f - gunshotSoundRandomization, gunshotSoundRandomization);
				return 1f + num;
			}
		}

		public static event Action<ItemIdentifier, PlayerRoleBase, PooledAudioSource> OnSoundPlayed;

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			if (InventoryExtensions.TryGetHubHoldingSerial(serial, out var hub))
			{
				ClientReceiveThirdperson(serial, hub.roleManager.CurrentRole, reader);
			}
		}

		[ExposedFirearmEvent(UnityEventCallState.EditorAndRuntime)]
		public void PlayQuiet(AudioClip clip)
		{
			ProcessEvent(clip, MixerChannel.DefaultSfx, 5f, sync: true, applyPitch: true);
		}

		[ExposedFirearmEvent(UnityEventCallState.EditorAndRuntime)]
		public void PlayNormal(AudioClip clip)
		{
			ProcessEvent(clip, MixerChannel.DefaultSfx, 12f, sync: true, applyPitch: true);
		}

		[ExposedFirearmEvent(UnityEventCallState.EditorAndRuntime)]
		public void PlayClientside(AudioClip clip)
		{
			ProcessEvent(clip, MixerChannel.DefaultSfx, 5f, sync: false, applyPitch: true);
		}

		public void PlayGunshot(AudioClip clip)
		{
			ProcessEvent(clip, MixerChannel.Weapons, FinalGunshotRange, sync: true, applyPitch: false);
		}

		public void PlayCustom(AudioClip clip, MixerChannel channel, float range, bool applyPitch = true)
		{
			ProcessEvent(clip, channel, range, sync: true, applyPitch);
		}

		internal void RegisterClip(AudioClip clip)
		{
			if (!(clip == null) && !_clipToIndex.ContainsKey(clip))
			{
				_registeredClips.Add(clip);
				_clipToIndex[clip] = _registeredClips.Count - 1;
			}
		}

		protected override void OnInit()
		{
			base.OnInit();
			int count = _registeredClips.Count;
			AudioClip[] eventClips = _eventClips;
			foreach (AudioClip audioClip in eventClips)
			{
				_registeredClips.Add(audioClip);
				_clipToIndex[audioClip] = count++;
			}
		}

		private void ProcessEvent(AudioClip clip, MixerChannel mixerChannel, float audioRange, bool sync, bool applyPitch)
		{
			FirearmEvent currentlyInvokedEvent = FirearmEvent.CurrentlyInvokedEvent;
			float num = ((applyPitch && currentlyInvokedEvent != null) ? currentlyInvokedEvent.LastInvocation.ParamSpeed : 1f);
			if (base.HasViewmodel)
			{
				if ((base.IsSpectator & sync) || (base.Firearm.TryGetModule<EventManagerModule>(out var module) && module.SkippingForward))
				{
					return;
				}
				float num2 = num;
				Transform parent;
				if (mixerChannel == MixerChannel.Weapons)
				{
					num2 *= RandomPitch;
					parent = base.Firearm.Owner.transform;
				}
				else
				{
					parent = base.Firearm.ViewModel.transform;
				}
				PooledAudioSource pooledAudioSource = AudioSourcePoolManager.Play2DWithParent(clip, parent, 1f, mixerChannel, num2);
				pooledAudioSource.Source.maxDistance = audioRange;
				OnSoundPlayed?.Invoke(new ItemIdentifier(base.Firearm), base.Firearm.Owner.roleManager.CurrentRole, pooledAudioSource);
			}
			if (base.IsServer && sync && _clipToIndex.TryGetValue(clip, out var value))
			{
				ServerSendToNearbyPlayers(value, mixerChannel, audioRange, num);
			}
		}

		private void ServerSendToNearbyPlayers(int index, MixerChannel channel, float audioRange, float pitch)
		{
			if (!(base.Firearm.Owner.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return;
			}
			float num = audioRange + 20f;
			float num2 = num * num;
			Vector3 ownPos = fpcRole.FpcModule.Position;
			foreach (ReferenceHub receiver in ReferenceHub.AllHubs)
			{
				if (!(receiver == base.Firearm.Owner) && (!(receiver.roleManager.CurrentRole is IFpcRole target) || !(target.SqrDistanceTo(ownPos) > num2)))
				{
					SendRpc(receiver, (NetworkWriter writer) =>
					{
						bool shooterVisible = !(receiver.roleManager.CurrentRole is ICustomVisibilityRole customVisibilityRole) || customVisibilityRole.VisibilityController.ValidateVisibility(base.Firearm.Owner);
						ServerSend(writer, index, pitch, channel, audioRange, ownPos, shooterVisible);
					});
				}
			}
		}

		private void ServerSend(NetworkWriter writer, int index, float pitch, MixerChannel channel, float range, Vector3 shooterPosition, bool shooterVisible)
		{
			writer.WriteByte((byte)index);
			writer.WriteByte((byte)channel);
			writer.WriteUShort(global::Misc.RoundToUShort(range * 20f));
			writer.WriteByte(global::Misc.RoundToByte(Mathf.InverseLerp(0.3f, 3f, pitch) * 255f));
			if (!shooterVisible)
			{
				writer.WriteRelativePosition(new RelativePosition(shooterPosition));
			}
		}

		private void ClientReceiveThirdperson(ushort serial, PlayerRoleBase shooter, NetworkReader reader)
		{
			byte index = reader.ReadByte();
			MixerChannel mixerChannel = (MixerChannel)reader.ReadByte();
			float maxDistance = (float)(int)reader.ReadUShort() / 20f;
			float num = Mathf.Lerp(0.3f, 3f, (float)(int)reader.ReadByte() / 255f);
			if (_registeredClips.TryGet(index, out var element))
			{
				if (mixerChannel == MixerChannel.Weapons)
				{
					num *= RandomPitch;
				}
				PooledAudioSource pooledAudioSource;
				if (shooter is IFpcRole fpcRole && fpcRole.FpcModule.Motor.IsInvisible && reader.Remaining > 0)
				{
					RelativePosition relativePosition = reader.ReadRelativePosition();
					pooledAudioSource = AudioSourcePoolManager.PlayAtPosition(element, relativePosition, maxDistance, 1f, FalloffType.Exponential, mixerChannel, num);
				}
				else
				{
					pooledAudioSource = AudioSourcePoolManager.PlayOnTransform(element, GetAudioSourceParent(mixerChannel, shooter), maxDistance, 1f, FalloffType.Exponential, mixerChannel, num);
				}
				if (mixerChannel == MixerChannel.Weapons)
				{
					float num2 = MainCameraController.CurrentCamera.position.y - pooledAudioSource.FastTransform.position.y;
					float num3 = Mathf.Clamp01(num2 * num2 / 5000f);
					pooledAudioSource.Source.volume *= 1f - num3;
				}
				OnSoundPlayed?.Invoke(new ItemIdentifier(base.Firearm.ItemTypeId, serial), shooter, pooledAudioSource);
			}
		}

		private Transform GetAudioSourceParent(MixerChannel mixerChannel, PlayerRoleBase shooter)
		{
			Transform result = shooter.transform;
			if (mixerChannel == MixerChannel.Weapons || !(shooter is IFpcRole fpcRole))
			{
				return result;
			}
			if (!(fpcRole.FpcModule.CharacterModelInstance is AnimatedCharacterModel animatedCharacterModel))
			{
				return result;
			}
			if (!animatedCharacterModel.TryGetSubcontroller<InventorySubcontroller>(out var subcontroller))
			{
				return result;
			}
			if (!subcontroller.TryGetCurrentInstance(out FirearmThirdpersonItem instance))
			{
				return result;
			}
			return instance.transform;
		}
	}
}

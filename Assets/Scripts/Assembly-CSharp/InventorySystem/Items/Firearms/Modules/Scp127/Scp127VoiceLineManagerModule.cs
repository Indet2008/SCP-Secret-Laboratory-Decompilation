using System;
using System.Collections.Generic;
using AudioPooling;
using InventorySystem.Items.Autosync;
using InventorySystem.Items.Pickups;
using LabApi.Events.Arguments.Scp127Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerStatsSystem;
using Subtitles;
using UnityEngine;
using UnityEngine.Audio;
using Utils.Networking;

namespace InventorySystem.Items.Firearms.Modules.Scp127
{
	public class Scp127VoiceLineManagerModule : ModuleBase
	{
		private readonly struct OwnerPair
		{
			public readonly ushort Serial;

			public readonly ReferenceHub Owner;

			public OwnerPair(ushort serial, ReferenceHub owner)
			{
				Serial = serial;
				Owner = owner;
			}
		}

		private readonly struct ActiveVoiceLine
		{
			public readonly ushort Serial;

			public readonly AudioPoolSession Session;

			public readonly int Priority;

			private readonly AudioMixerGroup _originalMixerGroup;

			private readonly float _originalVolumeScale;

			private readonly float _originalStereoPan;

			private static AudioMixerGroup ViewmodelMixerGroup => AudioSourcePoolManager.GetMixerGroup(MixerChannel.Scp127VoiceViewmodel);

			public ActiveVoiceLine(ushort serial, AudioPoolSession session, int priority)
			{
				Serial = serial;
				Session = session;
				Priority = priority;
				AudioSource source = Session.Source;
				_originalVolumeScale = source.volume;
				_originalStereoPan = source.panStereo;
				_originalMixerGroup = source.outputAudioMixerGroup;
				GetDesiredSourceSettings(out var volume, out var stereo, out var is3D, out var mixerChannel);
				source.volume = volume;
				source.panStereo = stereo;
				source.SetSpace(is3D);
				source.outputAudioMixerGroup = mixerChannel;
			}

			public void UpdateActive()
			{
				GetDesiredSourceSettings(out var volume, out var stereo, out var is3D, out var mixerChannel);
				AudioSource source = Session.Source;
				if (source.spatialBlend == 1f != is3D)
				{
					source.SetSpace(is3D);
					source.volume = volume;
					source.panStereo = stereo;
					source.outputAudioMixerGroup = mixerChannel;
				}
				else
				{
					float maxDelta = Time.deltaTime * 0.4f;
					source.volume = Mathf.MoveTowards(source.volume, volume, maxDelta);
					source.panStereo = Mathf.MoveTowards(source.panStereo, stereo, maxDelta);
				}
			}

			private void GetDesiredSourceSettings(out float volume, out float stereo, out bool is3D, out AudioMixerGroup mixerChannel)
			{
				GetInstanceStatus(out is3D, out var isHolstered);
				if (isHolstered)
				{
					volume = _originalVolumeScale * 0.75f;
					stereo = (is3D ? _originalStereoPan : 0.5f);
				}
				else
				{
					volume = _originalVolumeScale;
					stereo = _originalStereoPan;
				}
				mixerChannel = (is3D ? _originalMixerGroup : ViewmodelMixerGroup);
			}

			private void GetInstanceStatus(out bool is3D, out bool isHolstered)
			{
				if (TryFindOwner(Serial, out var owner))
				{
					ItemIdentifier curItem = owner.inventory.CurItem;
					isHolstered = curItem.SerialNumber != Serial;
					is3D = !owner.IsPOV;
				}
				else
				{
					is3D = true;
					isHolstered = false;
				}
			}
		}

		private enum RpcType
		{
			OwnerRegistered = 0,
			PlayLine = 1
		}

		private const float HolsteredStereoPanning = 0.5f;

		private const float HolsteredVolumeScale = 0.75f;

		private const float HolsteredAdjustSpeed = 0.4f;

		private const float SubtitleSourceRangeScale = 0.5f;

		public static readonly Dictionary<ushort, HashSet<uint>> FriendshipMemory = new Dictionary<ushort, HashSet<uint>>();

		private static readonly List<ActiveVoiceLine> ActiveVoiceLines = new List<ActiveVoiceLine>();

		private static readonly List<OwnerPair> Scp127Owners = new List<OwnerPair>();

		[SerializeField]
		private Scp127VoiceLineDatabase _database;

		private Scp127VoiceTriggerBase[] _foundTriggers;

		public static event Action<Firearm> OnServerVoiceLineSent;

		public static event Action<ReferenceHub> OnBeforeFriendshipReset;

		internal override void OnClientReady()
		{
			base.OnClientReady();
			Scp127Owners.Clear();
			ActiveVoiceLines.Clear();
		}

		protected override void OnInit()
		{
			base.OnInit();
			_foundTriggers = GetComponentsInChildren<Scp127VoiceTriggerBase>();
			Scp127VoiceTriggerBase[] foundTriggers = _foundTriggers;
			for (int i = 0; i < foundTriggers.Length; i++)
			{
				foundTriggers[i].RegisterManager(ServerSendVoiceLine);
			}
		}

		internal override void OnTemplateReloaded(ModularAutosyncItem template, bool wasEverLoaded)
		{
			base.OnTemplateReloaded(template, wasEverLoaded);
			_database.SetIndexing(force: true);
			if (!wasEverLoaded)
			{
				ItemPickupBase.OnBeforePickupDestroyed += OnAnyPickupDestroyed;
				FirearmWorldmodel.OnSetup += OnAnyWorldmodelSetup;
				ReferenceHub.OnBeforePlayerDestroyed += RemoveOwner;
				PlayerStats.OnAnyPlayerDied += OnAnyPlayerDied;
			}
		}

		internal override void OnAdded()
		{
			base.OnAdded();
			if (base.IsServer)
			{
				SendRpc((NetworkWriter x) =>
				{
					x.WriteSubheader(RpcType.OwnerRegistered);
					x.WriteReferenceHub(base.Firearm.Owner);
				});
			}
		}

		internal override void OnEquipped()
		{
			base.OnEquipped();
			if (base.IsServer && FriendshipMemory.GetOrAddNew(base.ItemSerial).Add(base.Item.Owner.netId))
			{
				Scp127VoiceTriggerBase[] foundTriggers = _foundTriggers;
				for (int i = 0; i < foundTriggers.Length; i++)
				{
					foundTriggers[i].OnFriendshipCreated();
				}
			}
		}

		internal override void TemplateUpdate()
		{
			base.TemplateUpdate();
			for (int num = ActiveVoiceLines.Count - 1; num >= 0; num--)
			{
				ActiveVoiceLine activeVoiceLine = ActiveVoiceLines[num];
				AudioPoolSession session = activeVoiceLine.Session;
				if (session.SameSession && session.IsPlaying)
				{
					activeVoiceLine.UpdateActive();
				}
				else
				{
					ActiveVoiceLines.RemoveAt(num);
				}
			}
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			switch ((RpcType)reader.ReadByte())
			{
			case RpcType.OwnerRegistered:
			{
				if (reader.TryReadReferenceHub(out var hub))
				{
					SetOwnerTracking(hub, serial);
				}
				break;
			}
			case RpcType.PlayLine:
			{
				byte index = reader.ReadByte();
				byte translation = reader.ReadByte();
				byte priority = reader.ReadByte();
				if (_foundTriggers.TryGet(index, out var element) && _database.TryGetClip((Scp127VoiceLinesTranslation)translation, out var clip))
				{
					ClientProcessVoiceLineRequest(serial, element, clip, priority, reader);
				}
				break;
			}
			}
		}

		public bool TryFindVoiceLine(Scp127VoiceLinesTranslation line, out Scp127VoiceTriggerBase trigger, out AudioClip clip)
		{
			trigger = null;
			if (!_database.TryGetClip(line, out clip))
			{
				return false;
			}
			Scp127VoiceTriggerBase[] foundTriggers = _foundTriggers;
			foreach (Scp127VoiceTriggerBase scp127VoiceTriggerBase in foundTriggers)
			{
				if (scp127VoiceTriggerBase.ContainsAudioClip(clip))
				{
					trigger = scp127VoiceTriggerBase;
					return true;
				}
			}
			return false;
		}

		public void ServerSendVoiceLine(Scp127VoiceTriggerBase trigger, Action<NetworkWriter> extraData, AudioClip clip, byte priority)
		{
			if (!TryGetTriggerIndexAndClip(trigger, clip, out var triggerIndex, out var entry))
			{
				return;
			}
			Scp127VoiceLinesTranslation voiceLine = entry.Translation;
			Scp127TalkingEventArgs e = new Scp127TalkingEventArgs(base.Firearm, voiceLine, (Scp127VoiceTriggerBase.VoiceLinePriority)priority);
			Scp127Events.OnTalking(e);
			if (!e.IsAllowed)
			{
				return;
			}
			if (e.VoiceLine != voiceLine)
			{
				if (!TryFindVoiceLine(e.VoiceLine, out trigger, out clip))
				{
					ServerConsole.AddLog("Unable to change voiceline argument for the Scp127TalkingEventArgs as the target voiceline was not found!", ConsoleColor.Red);
					return;
				}
				if (!TryGetTriggerIndexAndClip(trigger, clip, out triggerIndex, out entry))
				{
					return;
				}
				priority = (byte)e.Priority;
				voiceLine = entry.Translation;
			}
			SendRpc((NetworkWriter writer) =>
			{
				writer.WriteSubheader(RpcType.PlayLine);
				writer.WriteByte((byte)triggerIndex);
				writer.WriteByte((byte)voiceLine);
				writer.WriteByte(priority);
				extraData?.Invoke(writer);
			});
			OnServerVoiceLineSent?.Invoke(base.Firearm);
			Scp127Events.OnTalked(new Scp127TalkedEventArgs(base.Firearm, voiceLine, (Scp127VoiceTriggerBase.VoiceLinePriority)priority));
		}

		private bool TryGetTriggerIndexAndClip(Scp127VoiceTriggerBase trigger, AudioClip clip, out int index, out Scp127VoiceLineDatabase.VoiceEntry entry)
		{
			index = _foundTriggers.IndexOf(trigger);
			if (index < 0)
			{
				Debug.LogError("Unregistered Trigger: " + trigger.name);
				entry = null;
				return false;
			}
			if (!_database.TryGetEntry(clip, out entry))
			{
				Debug.LogError("Unregistered Voice Line: " + clip.name);
				return false;
			}
			return true;
		}

		private void OnAnyPickupDestroyed(ItemPickupBase pickup)
		{
			if (!(pickup is FirearmPickup firearmPickup) || firearmPickup.ItemId.TypeId != base.Firearm.ItemTypeId)
			{
				return;
			}
			Transform transform = firearmPickup.Worldmodel.transform;
			foreach (ActiveVoiceLine activeVoiceLine in ActiveVoiceLines)
			{
				PooledAudioSource handledInstance = activeVoiceLine.Session.HandledInstance;
				if (!(handledInstance.FastTransform.parent != transform))
				{
					handledInstance.FastTransform.SetParent(null);
				}
			}
		}

		private void OnAnyWorldmodelSetup(FirearmWorldmodel worldmodel)
		{
			if (worldmodel.WorldmodelType == FirearmWorldmodelType.Pickup && worldmodel.Identifier.TypeId == base.Firearm.ItemTypeId)
			{
				SetPickupTracking(worldmodel);
			}
		}

		private void ClientProcessVoiceLineRequest(ushort serial, Scp127VoiceTriggerBase trigger, AudioClip voiceLine, int priority, NetworkReader extraData)
		{
			foreach (ActiveVoiceLine activeVoiceLine in ActiveVoiceLines)
			{
				if (activeVoiceLine.Serial == serial && activeVoiceLine.Priority >= priority && _database.IsStillPlaying(activeVoiceLine.Session))
				{
					trigger.OnVoiceLineRejected(serial, voiceLine, extraData);
					return;
				}
			}
			AudioPoolSession? audioPoolSession = trigger.OnVoiceLineRequested(serial, voiceLine, extraData);
			if (!audioPoolSession.HasValue)
			{
				return;
			}
			foreach (ActiveVoiceLine activeVoiceLine2 in ActiveVoiceLines)
			{
				if (activeVoiceLine2.Serial == serial)
				{
					activeVoiceLine2.Session.Source.Stop();
				}
			}
			ActiveVoiceLines.Add(new ActiveVoiceLine(serial, audioPoolSession.Value, priority));
			TryPlaySubtitle(_database, audioPoolSession.Value);
		}

		public static bool TryFindOwner(ushort serial, out ReferenceHub owner)
		{
			foreach (OwnerPair scp127Owner in Scp127Owners)
			{
				if (scp127Owner.Serial == serial)
				{
					owner = scp127Owner.Owner;
					return true;
				}
			}
			owner = null;
			return false;
		}

		public static bool HasFriendship(ushort serial, ReferenceHub player)
		{
			if (FriendshipMemory.TryGetValue(serial, out var value))
			{
				return value.Contains(player.netId);
			}
			return false;
		}

		private static bool TryPlaySubtitle(Scp127VoiceLineDatabase database, AudioPoolSession session)
		{
			AudioSource source = session.Source;
			AudioClip clip = source.clip;
			if (clip == null)
			{
				return false;
			}
			if (source.volume == 0f)
			{
				return false;
			}
			if (!database.TryGetEntry(clip, out var entry))
			{
				return false;
			}
			Transform fastTransform = session.HandledInstance.FastTransform;
			Vector3 vector = MainCameraController.LastPosition - fastTransform.position;
			float num = source.maxDistance * 0.5f;
			float num2 = num * num;
			if (vector.sqrMagnitude > num2)
			{
				return false;
			}
			Scp127SubtitleCategory.PlayLine(entry);
			return true;
		}

		private static void SetPickupTracking(FirearmWorldmodel pickup)
		{
			ushort serialNumber = pickup.Identifier.SerialNumber;
			for (int i = 0; i < Scp127Owners.Count; i++)
			{
				if (Scp127Owners[i].Serial == serialNumber)
				{
					Scp127Owners.RemoveAt(i);
					break;
				}
			}
			SetTracking(serialNumber, pickup.transform);
		}

		private static void SetOwnerTracking(ReferenceHub owner, ushort serial)
		{
			SetTracking(serial, owner.transform);
			OwnerPair item = new OwnerPair(serial, owner);
			Scp127Owners.Add(item);
		}

		private static void SetTracking(ushort serial, Transform parent)
		{
			foreach (ActiveVoiceLine activeVoiceLine in ActiveVoiceLines)
			{
				if (activeVoiceLine.Serial == serial)
				{
					AudioPoolSession session = activeVoiceLine.Session;
					if (session.SameSession)
					{
						Transform fastTransform = session.HandledInstance.FastTransform;
						fastTransform.SetParent(parent);
						fastTransform.ResetLocalPosition();
					}
				}
			}
		}

		private static void RemoveOwner(ReferenceHub owner)
		{
			for (int num = Scp127Owners.Count - 1; num >= 0; num--)
			{
				OwnerPair ownerPair = Scp127Owners[num];
				if (ownerPair.Owner.netId == owner.netId)
				{
					Scp127Owners.RemoveAt(num);
					SetTracking(ownerPair.Serial, null);
				}
			}
		}

		private static void OnAnyPlayerDied(ReferenceHub hub, DamageHandlerBase dhb)
		{
			OnBeforeFriendshipReset?.Invoke(hub);
			foreach (KeyValuePair<ushort, HashSet<uint>> item in FriendshipMemory)
			{
				item.Value.Remove(hub.netId);
			}
		}
	}
}
